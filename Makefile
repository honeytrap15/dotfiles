USERHOME:=/home/hiro

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
	sh -c 'curl -fLo ${USERHOME}/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	chown -R hiro:hiro ${USERHOME}/.local
install_python:
	apt install -y python3-pip
	python3 -m pip install -U pip
	python3 -m pip install neovim isort

install_npm:
	apt install -y nodejs npm
	npm -g install n
	n stable
	apt purge -y nodejs npm

install_pyenv:
	apt install -y libffi-dev libssl-dev zlib1g-dev liblzma-dev libbz2-dev libreadline-dev libsqlite3-dev libopencv-dev tk-dev
	git clone git://github.com/yyuu/pyenv.git ${USERHOME}/.pyenv
	chown -R hiro:hiro ${USERHOME}/.pyenv

install_phpenv:
	apt install -y libxml2-dev libkrb5-dev libssl-dev libsqlite3-dev libbz2-dev libcurl4-openssl-dev libpng-dev libjpeg-dev libfreetype6-dev libonig-dev libxslt1-dev libtidy-dev libzip-dev
	git clone git://github.com/phpenv/phpenv.git ${USERHOME}/.phpenv
	git clone git://github.com/php-build/php-build $(phpenv root)/plugins/php-build
	chown -R hiro:hiro ${USERHOME}/.phpenv
	curl -sS https://getcomposer.org/installer | php
	mv ./composer.phar /usr/local/bin/composer
