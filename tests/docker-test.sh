#!/bin/bash
DIR=$( dirname $0 )
ARG=$1
DOCKERFILE=${ARG#tests/}
PLATFORM=${DOCKERFILE%.Dockerfile}
docker build -f $DIR/$DOCKERFILE -t $PLATFORM . && docker run --name $PLATFORM $PLATFORM
