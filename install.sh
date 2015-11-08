#!/bin/bash

# link current directory with home directory
if [ ! -d ~/.way2cu ]
then
	echo "Linking directory to home..."
	ln -s `pwd` ~/.way2cu
fi

# clone credentials directory
if [ -d ~/.password-store ] && [ ! -d ~/.password-store/Way2CU ]
then
	echo "Cloning credentials repository..."
	git clone git@github.com:Way2CU/Credentials.git ~/.password-store/Way2CU
fi

# load company scripts
if ! grep -Fxq "source ~/.way2cu/config/bashrc" ~/.bashrc
then
	echo "Configuring bash resource file..."
	echo "source ~/.way2cu/config/bashrc" >> ~/.bashrc
fi
