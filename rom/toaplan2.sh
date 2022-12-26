#!/bin/bash

OUTDIR="truxton2"

mkdir -p "$OUTDIR"
mkdir -p "${OUTDIR}/$ALTD"

if [ ! -d xml ]; then
  mkdir xml
fi

function mra {
    local GAME=$1
    local ALT=${2//[:]/}
    local BUTSTR="$3"
    local DIP="$4"

    if [ ! -e xml/$GAME.xml ]; then
        if [ ! -f $GAME.xml ]; then
            ./mamefilter $GAME
        fi
        mv $GAME.xml xml/
    fi

    ALTD=_alt/_"$ALT"
    mkdir -p $OUTDIR/"$ALTD"

    echo -----------------------------------------------
    echo "Dumping $GAME"
    ./mame2dip xml/$GAME.xml -rbf truxton2 -outdir $OUTDIR -altfolder "$ALTD" \
        -order maincpu gp9001_0 oki1 \
        -dipbase 8                   \
        -start maincpu    0x0        \
        -start gp9001_0   0x80000    \
        -start oki1       0x280000   \
        -setword maincpu  16         \
        -setword gp9001_0 16 reverse \
        -frac 1 gp9001_0 2           \
        -order-roms gp9001_0 0 1     \
        -dipdef $DIP                 \
        -corebuttons 3               \
        -buttons $BUTSTR
}

mra  truxton2 "Truxton II"  "Shot,Bomb,Kill Player" "00,00,F0"

function mra {
    local GAME=$1
    local ALT=${2//[:]/}
    local BUTSTR="$3"
    local DIP="$4"

    if [ ! -e xml/$GAME.xml ]; then
        if [ ! -f $GAME.xml ]; then
            ./mamefilter $GAME
        fi
        mv $GAME.xml xml/
    fi

    ALTD=_alt/_"$ALT"
    mkdir -p $OUTDIR/"$ALTD"

    echo -----------------------------------------------
    echo "Dumping $GAME"
    ./mame2dip xml/$GAME.xml -rbf snowbro2 -outdir $OUTDIR -altfolder "$ALTD" \
        -order maincpu gp9001_0 oki1 \
        -dipbase 8                   \
        -start maincpu    0x0        \
        -start gp9001_0   0x80000    \
        -start oki1       0x380000   \
        -setword maincpu  16 reverse \
        -setword gp9001_0 16 reverse \
        -frac 1 gp9001_0 2           \
        -order-roms gp9001_0 0 1 2 3 \
        -dipdef $DIP                 \
        -corebuttons 2               \
        -buttons $BUTSTR
}

mra  snowbro2 "Snow Bros. 2 - With New Elves"  "B1,B2" "00,00,00"

function mra {
    local GAME=$1
    local ALT=${2//[:]/}
    local BUTSTR="$3"
    local DIP="$4"

    if [ ! -e xml/$GAME.xml ]; then
        if [ ! -f $GAME.xml ]; then
            ./mamefilter $GAME
        fi
        mv $GAME.xml xml/
    fi

    ALTD=_alt/_"$ALT"
    mkdir -p $OUTDIR/"$ALTD"

    echo -----------------------------------------------
    echo "Dumping $GAME"
    ./mame2dip xml/$GAME.xml -rbf pipibibs -outdir $OUTDIR -altfolder "$ALTD" \
        -order maincpu audiocpu gp9001_0 \
        -dipbase 8                   \
        -start maincpu    0x0        \
        -start audiocpu   0x40000    \
        -start gp9001_0   0x48000    \
        -setword maincpu  16 reverse \
        -setword gp9001_0 16 reverse \
        -frac 1 gp9001_0 2           \
        -dipdef $DIP                 \
        -corebuttons 2               \
        -buttons $BUTSTR
}

mra  pipibibs "Pipi & Bibis"  "B1,B2" "00,00,00"

exit 0
