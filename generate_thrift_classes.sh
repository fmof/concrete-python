#!/bin/bash

#
# Copyright 2012-2014 Johns Hopkins University HLTCOE. All rights reserved.
# This software is released under the 2-clause BSD license.
# See LICENSE in the project root directory.
#

#
# THIS SCRIPT SHOULD ONLY BE RUN BY PACKAGE MAINTAINERS.
# If you are not a package maintainer, then you can safely ignore this
# script - all the information you need to use the Concrete-Python
# library can be found in README.md
#
#
# This script uses the Thrift compiler to generate the Python classes
# from the .thrift definition files.
#
# The Concrete-Thrift repository contains the .thrift definition
# files, but not the Python classes generated by the Thrift compiler.
# This repository (Concrete-Python) contains the Thrift-generated
# Python classes, but not the .thrift definition files.
#
# This script should be run whenever the .thrift definition files in the
# Concrete-Thrift repository are changed.

#
# Usage: generate_thrift_code.sh </absolute/path/to/thrift/files>
#

if [ $# != 1 ]
then
    echo "Usage: generate_thrift_code.sh </absolute/path/to/thrift/files>"
    exit 1
fi

for P in `find $1 -name '*.thrift'`
do
    thrift --gen py:new_style,utf8strings $P
done

# Delete extraneous file generated by thrift
rm gen-py/__init__.py

# Copy generated Thrift classes
cp -a gen-py/concrete/* concrete/
