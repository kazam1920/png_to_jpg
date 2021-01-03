#!/bin/bash

# For emr version < 5.20 use commented part 
#sudo ln -fs /usr/bin/python3.6 /etc/alternatives/python
#sudo ln -fs /usr/bin/pip-3.6 /etc/alternatives/pip
#sudo pip install --upgrade pip
#/usr/local/bin/pip3.6 install --user pandas

pip3 install --user pandas
pip3 install --user pillow
pip3 install --user kaggle
pip3 install --user opencv-python
pip3 install --user sklearn
sudo yum install git -y