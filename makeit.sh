#!/bin/bash
# TODO: make paths relative

cd ~/workspace/world

# for TEX in volume01/*.tex; do echo $TEX; texcheck $TEX; done

if [ "$TEXROOT" == "" ]; then
	#source ~/context/tex/setuptex ~/context/tex
	#setuplmtx
	echo TEXROOT not set!
	exit 1
fi

VOL=$1
MODE=$2

if [ "$VOL" == "" ]; then
	VOL=01
fi

if [ "$MODE" == "" ]; then
	MODE=low
fi

ISODATE=`date +"%Y-%m-%d"`

RESULT=TheWorld
RESULTFILE=${RESULT}_${ISODATE}
COPYDIR="~/Documents/Kunden/Polhemus/TheWorld/"
#if [ ! -d $COPYDIR ]; then
#	COPYDIR="~/Seafile/Meine Bibliothek/TheWorld"
#fi
context prd_volume${VOL} --luatex --result=${RESULTFILE} --mode=$MODE --autopdf=auto && cp ${RESULTFILE}.pdf $COPYDIR
