# https://notesbyair.github.io/blog/cs/2020-05-26-installing-multiple-versions-of-cuda-cudnn/
# https://rodrigodzf.github.io/setup/cuda/2019/04/15/cuda-setup.html
# https://forums.developer.nvidia.com/t/cant-locate-installutils-pm-in-inc/46952/8

# get cuda installer
wget https://developer.nvidia.com/compute/cuda/8.0/Prod2/local_installers/cuda_8.0.61_375.26_linux-run
chmod +x cuda_8.0.61_375.26_linux-run

# get cudnn files
wget https://fox-gieg.com/patches/cuda/cuda8cudnn6/linux64/cudnn-8.0-linux-x64-v6.0.tgz
tar -xvf ./cudnn-8.0-linux-x64-v6.0.tgz

# unpack cuda installer, modification for Ubuntu 18.04
./cuda_8.0.61_375.26_linux-run --tar mxvf
sudo cp ./InstallUtils.pm /usr/lib/x86_64-linux-gnu/perl-base

# install cuda
sudo bash cuda_8.0.61_375.26_linux-run --silent --verbose --toolkit --samples --override --no-opengl-libs

# install cudnn
ver=8.0
sudo cp ./cuda/include/cudnn.h /usr/local/cuda-"${ver}"/include
sudo cp ./cuda/lib64/libcudnn* /usr/local/cuda-"${ver}"/lib64
