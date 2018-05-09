
NEOVIM_REPO="https://github.com/neovim/neovim.git"

.SILENT:\
	install_usual\
	install_develop\
	install_nvim_head

all: install_usual install_develop install_nvim_head create_symlink

install_usual:
	echo
	echo "---- install usual packages start ----"
	echo "---- install usual packages end   ----"

install_develop:
	echo
	echo "---- install depends packages start ----"
	apt install -y\
		clang\
		cmake\
		libtool\
		tmux\
		pkg-config\
		python3\
		python3-pip\
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

create_symlink:
	echo
	./create_symlink
