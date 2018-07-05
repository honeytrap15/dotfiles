
NEOVIM_REPO="https://github.com/neovim/neovim.git"

.SILENT:\
	add_backports\
	install_usual\
	install_develop\
	install_nvim_stable\
	setup_neovim

all: add_backports install_usual install_develop install_nvim_stable create_symlink setup_neovim

add_backports:
	echo
	echo "---- add backports repo start ----"
	bash -c "echo deb http://deb.debian.org/debian stretch-backports main >> /etc/apt/sources.list"
	echo "OK"
	echo "---- add backports repo end ----"

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

install_choosenim:
	curl https://nim-lang.org/choosenim/init.sh -sSf | sh

.PHONY: create_symlink
create_symlink:
	echo
	./create_symlink

setup_neovim:
	echo
	./nvim/nvim_setup
