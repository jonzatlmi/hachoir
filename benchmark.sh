#!/bin/bash

if [ "x$PYTHON" = "x" ]; then
   PYTHON=`which python3`
fi
PYTHON=$PYTHON
ROOT=$(cd `dirname $0`; pwd)
TESTCASE=testcase
export PYTHONPATH=$ROOT/hachoir-core:$ROOT/hachoir-parser:$ROOT/hachoir-metadata:$PYTHONPATH

function prepare_benchmark
{
    echo
    echo "=== $1 ==="
    sync
}

HACHOIR_VERSION="unknown"
PYTHON_VERSION=`$PYTHON -c 'from sys import version; print(version.split("\n")[0].split("(")[0].strip())' 2>&1`
echo "Benchmark Hachoir version $HACHOIR_VERSION on Python $PYTHON_VERSION"

prepare_benchmark "hachoir-grep: yellowcase"
$PYTHON -OO $ROOT/hachoir-tools/hachoir-grep --bench --all $TESTCASE/yellowdude.3ds

prepare_benchmark "hachoir-metadata: set A (mp3, wav, png, au, mkv)"
(cd $TESTCASE; $PYTHON -OO $ROOT/hachoir-metadata \
    --bench \
    sheep_on_drugs.mp3 kde_click.wav logo-kubuntu.png \
    audio_8khz_8bit_ulaw_4s39.au flashmob.mkv 10min.mkv)

