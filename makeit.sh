#!/bin/bash
# you can call this from the root directory (world)
# with the volume (01, 01extra, 02, ...; default: 01)
# and a mode (low, print, check; default: low)
# "check" doesn’t compile but checks the source files for obvious errors

if [ "$USER" == "hraban" ]; then
	# Hraban’s settings
	cd ~/workspace/world
	BINDIR=~/lmtx/tex/texmf-osx-64/bin
	COPYDIR="~/Documents/Kunden/Polhemus/TheWorld/"
	# COPYDIR="~/Seafile/Meine Bibliothek/TheWorld/"
elif [ "$USER" == "brian" ]; then
	# Brian’s settings
	# root directory of this project
	cd ~/world
	# binaries of your ConTeXt installation:
	BINDIR=~/context/tex/texmf-osx-64/bin
	# put a copy of the PDF in $COPYDIR:
	COPYDIR="~/TheWorld/"
else
	# Gavin’s settings
	cd ~/TheWorld/
	BINDIR=~/context-osx-64/tex/texmf-osx-64/bin
	COPYDIR=./
fi
PATH=$BINDIR:$PATH

VOL=$1
MODE=$2

if [ "$VOL" == "" ]; then
	VOL=01
fi

if [ "$MODE" == "check" ]; then
	echo "Checking source files of volume $VOL, no compilation."
	echo ""
	for TEX in volume$VOL/*.tex; do echo $TEX; mtxrun --autogenerate --script check $TEX; done
	exit
fi

if [ "$MODE" == "" ]; then
	# downsampling of images not yet implemented
	MODE=low
fi

ISODATE=`date +"%Y-%m-%d"`

RESULT=TheWorld
RESULTFILE=${RESULT}_${ISODATE}
# use MkIV mode: --luatex
context prd_volume${VOL} --luatex --result=${RESULTFILE} --nodummy --mode=$MODE --autopdf=auto && cp ${RESULTFILE}.pdf $COPYDIR
