#!/bin/bash

##########################################################################
# Setup runtime environment on a Windows/Cygwin machine.
# Usage: $ source env-hercules.sh platform
##########################################################################

# $1 = platform
# Choices:
# CYGWIN
# MINGW
# LINUX
###
platform=$1

###
if [ "${platform}" == "LINUX" ] 
then
  export HLSTOP=`pwd`
  export HLSTOP_MSIM=`pwd`
  export BUILDCC=gcc
  export BUILDCXX=g++
elif [ "${platform}" == "CYGWIN" ] 
then
  export HLSTOP=`pwd`
  export HLSTOP_MSIM=`pwd`
  export BUILDCC=gcc
  export BUILDCXX=g++
elif [ "${platform}" == "MINGW" ] 
then
  export HLSTOP=`pwd`
  export HLSTOP_MSIM=`pwd -W`
  export BUILDCC=mingw32-gcc
  export BUILDCXX=mingw32-g++
fi
###
export CDFG2HDL_PATH=${HLSTOP}/cdfg2hdl
export TXL_PATH="/usr/local/bin"
export PATH=/home/uop/ActiveTcl8.6.1.0.297577-linux-ix86-threaded/payload/bin:$PATH
export LD_LIBRARY_PATH=/home/uop/ActiveTcl8.6.1.0.297577-linux-ix86-threaded/payload/lib:$LD_LIBRARY_PATH
