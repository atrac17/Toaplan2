# Toaplan Version 2 FPGA Implementation

FPGA compatible core of Toaplan Version 2 arcade hardware for [**MiSTerFPGA**](https://github.com/MiSTer-devel/Main_MiSTer/wiki) based on work by [**Pramod Somashekar**](https://github.com/MiSTer-devel/Arcade-Raizing_MiSTer). Without his extensive work on the GP9001, none of this would be possible.

FPGA implementation will reference Knuckle Bash (TP-023) schematics and will be verified against Knuckle Bash (TP-023), Tatsujin Ō (TP-024), Dogyūn!! (TP-022), FixEight (TP-026) and Batsugun (TP-030).

The intent is for this core to be a 1:1 playable implementation of Toaplan V2 hardware. Currently in alpha state, this core is in active development by [**atrac17**](https://github.com/atrac17) and [**Darren Olafson**](https://twitter.com/Darren__O).

**The development process for this core will take time, understand that we have other obligations and active projects outside of the Toaplan V2 hardware.**

![Toaplan_logo_shadow_small](https://user-images.githubusercontent.com/32810066/151543842-5f7380a4-9b29-472d-bc03-8cc04a579cf2.png)

## Supported Games

| Title | Status  | Protection | MCU Usage | Released |
|-------|---------|------------|-----------|----------|
| [**Teki Paki**](https://en.wikipedia.org/wiki/Teki_Paki)                             | Pending         | HD647180 | Audio       | No      |
| [**Ghox**](https://en.wikipedia.org/wiki/Ghox)                                       | Pending         | HD647180 | Audio & I/O | No      |
| [**Whoopee!!**](https://en.wikipedia.org/wiki/Pipi_%26_Bibi's)                       | **W.I.P**       | None     | N/A         | No      |
| [**Dogyūn!!**](https://en.wikipedia.org/wiki/Dogyuun)                                | Pending         | NEC V25  | Audio       | No      |
| [**Tatsujin Ō**](https://en.wikipedia.org/wiki/Truxton_II)                           | **Implemented** | **None** | **N/A**     | **Yes** |
| [**FixEight**](https://en.wikipedia.org/wiki/FixEight)                               | Pending         | NEC V25  | Audio & I/O | No      |
| [**V-V**](https://en.wikipedia.org/wiki/Grind_Stormer)                               | Pending         | NEC V25  | Audio       | No      |
| [**Knuckle Bash**](https://en.wikipedia.org/wiki/Knuckle_Bash)                       | Pending         | NEC V25  | Audio       | No      |
| [**Batsugun**](https://en.wikipedia.org/wiki/Batsugun)                               | Pending         | NEC V25  | Audio       | No      |
| [**Otenki Paradise**](https://en.wikipedia.org/wiki/Snow_Bros._2:_With_New_Elves)    | **W.I.P**       | None     | N/A         | No      |

## External Modules

|Name| Purpose | Author |
|----|---------|--------|
| [**fx68k**](https://github.com/ijor/fx68k)                    | [**Motorola 68000 CPU**](https://en.wikipedia.org/wiki/Motorola_68000)       | Jorge Cwik                                 |
| [**t80**](https://opencores.org/projects/t80)                 | [**Zilog Z80 CPU**](https://en.wikipedia.org/wiki/Zilog_Z80)                 | Daniel Wallner                             |
| [**jt51**](https://github.com/jotego/jt51)                    | [**Yamaha YM2151**](https://en.wikipedia.org/wiki/Yamaha_YM2151)             | Jose Tejada                                |
| [**jt6295**](https://github.com/jotego/jt6295)                | [**OKI MSM6295**](https://dtsheet.com/doc/957023/oki-m6295)                  | Jose Tejada                                |
| [**jtframe**](https://github.com/jotego/jtframe)              | [**FPGA Framework**](https://github.com/jotego/jtframe)                      | Jose Tejada, modified by Pramod Somashekar |
| [**GP9001**](https://gamerepair.info/parts/77_toaplan_gp9001) | [**Toaplan Graphics ASIC**](https://gamerepair.info/parts/77_toaplan_gp9001) | Pramod Somashekar                          |

# Known Issues / Tasks

- Reference TP-023 schematics and compare variations with TP-024 PCB  
- Verify clock domains for TP-024  
- Sprite flicker on left side TP-024  <br><br>
- **Please do not report issues at this time, this FPGA implementation is in an alpha state.**  

# PCB Check List

### Clock Information

H-Sync | V-Sync | Source | Title |
-------|--------|--------|-------|
15.625kHZ | 59.637404 | TBD | Tatsujin Ō |

### Crystal Oscillators

Location | Freq (MHz) | Use   |
---------|------------|-------|
 TBD     | TBD        | TBD   |

**Pixel clock:** 6.75 MHz

**Estimated geometry:**

    432 pixels/line  
  
    262 lines/frame  

### Main Components

Location | Chip | Use | PCB |
---------|------|-----|-----|
 TBD     | TBD  | TBD | TBD |

### Custom Components

Location | Chip | Use | PCB |
---------|------|-----|-----|
 TBD     | TBD  | TBD | TBD |

### Additional Components

Location | Chip | Use | PCB |
---------|------|-----|-----|
 TBD     | TBD  | TBD | TBD |

# PCB Information

- TBD

# Control Layout

- TBD

### Keyboard Handler

- Keyboard inputs mapped to mame defaults for all functions.

|Services|Coin/Start|
|--|--|
|<table> <tr><th>Functions</th><th>Keymap</th></tr><tr><td>Test</td><td>F2</td></tr><tr><td>Reset</td><td>F3</td></tr><tr><td>Service</td><td>9</td></tr><tr><td>Pause</td><td>P</td></tr> </table> | <table><tr><th>Functions</th><th>Keymap</th><tr><tr><td>P1 Start</td><td>1</td></tr><tr><td>P2 Start</td><td>2</td></tr><tr><td>P1 Coin</td><td>5</td></tr><tr><td>P2 Coin</td><td>6</td></tr> </table>|

|Player 1|Player 2|
|--|--|
|<table> <tr><th>Functions</th><th>Keymap</th></tr><tr><td>P1 Up</td><td>Up</td></tr><tr><td>P1 Down</td><td>Down</td></tr><tr><td>P1 Left</td><td>Left</td></tr><tr><td>P1 Right</td><td>Right</td></tr><tr><td>P1 Bttn 1</td><td>L-CTRL</td></tr><tr><td>P1 Bttn 2</td><td>L-ALT</td></tr><tr><td>P1 Bttn 3</td><td>Space</td></tr> </table> | <table> <tr><th>Functions</th><th>Keymap</th></tr><tr><td>P2 Up</td><td>R</td></tr><tr><td>P2 Down</td><td>F</td></tr><tr><td>P2 Left</td><td>D</td></tr><tr><td>P2 Right</td><td>G</td></tr><tr><td>P2 Bttn 1</td><td>A</td></tr><tr><td>P2 Bttn 2</td><td>S</td></tr><tr><td>P2 Bttn 3</td><td>Q</td></tr> </table>|

# Acknowledgments

[**Pramod Somashekar**](https://github.com/MiSTer-devel/Arcade-Raizing_MiSTer) for his extensive work on the GP9001, Raizing FPGA implementation, general knowledge, and assistance with implementing Tatsujin Ō.<br><br>
[**@90s_cyber_thriller**](https://www.instagram.com/90s_cyber_thriller/) for loaning all Toaplan V2 hardware used in the development process.

# Support

Please consider showing support for this and future projects by contributing to [**atrac17's Patreon**](https://www.patreon.com/atrac17) and [**Darren Olafson's Ko-fi**](https://ko-fi.com/darreno). While it isn't necessary, it's greatly appreciated.

# License

Contact the author(s) for special licensing needs. Otherwise follow the GPLv3 license attached.
