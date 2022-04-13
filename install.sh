clear
echo "*************************************************************************"
echo "*                                                                       *"
echo "*                                                                       *"
echo "*                       Autosuggestion Installer                        *"
echo "*                                                                       *"
echo "*                                                                       *"
echo "*************************************************************************"
sleep 1
echo ""
echo "This installer will install Autosuggestion on your system."
sleep 1
echo "Checking if you have the required permissions..."
if [ "$(id -u)" != "0" ]; then
    echo "You need to be root to install Autosuggestion."
    exit 1
else
    echo "\e[32mOK\e[0m"
    sleep 1
fi
echo ""
echo "Checking if you have the required dependencies..."
sleep 1
echo "zsh"
sleep 1
if [ -z "$(which zsh)" ]; then
    echo "Zsh is not installed. Please install zsh first."
    exit 1
else
    echo "\e[32mOK\e[0m"
    sleep 1
fi
echo "git"
sleep 1
if [ -z "$(which git)" ]; then
    echo "Git is not installed. Please install git first."
    exit 1
else
    echo "\e[32mOK\e[0m"
    sleep 1
fi
echo "All dependencies are installed, starting installation..."
sleep 1
echo "Moving command-not-found..."
sudo mv resources/command-not-found /usr/lib
sleep 1
echo "Installing autosuggestion..."
sudo mv resources/zsh-autosuggestions /usr/share
sleep 1
echo "Installing syntax highlighting..."
sudo mv resources/zsh-syntax-highlighting /usr/share
sleep 1
echo "Installing command-not-found for zsh..."
sudo mv resources/zsh_command_not_found /etc/
sleep 1
echo "Installing autosuggestion for zsh..."
sudo cat resources/zshrc >> ~/.zshrc
sleep 1
echo "You're all set! Enjoy autosuggestion!"
exit 0