#!/bin/bash

export LC_NUMERIC="en_US.UTF-8"

    pdfcrop --bbox "$(
        pdfcrop --verbose "$@" |
        grep '^%%HiResBoundingBox: ' |
        cut -d' ' -f2- |
        datamash -t' ' min 1 min 2 max 3 max 4
    )" --margins "25 25 25 25" "$@"
