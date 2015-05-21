#!/bin/bash
DIR=$( dirname $0 )
PLATFORM=$1

docker build -f $DIR/$PLATFORM.Dockerfile -t $PLATFORM . && docker run --name $PLATFORM $PLATFORM
