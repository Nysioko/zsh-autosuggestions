#!/bin/bash
clear
echo "############################################################################"
echo "#                                                                          #"
echo "#                      ZSH AUTOSUGGESTION INSTALLER                        #"
echo "#                                                                          #"
echo "############################################################################"
sleep 1
echo ""
echo "This installer will install Autosuggestion on your system."
sleep 1

function check_sudo() {
	echo "Checking if you have the required permissions..."
	if [ "$(id -u)" != "0" ]; then
		echo "You need to be root to install Autosuggestion."
		exit 1
	else
		echo -e "\e[32mOK\e[0m"
		echo ""
		sleep 0.5
	fi
}

function warning() {
	echo -e "\e[31m*****************\e[0m"
	echo -e "\e[31m*    WARNING    *\e[0m"
	echo -e "\e[31m*****************\e[0m"
	echo ""
	echo -e "\e[33mYou are about to install Autosuggestion on your system.\e[0m"
	echo -e "\e[33mThis will overwrite any existing Autosuggestion files.\e[0m"
	read -p "Are you sure you want to continue? (y/n) " -n 1 -r
	echo -e "\e[0m"
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		echo -e "\e[32mOK\e[0m"
		echo ""
		sleep 1
	else
		echo -e "\e[31mAborted\e[0m"
		exit 1
	fi
}

function package_manager() {
	echo "Checking your package manager..."
	if [ -x "$(command -v apt-get)" ]; then
		pm="apt"
	elif [ -x "$(command -v yum)" ]; then
		pm="yum"
	elif [ -x "$(command -v pacman)" ]; then
		pm="pacman"
	elif [ -x "$(command -v brew)" ]; then
		pm="brew"
	else
		echo "No package manager found."
		exit 1
	fi
	echo -e "Detected package manager: \e[32m$pm\e[0m"
	echo ""
	sleep 1
}

function check_dependency() {
	echo "Checking dependencies..."
	sleep 0.5
	echo "Checking if zsh is installed..."
	sleep 1
	if [ -z "$(which zsh)" ]; then
		echo -e "\e[31mFAIL\e[0m"
		is_installed=false
		echo ""
	else
		echo -e "\e[32mOK\e[0m"
	fi
	sleep 0.5
	echo ""
	echo "Checking if git is installed..."
	sleep 1
	if [ -z "$(which git)" ]; then
		echo -e "\e[31mFAIL\e[0m"
		is_installed=false
		echo ""
	else
		echo -e "\e[32mOK\e[0m"
	fi
	sleep 0.5
	echo ""
	echo "Checking if curl is installed..."
	sleep 1
	if [ -z "$(which curl)" ]; then
		echo -e "\e[31mFAIL\e[0m"
		is_installed=false
		echo ""
	else
		echo -e "\e[32mOK\e[0m"
	fi
	echo ""
	return $is_installed
}

function install_dependencies() {
	echo "Installing missing dependencies..."
	echo ""
	if [ "$pm" = "apt" ]; then
		apt-get update
		apt-get upgrade -y
		apt-get install -y zsh git curl
	elif [ "$pm" = "yum" ]; then
		yum update
		yum upgrade -y
		yum install -y zsh git curl
	elif [ "$pm" = "pacman" ]; then
		pacman -Syu
		pacman -S --noconfirm zsh git curl
	elif [ "$pm" = "brew" ]; then
		brew update
		brew upgrade
		brew install zsh git curl
	fi
	echo ""
	echo "Dependencies installed."
	echo ""
	sleep 1
}

function install_autosuggestion() {
	echo "Installing Autosuggestion..."
	sleep 2
	echo "Installing command-not-found..."
	sudo cp -r resources/command-not-found /usr/lib
	sleep 0.5
	echo "Installing autosuggestion..."
	sudo cp -r resources/zsh-autosuggestions /usr/share
	sleep 0.5
	echo "Installing syntax highlighting..."
	sudo cp -r resources/zsh-syntax-highlighting /usr/share
	sleep 0.5
	echo "Installing command-not-found for zsh..."
	sudo cp -r resources/zsh_command_not_found /etc/
	sleep 0.5
	echo "Backuping your current zshrc..."
	sudo cp ~/.zshrc ~/.zshrc.bak
	sleep 0.5
	echo "Installing autosuggestion for zsh..."
	sudo cp resources/zshrc ~/.zshrc
	sleep 0.5
}

# function autodelete() {
# 	echo ""
# 	echo "Autodeleteing installer folder..."
# 	cd ../
# 	rm -rf zsh-kali-autosuggestions-installer
# 	echo -e "\e[32mDone.\e[0m"
# 	echo "You're all set! Enjoy autosuggestion!"
# 	echo "Thanks for using this installer!"
# }

function Thanks() {
	echo "You're all set! Enjoy autosuggestion!"
	echo "Thanks for using this installer!"
}

function main() {
	check_sudo
	warning
	package_manager
	check_dependency
	if [ "$is_installed" = false ]; then
		install_dependencies
	else
		echo "All dependencies are already installed."
		echo ""
		sleep 1
	fi
	install_autosuggestion
	#autodelete
	Thanks
}

main $@
