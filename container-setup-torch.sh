# https://linuxize.com/post/how-to-install-python-3-7-on-ubuntu-18-04/
# https://linuxize.com/post/how-to-install-pip-on-ubuntu-18.04/
# https://unix.stackexchange.com/questions/410579/change-the-python3-default-version-in-ubuntu

CONTAINER_NAME=$1
PYTHON_VERSION="python$2"
TORCH_VERSION="torch==$3"

CMD="docker exec -it $CONTAINER_NAME"

./container-default-setup.sh $1 $2

$CMD pip3 install $TORCH_VERSION

