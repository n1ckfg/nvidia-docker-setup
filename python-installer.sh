# https://linuxize.com/post/how-to-install-python-3-7-on-ubuntu-18-04/
# https://linuxize.com/post/how-to-install-pip-on-ubuntu-18.04/
# https://unix.stackexchange.com/questions/410579/change-the-python3-default-version-in-ubuntu

SESSION_NAME=$1
PYTHON_VERSION=$2
CMD="docker exec -it $SESSION_NAME"

$CMD apt-get install -y software-properties-common
$CMD add-apt-repository ppa:deadsnakes/ppa
$CMD apt-get update
$CMD apt-get install -y $PYTHON_VERSION python3-pip
$CMD update-alternatives --install /usr/bin/python python /usr/bin/$PYTHON_VERSION 1
$CMD update-alternatives --install /usr/bin/python3 python3 /usr/bin/$PYTHON_VERSION 1

