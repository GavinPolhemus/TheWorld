#!/bin/bash

if [ "$USER" == "hraban" ]; then
	# Hraban’s settings
	cd ~/workspace/world
	TEXROOT=~/lmtx
	COPYDIR="~/Documents/Kunden/Polhemus/TheWorld/"
	# COPYDIR="~/Seafile/Meine Bibliothek/TheWorld/"
else
	# Gavin’s settings
	cd ~/TheWorld/
	TEXROOT=~/context-osx-64
	COPYDIR=./
fi
PATH=$TEXROOT/bin:$PATH

VOL=$1
MODE=$2

if [ "$VOL" == "" ]; then
	VOL=01
fi

if [ "$MODE" == "check" ]; then
	echo "Checking source files, no compilation."
	for TEX in volume$VOL/*.tex; do echo $TEX; mtxrun --autogenerate --script check $TEX; done
	exit
fi

if [ "$MODE" == "" ]; then
	MODE=low
fi

ISODATE=`date +"%Y-%m-%d"`

RESULT=TheWorld
RESULTFILE=${RESULT}_${ISODATE}
# use MkIV mode: --luatex
context prd_volume${VOL} --luatex --result=${RESULTFILE} --mode=$MODE --autopdf=auto && cp ${RESULTFILE}.pdf $COPYDIR
