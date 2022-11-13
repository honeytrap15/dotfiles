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

install_vimplug:
	sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

install_pyenv:
	apt install -y libffi-dev libssl-dev zlib1g-dev liblzma-dev libbz2-dev libreadline-dev libsqlite3-dev libopencv-dev tk-dev
	git clone git@github.com:yyuu/pyenv.git ${USERHOME}/.pyenv
	chown -R hiro:hiro ${USERHOME}/.pyenv

install_phpenv:
	apt install -y libxml2-dev libkrb5-dev libssl-dev libsqlite3-dev libbz2-dev libcurl4-openssl-dev libpng-dev libjpeg-dev libfreetype6-dev libonig-dev libxslt1-dev libtidy-dev libzip-dev
	git clone https://github.com/phpenv/phpenv.git ${USERHOME}/.phpenv
	git clone https://github.com/php-build/php-build ${USERHOME}/.phpenv/plugins/php-build
	chown -R hiro:hiro ${USERHOME}/.phpenv

install_composer:
	curl -sS https://getcomposer.org/installer | php
	sudo mv ./composer.phar /usr/local/bin/composer
