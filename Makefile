AUTOLOAD_DIR=autoload
VIM_PLUG_DIR=plugged

VIM_PLUG='https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

.PHONY: install setup_directories download_vim_plug

install: download_vim_plug
	rm -f ~/.vim
	ln -s `pwd` ~/.vim

setup_directories:
	mkdir -p ${AUTOLOAD_DIR} ${VIM_PLUG_DIR}

download_vim_plug: setup_directories
	wget -O ${AUTOLOAD_DIR}/plug.vim ${VIM_PLUG}
