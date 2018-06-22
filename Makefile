
NEOVIM_REPO="https://github.com/neovim/neovim.git"

.SILENT:\
	install_usual\
	install_develop\
	install_nvim_head

all: install_usual install_develop install_nvim_stable create_symlink setup_neovim

add_backports:
	echo
	echo "---- add backports repo ----"
	bash -c "echo deb http://deb.debian.org/debian stretch-backports main >> /etc/apt/sources.list"

install_usual:
	echo
	echo "---- install usual packages start ----"
	apt install -y\
		tig
	echo "---- install usual packages end   ----"

install_develop:
	echo
	echo "---- install depends packages start ----"
	apt install -y\
		automake\
		clang\
		clang-format\
		cmake\
		curl\
		golang\
		libtool\
		m4\
		nim\
		tmux\
		pkg-config\
		python3\
		python3-pip\
		unzip\
		wget\
		zsh
	echo "---- install depends packages end   ----"

install_nvim_stable:
	echo
	echo "---- install neovim ----"
	wget https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz
	tar zxf nvim-linux64.tar.gz
	mv nvim-linux64/bin/nvim /usr/local/bin
	rm nvim-linux64.tar.gz
	rm -rf nvim-linux64

.PHONY: create_symlink
create_symlink:
	echo
	./create_symlink

setup_neovim:
	echo
	./nvim/nvim_setup
