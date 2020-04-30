Setup your programming Environment on a new machine
===================================================

Setting up Terminal
-------------------

* Setting up colorscheme: Dark theme are cosidered to cause less eye strain.
* Use `dracula <https://draculatheme.com/iterm/>`__ with iTERM on mac and `Dracula colorscheme <https://github.com/dracula/gnome-terminal>`__ with GNOME Terminal on Linux.
* Go to Terminal -> Preferences -> Settings -> Keyboard -> Select use option as meta keys
* Go to Terminal -> Preferences -> Settings -> Keyboard -> Delete shortcuts having (Alt + left arrow) and (Alt + Right arrow)
* Install `source code pro <https://www.rogerpence.com/posts/install-source-code-pro-font-on-ubuntu>`__ font on Ubuntu.
* Set the font in terminal profiles as well.


Setup zshrc
-----------

* Most linux installations come with `bash` as the default shell. Many (including me), opine that :code:`zsh` is better.
* `Apple replaces bash with zsh <https://www.theverge.com/2019/6/4/18651872/apple-macos-catalina-zsh-bash-shell-replacement-features>`__
* Installation with sudo access :code:`sudo apt install zsh`
* Installation without sudo :code:`sudo apt install zsh`

  * Go to https://www.zsh.org/pub and download :code:`wget https://www.zsh.org/pub/zsh-5.7.1.tar.xz`
  * :code:`tar -xzf zsh-5.7.1.tar.xz && rm zsh-5.7.1.tar.xz && cd zsh-5.7.1`
  * :code:`mkdir ~/local && ./configure --prefix=$HOME/local && make && make check && make install`
  * :code:`echo "export PATH=$HOME/local/bin:$PATH" >> ~/.bashrc`
  * :code:`echo "exec zsh" >> ~/.bashrc`
  * Then restart the shell.
  * Refer `How to install zsh, oh-my-zsh without sudo <https://franklingu.github.io/programming/2016/05/24/setup-oh-my-zsh-on-ubuntu-without-sudo/>`__

* For plugin management install `oh-my-zsh <https://github.com/ohmyzsh/ohmyzsh.git>`__

  * With sudo:
    .. code-block:: bash

       sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`
  * Without sudo:
    * First switch to zsh
    .. code-block:: bash

       curl https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | \
       sed -e 's/grep\ \/zsh\$\ \/etc\/shells/which zsh/g' | zsh`

* Most useful plugins are git, fasd, zsh-autosuggestions, zsh-syntax-highlighting, zsh-completions, z
* Use `spaceship theme <https://github.com/denysdovhan/spaceship-prompt>`__
* Download the `zshrc file <config_files/sample.zshrc>`_ ans place it in $HOME.


Setup Editor
------------

* Nvim is available at https://github.com/neovim/neovim.git
* Installation:

  * With sudo access: :code:`sudo apt install neovim && sudo apt install python3-neovim` (since ubuntu 18.04)
  * Without sudo: Download a `pre-built image <https://github.com/neovim/neovim/releases/tag/v0.4.3>`__ (currently, nvim-linux64.tar.gz)
  * Make sure that the path to desired nvim exists is $PATH
  * For Mac, `brew install neovim` also should work.

* Setup

  * Install vim-plug plugin manager from https://github.com/junegunn/vim-plug
  * Make sure that the following structure exists in your machine :code:`$HOME/.config/nvim/init.vim`
  * Download :download:`Init Vim file <./config_files/sample_init.vim>` and place it in the above described path.
  * :code:`pip install pynvim jedi`

* Plugins

  * All plugins can be installed by running :code:`:PlugInstall` in nvim
  * The Coc nvim plugin (available at https://github.com/neoclide/coc.nvim.git) requires more setup.

    * Install nodejs on your machine by downloading the binary from https://nodejs.org/en/download/
    * Install coc-python using :code:`:CocInstall coc-python`
    * Set the desired python interpreter using :code:`:CocCommand python.setInterpreter`. Do checkout other options by using :code:`:CocCommand` 

* Additionally install a terminal based editor micro

  * :code:`breq install micro`
  * Download the required package from https://github.com/zyedidia/micro/releases
  * :code:`tar -xvf micro-1.2.1-60-linux64.tar.gz`
  * Point the :code:`$PATH` variable to include :code:`micro-1.x.x/micro`
  * Execute `micro` command from terminal in a normal fashion.


Setup TMUX
----------

* Install tmux locally by cloning the repo https://github.com/tmux/tmux.git

  * :code:`cd <tmux_install_folder> && sh autogen.sh && ./configure && make`
  * To install without sudo access, try :code:`export DESTDIR=<local_dir_path> make install`
  * Other alternative is given here https://www.gnu.org/prep/standards/html_node/DESTDIR.html

* Download `Tmux config file <./config_files/sample_tmux.conf>`_ and place it in :code:`$HOME`.
* Read the config file for explanations regarding multple options.


Setup OneDrive
--------------

* Use Microsoft OneDrive storage to sync all your files across different machines
* Installation

  * In a local opt folder, :code:`git clone https://github.com/abraunegg/onedrive.git`
  * :code:`make && export DESTDIR=$HOME/opt/onedrive/ make install`
  * Make sure that :code:`$PATH` points to this folder
  * Try :code:`onedrive -h` for exploring various options.
