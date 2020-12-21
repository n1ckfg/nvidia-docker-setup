# !/usr/bin/env bash
# https://github.com/ybycode/docker-openframeworks

XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth

touch $XAUTH
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -

docker run --rm -it \
    --volume=$XSOCK:$XSOCK \
    --volume=$XAUTH:$XAUTH \
    --env="XAUTHORITY=${XAUTH}" \
    --env="DISPLAY" \
    --device=/dev/dri:/dev/dri \
    --volume=/run/user/$(id -u)/pulse:/run/pulse \
    $1 \
    bash

    #--volume=$(pwd)/of:/of \
    #$1 \
    #bash
