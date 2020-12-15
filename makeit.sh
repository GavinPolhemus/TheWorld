#!/bin/bash

if [ "$USER" == "hraban" ]; then
	# Hraban’s settings
	cd ~/workspace/world
	BINDIR=~/lmtx/tex/texmf-osx-64/bin
	COPYDIR="~/Documents/Kunden/Polhemus/TheWorld/"
	# COPYDIR="~/Seafile/Meine Bibliothek/TheWorld/"
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
context prd_volume${VOL} --luatex --result=${RESULTFILE} --mode=$MODE --autopdf=auto && cp ${RESULTFILE}.pdf $COPYDIR
