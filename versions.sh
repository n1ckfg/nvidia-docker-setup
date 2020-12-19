# https://tech.amikelive.com/node-841/command-cheatsheet-checking-versions-of-installed-software-libraries-tools-for-deep-learning-on-ubuntu-16-04/
python --version
docker --version
nvidia-smi | grep "Driver Version" | awk '{print $6}' | cut -c2-
nvcc --version | grep "release" | awk '{print $6}'
locate cudnn | grep "libcudnn.so." | tail -n1 | sed -r 's/^.*\.so\.//'

