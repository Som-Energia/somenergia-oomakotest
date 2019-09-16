#!/bin/bash

step() { echo -e "\033[34;1m== "$@"\033[0m"; }
warn() { echo -e "\033[33;1m== "$@"\033[0m"; }
run() { echo -e "\033[35;1m== "$@"\033[0m"; "$@"; }

INPUT_A="$1"
INPUT_B="$2"
OUTPUT="$3"

TMPDIR="$(mktemp -d)"
DIFFFOND=0

mkdir -p "${TMPDIR}/input_a"
mkdir -p "${TMPDIR}/input_b"
mkdir -p "${TMPDIR}/diff"
mkdir -p "${TMPDIR}/merged"
pdftk  "${INPUT_A}"  burst  output  "${TMPDIR}/input_a/page_%03d.pdf"
pdftk  "${INPUT_B}"  burst  output  "${TMPDIR}/input_b/page_%03d.pdf"

for page in ${TMPDIR}/input_a/page_*.pdf; do
    a="$page"
    b="${page/input_a/input_b}"
    diff="${page/input_a/diff}"
    merged="${page/input_a/merged}"

    step generating "$diff"
    run compare -metric AE "$a" "$b" -compose src "$diff"
    error="$?"

    if [ "$error" != "0" ] ; then
        warn "Diff found ($error) in page $page"
        DIFFFOND=1
    fi

    step generating "$merged"
    run pdftk "$diff" background "$b" output "$merged"
done

run pdftk "${TMPDIR}"/merged/*.pdf cat output $OUTPUT

rm -rf "${TMPDIR}"

exit $DIFFFOND
