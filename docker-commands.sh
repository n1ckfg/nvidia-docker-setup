function docker-container-bash() {
	docker exec -it $1 bash
}

function docker-container-command() {
	docker exec -it $1 $2
}

function docker-container-commit() {
	docker commit $1
}

function docker-container-remove-all() {
	docker container stop $(docker container ls -aq)
	docker container rm $(docker container ls -aq)
}

# https://linuxize.com/post/how-to-install-python-3-7-on-ubuntu-18-04/
# https://linuxize.com/post/how-to-install-pip-on-ubuntu-18.04/
# https://unix.stackexchange.com/questions/410579/change-the-python3-default-version-in-ubuntu
function docker-container-setup-default() {
	CONTAINER_NAME=$1
	PYTHON_VERSION="python$2"

	CMD="docker exec -it $CONTAINER_NAME"

	$CMD apt-get update
	$CMD apt-get install -y git nano wget curl

	docker-container-setup-python $1 $2
}

# https://linuxize.com/post/how-to-install-python-3-7-on-ubuntu-18-04/
# https://linuxize.com/post/how-to-install-pip-on-ubuntu-18.04/
# https://unix.stackexchange.com/questions/410579/change-the-python3-default-version-in-ubuntu
function docker-container-setup-python() {
	CONTAINER_NAME=$1
	PYTHON_VERSION="python$2"
	CMD="docker exec -it $CONTAINER_NAME"

	$CMD apt-get install -y software-properties-common
	$CMD add-apt-repository ppa:deadsnakes/ppa -y
	$CMD apt-get update
	$CMD apt-get install -y $PYTHON_VERSION python3-pip lib$PYTHON_VERSION-dev
	$CMD update-alternatives --install /usr/bin/python python /usr/bin/$PYTHON_VERSION 1
	$CMD update-alternatives --install /usr/bin/python3 python3 /usr/bin/$PYTHON_VERSION 1
}

# https://linuxize.com/post/how-to-install-python-3-7-on-ubuntu-18-04/
# https://linuxize.com/post/how-to-install-pip-on-ubuntu-18.04/
# https://unix.stackexchange.com/questions/410579/change-the-python3-default-version-in-ubuntu
function docker-container-setup-tf() {
	CONTAINER_NAME=$1
	PYTHON_VERSION="python$2"
	TENSORFLOW_VERSION="tensorflow-gpu==$3"

	CMD="docker exec -it $CONTAINER_NAME"

	docker-container-setup-default $1 $2

	$CMD pip3 install $TENSORFLOW_VERSION
}

# https://linuxize.com/post/how-to-install-python-3-7-on-ubuntu-18-04/
# https://linuxize.com/post/how-to-install-pip-on-ubuntu-18.04/
# https://unix.stackexchange.com/questions/410579/change-the-python3-default-version-in-ubuntu
function docker-container-setup-torch() {
	CONTAINER_NAME=$1
	PYTHON_VERSION="python$2"
	TORCH_VERSION="torch==$3"

	CMD="docker exec -it $CONTAINER_NAME"

	docker-container-setup-default $1 $2

	$CMD pip3 install $TORCH_VERSION
}

function docker-container-stop-all() {
	docker container stop $(docker container ls -aq)
}

function docker-image-backup() {
	docker save $1:latest | gzip > $1.tar.gz
}

# Newest images:
# https://hub.docker.com/r/nvidia/cuda/
# Older images:
# https://gitlab.com/nvidia/container-images/cuda/blob/master/doc/supported-tags.md
function docker-image-install() {
	nvidia-docker run -it nvidia/cuda:$1 bash
}

function docker-image-restore() {
	docker load -i $1
}

# !/usr/bin/env bash
# https://github.com/ybycode/docker-openframeworks
function docker-image-run-x11() {
    XSOCK=/tmp/.X11-unix
    XAUTH=/tmp/.docker.xauth

    #touch $XAUTH
    #xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -

    docker run --rm -it \
        --network=host \
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
}

function docker-image-run() {
	docker run -it $1
}

function docker-image-shrink-all() {
	docker system prune
}

function docker-list() {
	echo ""
	echo "* * *   RUNNING CONTAINERS   * * *"
	docker ps
	echo ""
	echo "* * *   ALL CONTAINERS   * * *"
	docker container ls -a
	echo ""
	echo "* * *   DISK IMAGES   * * *"
	docker images
}

function docker-remove() {
	docker container stop $1
	docker container rm $1
}

function docker-run() {
	docker start $1
	docker exec -it $1 bash
}

function docker-stop() {
	docker container stop $1
}

# https://tech.amikelive.com/node-841/command-cheatsheet-checking-versions-of-installed-software-libraries-tools-for-deep-learning-on-ubuntu-16-04/
function docker-versions() {
	python --version
	docker --version
	nvidia-smi | grep "Driver Version" | awk '{print $6}' | cut -c2-
	nvcc --version | grep "release" | awk '{print $6}'
	locate cudnn | grep "libcudnn.so." | tail -n1 | sed -r 's/^.*\.so\.//'
}
