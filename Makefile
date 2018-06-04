
NEOVIM_REPO="https://github.com/neovim/neovim.git"

.SILENT:\
	install_usual\
	install_develop\
	install_nvim_head

all: install_usual install_develop install_nvim_head create_symlink setup_neovim

install_usual:
	echo
	echo "---- install usual packages start ----"
	apt install -y\
		clang-format\
		tig
	echo "---- install usual packages end   ----"

install_develop:
	echo
	echo "---- install depends packages start ----"
	apt install -y\
		automake\
		clang\
		cmake\
		curl\
		wget\
		libtool\
		liblua5.3-dev\
		m4\
		tmux\
		pkg-config\
		python3\
		python3-pip\
		unzip\
		zsh
	echo "---- install depends packages end   ----"

install_nvim_head:
	echo
	cd /tmp;\
		git clone $(NEOVIM_REPO)
	cd /tmp/neovim; rm -rf build;\
		make clean;\
		make CMAKE_BUILD_TYPE=Release;\
		make install
	rm -rf /tmp/neovim

.PHONY: create_symlink
create_symlink:
	echo
	./create_symlink

setup_neovim:
	echo
	./nvim/nvim_setup
