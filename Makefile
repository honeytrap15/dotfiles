
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
		git\
		gperf\
		libjemalloc-dev\
		libluajit-5.1-dev\
		libmsgpack-dev\
		libtermkey-dev\
		libunibilium-dev\
		libuv1-dev\
		libvterm-dev\
		lua-lpeg\
		lua-mpack\
		tmux\
		pkg-config\
		python3\
		python3-pip\
		zsh
	echo "---- install depends packages end   ----"

install_nvim_head:
	echo
	rm -rf /tmp/neovim
	cd /tmp;\
		git clone $(NEOVIM_REPO)
	mkdir /tmp/neovim/build
	cd /tmp/neovim/build; cmake ..;\
		make CMAKE_BUILD_TYPE=RelWithDebInfo;\
		make install
	rm -rf /tmp/neovim

create_symlink:
	echo
	./create_symlink
