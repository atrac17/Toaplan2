/*
* <-- pr4m0d -->
* https://pram0d.com
* https://twitter.com/pr4m0d
* https://github.com/psomashekar
*
* Copyright (c) 2022 Pramod Somashekar
*
* <-- atrac17 -->
* https://coinopcollection.org
* https://twitter.com/_atrac17
* https://github.com/atrac17
*
* Copyright (c) 2022 atrac17
*
* This program is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/
module pipibibs_sound (
    input                CLK,
    input                CLK96,
    input                RESET,
    input                RESET96,
    input                YM3812_CEN,
    input                Z80_CEN,

    output reg           ROMZ80_CS,
    input                ROMZ80_OK,
    output reg    [14:0] ROMZ80_ADDR,
    input          [7:0] ROMZ80_DOUT,
    input                addr,
    output signed [15:0] left,
    output signed [15:0] right,
    output               sample,
    output reg           peak,
    // combined output
    output signed [15:0] snd,

    input                YM3812_CS,
    input                YM3812_WE,
    input                YM3812_WR_CMD,
    input          [7:0] YM3812_DIN,
    output         [7:0] YM3812_DOUT,

    //interface with m68k
    output        [10:0] SRAM_ADDR,
    input          [7:0] SRAM_DATA,
    output         [7:0] SRAM_DIN,
    output               SRAM_WE,

    input          [7:0] GAME,
    input          [1:0] FX_LEVEL,
    input          [1:0] FM_LEVEL,
    input                PSG_EN,
    input                FM_EN,
    input                DIP_PAUSE
);

localparam PIPIBIBS = 'h3;

wire signed [15:0] fm_left;
wire signed [15:0] fm_right;
wire peak_l;
wire peak_r;

//debugging 
wire debug = 1'b1;
integer fd;

`ifdef SIMULATION
 initial fd = $fopen("logsound.txt", "w");
`endif

reg [7:0] fmgain;

always @(posedge CLK96, posedge RESET96) begin
    if(RESET96) begin
        fmgain<=0;
    end else begin
        case( FM_LEVEL )
            0: fmgain <= 8'h08 ;   // 50%
            1: fmgain <= 8'h04 ;   // 25%
            2: fmgain <= 8'h10 ;   // 100% aka Default
            3: fmgain <= 8'h0c ;   // 75%
        endcase
    end
end

always @(posedge CLK96) begin
    peak <= peak_l | peak_r;
end

reg [7:0] gain1;
reg signed [15:0] final_left;
reg signed [15:0] final_right;

always @(posedge CLK96) begin
    final_left<=fm_left;
    final_right<=fm_right;
end

assign right = left;
assign fm_right = fm_left;
assign peak_r = peak_l;

jtframe_mixer #(.W0(16), .W1(14), .W2(16), .WOUT(16)) u_mix_left(
    .rst    ( RESET96                ),
    .clk    ( CLK96                  ),
    .cen    ( 1'b1                   ),
    // input signals
    .ch0    ( final_left             ),
    .ch1    ( 16'd0                  ),
    .ch2    ( final_right            ),
    .ch3    ( 16'd0                  ),
    // gain for each channel in 4.4 fixed point format
    .gain0  ( FM_EN ? fmgain : 16'd0 ),
    .gain1  ( 8'd0                   ),
    .gain2  ( FM_EN ? fmgain : 16'd0 ),
    .gain3  ( 8'd0                   ),
    .mixed  ( left                   ),
    .peak   ( peak_l                 )
);

wire cpu_cen;
wire opl_irq_n;
wire m1_n, iorq_n, mreq_n;
wire rd_n;
wire wr_n, WRn;
wire [15:0] A;
reg [7:0] din;
wire [7:0] dout;
wire io_cs = !iorq_n;

//io
wire nmi_n = 1'b1;
reg ymsnd_sel_reg,
    ymsnd_rd,
    ymsnd_wr;
wire ym_cs = ( A == 16'hE000 || A == 16'hE001 );
wire ym_we = ym_cs && !wr_n;

//address bus
reg ram_cs;
always @(posedge CLK96) begin
    if(RESET96) begin
        ymsnd_rd <= 0;
        ymsnd_wr <= 0;
        ram_cs <= 0;
        ROMZ80_CS <= 0;
        ROMZ80_ADDR<=0;
    end else begin
        ymsnd_rd <= !rd_n && ym_cs;
        ymsnd_wr <= !wr_n && ym_cs;
        ram_cs <= !mreq_n && A[15:11] == 5'b10000; //0x8000 to 0x87ff
        ROMZ80_CS <= !mreq_n && !rd_n && A<='h7FFF;
        ROMZ80_ADDR<=A;
    end
end

//RAM assignments
assign SRAM_WE = ram_cs && !wr_n;
assign SRAM_DIN = dout;
assign SRAM_ADDR = A[10:0];
wire [7:0] fm0_dout;
reg [7:0] fm_din;

always @(posedge CLK96) begin
    if(RESET96) begin
    end else begin
        //to z80
        case(1'b1)
            ROMZ80_CS: din <= ROMZ80_DOUT;
            (ram_cs && !rd_n): din <= SRAM_DATA;
            ymsnd_rd: din <= fm0_dout;
            default: din <= 8'hFF;
        endcase
    end
end

jtframe_z80_romwait u_cpu(
    .rst_n      ( ~RESET96  ),
    .clk        ( CLK96     ),
    .cen        ( Z80_CEN   ), // 3.375mhz
    .cpu_cen    ( cpu_cen   ),
    .int_n      ( opl_irq_n ), // opl2 interrupt
    .nmi_n      ( nmi_n     ),
    .busrq_n    ( 1'b1      ),
    .m1_n       ( m1_n      ),
    .mreq_n     ( mreq_n    ),
    .iorq_n     ( iorq_n    ),
    .rd_n       ( rd_n      ),
    .wr_n       ( wr_n      ),
    .rfsh_n     (           ),
    .halt_n     (           ),
    .busak_n    (           ),
    .A          ( A         ),
    .din        ( din       ),
    .dout       ( dout      ),
    // manage access to ROM data from SDRAM
    .rom_cs     ( ROMZ80_CS ),
    .rom_ok     ( ROMZ80_OK )
);

jtopl2 u_base(
    .rst        ( RESET96                ),   // reset
    .clk        ( CLK96                  ),   // main clock
    .cen        ( YM3812_CEN & DIP_PAUSE ),   // 3.375mhz
    .din        ( dout                   ),   // data in
    .addr       ( A[0]                   ),   // z80 address
    .cs_n       ( !ym_cs                 ),   // chip select
    .wr_n       ( !ymsnd_wr              ),   // write
    .dout       ( fm0_dout               ),   // data out
    .irq_n      ( opl_irq_n              ),   // opl2 interrupt
    // Low resolution output (same as real chip)
    .snd        ( fm_left                ),   // mono output, see mixer
    .sample     ( sample                 )    // marks new output sample
);

endmodule