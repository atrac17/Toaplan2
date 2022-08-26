/*
* <-- pr4m0d -->
* https://pram0d.com
* https://twitter.com/pr4m0d
* https://github.com/psomashekar
*
* Copyright (c) 2022 Pramod Somashekar
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
module snowbro2_clock (
    input CLK, //48mhz
    input CLK96,
    output reg CEN675,
    output CEN675B,
    output CEN2p7,
    output CEN2p7B,
    output reg CEN3p375,
    output CEN3p375B,
    output reg CEN1p6875,
    output CEN1p6875B,
    output reg CEN1350,
    output CEN1350B
);

//Video
// 13.50mhz for GP9001, then half clocked
reg [31:0] vid_counter;
always @(posedge CLK96)
        { CEN1350, vid_counter } <= vid_counter + 32'd603979776;

// 6.75mhz for GP9001, half clocked
reg [31:0] vid2_counter;
always @(posedge CLK96)
       { CEN675, vid2_counter } <= vid2_counter + 32'd301989888;

//Audio
// 3.375mhz for ym2151 (SNOWBRO2)
reg [31:0] aud_counter;
always @(posedge CLK96)
        { CEN3p375, aud_counter } <= aud_counter + 32'd150994944;

// ym2151 3.375mhz, half clock for audio pause (SNOWBRO2)
reg [31:0] aud2_counter;
always @(posedge CLK96)
        { CEN1p6875, aud2_counter } <= aud2_counter + 32'd75497472;

// 2.7mhz oki (SNOWBRO2)
// 96*(9/320) == 2.7
// reg [31:0] oki_counter;
// always @(posedge CLK96)
//         { CEN2p7, oki_counter } <= oki_counter + 32'd120795955;
jtframe_frac_cen u_frac_cen_27(
    .clk(CLK96),
    .n(9),
    .m(320),
    .cen(CEN2p7),
    .cenb(CEN2p7B)
);

endmodule