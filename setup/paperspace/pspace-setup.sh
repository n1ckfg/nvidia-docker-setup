sudo add-apt-repository -y ppa:graphics-drivers/ppa

sudo apt-get update -y
sudo apt-get upgrade -y

sudo apt-get install ubuntu-drivers-common
sudo ubuntu-drivers autoinstall

sudo apt-get autoremove -y
sudo apt-get autoclean -y

wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh
