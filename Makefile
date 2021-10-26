
NEOVIM_REPO="https://github.com/neovim/neovim.git"

.SILENT:\
	install_nvim_stable\
	setup_neovim

install_peco:
	apt install -y silversearcher-ag
	echo
	echo "---- install peco ----"
	wget https://github.com/peco/peco/releases/download/v0.5.3/peco_linux_amd64.tar.gz
	tar zxf peco_linux_amd64.tar.gz
	mv peco_linux_amd64/peco /usr/local/bin
	rm peco_linux_amd64.tar.gz
	rm -rf peco_linux_amd64

install_nvim:
	echo
	echo "---- install neovim ----"
	wget https://github.com/neovim/neovim/releases/download/v0.5.1/nvim-linux64.tar.gz
	tar zxf nvim-linux64.tar.gz
	mv nvim-linux64/bin/nvim /usr/local/bin
	mv nvim-linux64/share/nvim /usr/local/share
	rm nvim-linux64.tar.gz
	rm -rf nvim-linux64
