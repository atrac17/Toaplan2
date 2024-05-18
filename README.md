# Toaplan Version 2 FPGA Implementation

FPGA compatible cores of Toaplan Version 2 arcade hardware titles for [**MiSTerFPGA**](https://github.com/MiSTer-devel/Main_MiSTer/wiki) and [**OpenFPGA**](https://github.com/open-fpga) written by [**atrac17**](https://github.com/atrac17). Based on the [**Raizing FPGA**](https://github.com/psomashekar/Raizing_FPGA) implementation by Pramod Somashekar.

Implementation references TP-023 schematics and verified against Teki Paki (TP-020), Dogyūn!! (TP-022), Knuckle Bash (TP-023), Tatsujin Ō (TP-024), FixEight (TP-026) and Batsugun (TP-030).

The intent is for these cores to be a 1:1 playable implementation of Toaplan V2 hardware titles. Currently in beta state and in active development.

![Toaplan_logo_shadow_small](https://user-images.githubusercontent.com/32810066/151543842-5f7380a4-9b29-472d-bc03-8cc04a579cf2.png)

## Supported Titles

| Title                                                                                              | PCB<br>Number | Encrypted<br>Program | Secondary<br>CPU | CPU<br>Usage | Status          | Released |
|----------------------------------------------------------------------------------------------------|---------------|----------------------|------------------|--------------|-----------------|----------|
| [**Teki Paki**](https://en.wikipedia.org/wiki/Teki_Paki)                                           | TP-020        | No                   | HD647180         | Audio        | Implemented     | 20240511 |
| [**Ghox**](https://en.wikipedia.org/wiki/Ghox)                                                     | TP-021        | No                   | HD647180         | Audio & I/O  | WIP             | -        |
| [**Dogyūn!! (Test Location)**](https://en.wikipedia.org/wiki/Dogyuun)                              | TX-022        | Yes                  | Z80              | Audio        | WIP             | -        |
| [**Dogyūn!!**](https://en.wikipedia.org/wiki/Dogyuun)                                              | TP-022        | Yes                  | NEC V25          | Audio        | -               | -        |
| [**Knuckle Bash**](https://en.wikipedia.org/wiki/Knuckle_Bash)                                     | TP-023        | Yes                  | NEC V25          | Audio        | -               | -        |
| [**Tatsujin Ō**](https://en.wikipedia.org/wiki/Truxton_II)                                         | TP-024        | No                   | -                | N/A          | Implemented     | 20220819 |
| [**Whoopee!!**](https://en.wikipedia.org/wiki/Pipi_%26_Bibi's)                                     | TP-025        | No                   | Z80              | N/A          | Implemented     | 20221225 |
| [**FixEight**](https://en.wikipedia.org/wiki/FixEight)                                             | TP-026        | No                   | NEC V25          | Audio & I/O  | -               | -        |
| [**V-V**](https://en.wikipedia.org/wiki/Grind_Stormer)                                             | TP-027        | Yes                  | NEC V25          | Audio        | -               | -        |
| [**Batsugun**](https://en.wikipedia.org/wiki/Batsugun)                                             | TP-030        | No                   | NEC V25          | Audio        | -               | -        |
| [**Otenki Paradise: Snow Bros. 2**](https://en.wikipedia.org/wiki/Snow_Bros._2:_With_New_Elves)    | TP-033        | No                   | -                | N/A          | Implemented     | 20220904 |

## External Modules

| Module                                                        | Function                                                                     | Author                                                       |
|---------------------------------------------------------------|------------------------------------------------------------------------------|--------------------------------------------------------------|
| [**fx68k**](https://github.com/ijor/fx68k)                    | [**Motorola 68000 CPU**](https://en.wikipedia.org/wiki/Motorola_68000)       | Jorge Cwik                                                   |
| [**t80**](https://opencores.org/projects/t80)                 | [**Zilog Z80 CPU**](https://en.wikipedia.org/wiki/Zilog_Z80)                 | Daniel Wallner                                               |
| [**jt51**](https://github.com/jotego/jt51)                    | [**Yamaha YM2151**](https://en.wikipedia.org/wiki/Yamaha_YM2151)             | Jose Tejada Gomez                                            |
| [**jt6295**](https://github.com/jotego/jt6295)                | [**OKI MSM6295**](https://dtsheet.com/doc/957023/oki-m6295)                  | Jose Tejada Gomez                                            |
| [**jtopl2**](https://github.com/jotego/jtopl)                 | [**Yamaha OPL 2**](https://en.wikipedia.org/wiki/Yamaha_OPL#OPL2)            | Jose Tejada Gomez                                            |
| [**jtframe**](https://github.com/jotego/jtframe)              | [**FPGA Framework**](https://github.com/jotego/jtframe)                      | Jose Tejada Gomez; modified by Pramod Somashekar and atrac17 |
| [**GP9001**](https://gamerepair.info/parts/77_toaplan_gp9001) | [**Toaplan Graphics ASIC**](https://gamerepair.info/parts/77_toaplan_gp9001) | Pramod Somashekar                                            |

# Known Issues

- Sprite mux priority on explosions TP-020 / TP-025 [**Issue**]  
- JT6295 [phrase command playback](https://github.com/jotego/jt6295?tab=readme-ov-file#architecture) not implemented; results in playback issues for TP-024 [**Issue**]  

# PCB Check List

## Clock Information

H-Sync    | V-Sync    | Source    | PCB Number              |
----------|-----------|-----------|-------------------------|
15.625kHz | 59.637404 | DSLogic + | All Toaplan V2 Hardware |

## Crystal Oscillators

<table>
<tr>
<th>TP-020 (Teki Paki)</th>
<th>TP-021 (Ghox)</th>
</tr>
<tr>
<td>
  
Freq (MHz) | Use                          |
-----------|------------------------------|
10.000 MHz | M68000 / Z180 (Hardware)     |
27.000 MHz | GP9001 / YM3812 / Z80 (FPGA) |
  
</td>
<td>
  
Freq (MHz) | Use             |
-----------|-----------------|
10.000 MHz | M68000 / Z180   |
27.000 MHz | GP9001 / YM2151 |
  
</td>
</tr>
</table>

<table>
<tr>
<th>TX-022 (Dogyūn!! - Dogyuun)</th>
<th>TP-024 (Tatsujin Oh-Truxton II)</th>
</tr>
<tr>
<td>
  
Freq (MHz) | Use                   |
-----------|-----------------------|
24.000 MHz | M68000                |
27.000 MHz | GP9001 / YM2151 / Z80 |
 1.056 Mhz | OKI MSM6295           |
  
</td>
<td>
  
Freq (MHz) | Use                  |
-----------|----------------------|
16.000 MHz | M68000 / OKI MSM6295 |
27.000 MHz | GP9001 / YM2151      |
  
</td>
</tr>
</table>

<table>
<tr>
<th>TP-025 (Whoopee!! - Pipi & Bibi's)</th>
<th>TP-033 (Otenki Paradise: Snow Bros. 2)</th>
</tr>
<tr>
<td>
  
Freq (MHz) | Use                   |
-----------|-----------------------|
10.000 MHz | M68000                |
27.000 MHz | GP9001 / YM3812 / Z80 |
  
</td>
<td>
  
Freq (MHz) | Use                    |
-----------|------------------------|
27.000 MHz | GP9001 / YM2151        |
16.000 MHz | M68000 / OKI MSM6295   |
32.000 MHz | Not Utilized on TP-033 |
  
</td>
</tr>
</table>
 
**Pixel clock:** 6.75 MHz

**Estimated geometry:**

    432 pixels/line  
  
    262 lines/frame  

## PCB Components

<table>
<tr>
<th>TP-020 (Teki Paki)</th>
<th>TP-021 (Ghox)</th>
</tr>
<tr>
<td>
  
Chip | Use |
-----|-----|
[**Motorola 68000 CPU**](https://en.wikipedia.org/wiki/Motorola_68000) | Main CPU     |
[**Zilog Z80 CPU**](https://en.wikipedia.org/wiki/Zilog_Z80)           | Sound CPU    |
[**Yamaha YM3812**](https://en.wikipedia.org/wiki/Yamaha_YM3812)       | OPL Audio    |
[**GP9001**](https://gamerepair.info/parts/77_toaplan_gp9001)          | Graphics VDP |
  
</td>
<td>
  
Chip | Use |
-----|-----|
[**Motorola 68000 CPU**](https://en.wikipedia.org/wiki/Motorola_68000) | Main CPU     |
[**Zilog Z180 CPU**](https://en.wikipedia.org/wiki/Zilog_Z180)         | Sound CPU    |
[**Yamaha YM3812**](https://en.wikipedia.org/wiki/Yamaha_YM3812)       | OPL Audio    |
[**GP9001**](https://gamerepair.info/parts/77_toaplan_gp9001)          | Graphics VDP |
  
</td>
</tr>
</table>

<table>
<tr>
<th>TX-022 (Dogyūn!! - Dogyuun)</th>
<th>TP-024 (Tatsujin Oh-Truxton II)</th>
</tr>
<tr>
<td>
  
Chip | Use |
-----|-----|
[**Motorola 68000 CPU**](https://en.wikipedia.org/wiki/Motorola_68000) | Main CPU     |
[**Zilog Z80 CPU**](https://en.wikipedia.org/wiki/Zilog_Z180)          | Sound CPU    |
[**Yamaha YM3812**](https://en.wikipedia.org/wiki/Yamaha_YM3812)       | OPL Audio    |
[**GP9001**](https://gamerepair.info/parts/77_toaplan_gp9001)          | Graphics VDP |
  
</td>
<td>
  
Chip | Use |
-----|-----|
[**Motorola 68000 CPU**](https://en.wikipedia.org/wiki/Motorola_68000) | Main CPU     |
[**Yamaha YM2151**](https://en.wikipedia.org/wiki/Yamaha_YM2151)       | OPM Audio    |
[**OKI MSM6295**](https://dtsheet.com/doc/957023/oki-m6295)            | ADPCM Audio  |
[**GP9001**](https://gamerepair.info/parts/77_toaplan_gp9001)          | Graphics VDP |
  
</td>
</tr>
</table>

<table>
<tr>
<th>TP-025 (Whoopee!! - Pipi & Bibi's)</th>
<th>TP-033 (Otenki Paradise: Snow Bros. 2)</th>
</tr>
<tr>
<td>
  
Chip | Use |
-----|-----|
[**Motorola 68000 CPU**](https://en.wikipedia.org/wiki/Motorola_68000) | Main CPU     |
[**Zilog Z80 CPU**](https://en.wikipedia.org/wiki/Zilog_Z80)           | Sound CPU    |
[**Yamaha YM3812**](https://en.wikipedia.org/wiki/Yamaha_YM3812)       | OPL Audio    |
[**GP9001**](https://gamerepair.info/parts/77_toaplan_gp9001)          | Graphics VDP |
  
</td>
<td>
  
Chip | Use |
-----|-----|
[**Motorola 68000 CPU**](https://en.wikipedia.org/wiki/Motorola_68000) | Main CPU     |
[**Yamaha YM2151**](https://en.wikipedia.org/wiki/Yamaha_YM2151)       | OPM Audio    |
[**OKI MSM6295**](https://dtsheet.com/doc/957023/oki-m6295)            | ADPCM Audio  |
[**GP9001**](https://gamerepair.info/parts/77_toaplan_gp9001)          | Graphics VDP |
  
</td>
</tr>
</table>

### Additional Components (Board Dependent)

Chip | Use |
-----|-----|
[**Zilog Z80 CPU**](https://en.wikipedia.org/wiki/Zilog_Z80)  | Sound CPU                |
[**HD647180X**](https://en.wikipedia.org/wiki/Zilog_Z180)     | Sound CPU & I/O Handling |
[**NEC V25**](https://en.wikipedia.org/wiki/NEC_V25)          | Sound CPU & I/O Handling |
[**GP9001**](https://gamerepair.info/parts/77_toaplan_gp9001) | Second Graphics VDP      |

# PCB Information

- W.I.P

# Control Layout

-  W.I.P

### Keyboard Handler

- Keyboard inputs mapped to mame defaults for all functions up to the third player; player three mapping is not listed below.

|Services|Coin/Start|
|--|--|
|<table> <tr><th>Functions</th><th>Keymap</th></tr><tr><td>Test</td><td>F2</td></tr><tr><td>Reset</td><td>F3</td></tr><tr><td>Service</td><td>9</td></tr><tr><td>Pause</td><td>P</td></tr> </table> | <table><tr><th>Functions</th><th>Keymap</th><tr><tr><td>P1 Start</td><td>1</td></tr><tr><td>P2 Start</td><td>2</td></tr><tr><td>P1 Coin</td><td>5</td></tr><tr><td>P2 Coin</td><td>6</td></tr> </table>|

|Player 1|Player 2|
|--|--|
|<table> <tr><th>Functions</th><th>Keymap</th></tr><tr><td>P1 Up</td><td>Up</td></tr><tr><td>P1 Down</td><td>Down</td></tr><tr><td>P1 Left</td><td>Left</td></tr><tr><td>P1 Right</td><td>Right</td></tr><tr><td>P1 Bttn 1</td><td>L-CTRL</td></tr><tr><td>P1 Bttn 2</td><td>L-ALT</td></tr><tr><td>P1 Bttn 3</td><td>Space</td></tr> </table> | <table> <tr><th>Functions</th><th>Keymap</th></tr><tr><td>P2 Up</td><td>R</td></tr><tr><td>P2 Down</td><td>F</td></tr><tr><td>P2 Left</td><td>D</td></tr><tr><td>P2 Right</td><td>G</td></tr><tr><td>P2 Bttn 1</td><td>A</td></tr><tr><td>P2 Bttn 2</td><td>S</td></tr><tr><td>P2 Bttn 3</td><td>Q</td></tr> </table>|

# Acknowledgments

[**Pramod Somashekar**](https://github.com/MiSTer-devel/Arcade-Raizing_MiSTer) for his extensive work on the GP9001, Raizing FPGA implementation, general knowledge, and assistance with implementing Tatsujin Ō.<br><br>
[**Jose Tejada**](https://github.com/MiSTer-devel/Arcade-Raizing_MiSTer) for his extensive work on FPGA modules utilized in this implementation, general knowledge, and assistance.<br><br>
[**@90s_cyber_thriller**](https://www.instagram.com/90s_cyber_thriller/) for loaning Dogyūn!!, Knuckle Bash, Tatsujin Ō, and Batsugun PCBs referenced for core development.

# Support

Please consider showing support for this and future projects by contributing to the [**Coin-Op Collection Patreon**](https://www.patreon.com/atrac17).

# License

Contact the author(s) for special licensing needs. Otherwise follow the GPLv3 license attached.
