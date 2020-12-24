v=$1
export PATH=$PATH:/usr/local/cuda-$v/bin
export CUDADIR=/usr/local/cuda-$v
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda-$v/lib64

sudo rm /usr/local/cuda
sudo ln -s /usr/local/cuda-$v /usr/local/cuda

nvcc --version

