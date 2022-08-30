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
    input CLK24,
    input CLK6,
    output CEN675,
    output CEN675B,
    output CEN2p7,
    output CEN2p7B,
    output CEN3p375,
    output CEN3p375B,
    output CEN1p6875,
    output CEN1p6875B,
    output CEN1350,
    output CEN1350B
);

jtframe_frac_cen #(.W(4)) u_frac_cen_1350(
    .clk(CLK96),
    .n(1),
    .m(7),
    .cen({CEN1p6875, CEN3p375, CEN675, CEN1350}),
    .cenb()
);

jtframe_frac_cen u_frac_cen_27(
    .clk(CLK96),
    .n(1),
    .m(35),
    .cen(CEN2p7),
    .cenb(CEN2p7B)
);

endmodule