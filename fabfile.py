# coding: utf-8

import os
import urllib
import urlparse
import zipfile


from fabric.api import env, task, local, lcd
from git import Repo

env.user = os.environ['USER']
env.home = os.environ['HOME']
env.vim_root = '%(home)s/.vim' % env
env.vim_autoload = '%(vim_root)s/autoload' % env
env.vim_bundle = '%(vim_root)s/bundle' % env
env.vim_syntax = '%(vim_root)s/syntax' % env

git_bundles = [
    'https://github.com/Raimondi/delimitMate.git',
    'https://github.com/SirVer/ultisnips.git',
    'https://github.com/davidhalter/jedi-vim.git',
    'https://github.com/elzr/vim-json.git',
    'https://github.com/ervandew/supertab.git'
    'https://github.com/godlygeek/tabular.git',
    'https://github.com/jmcantrell/vim-virtualenv.git',
    'https://github.com/kien/ctrlp.vim.git',
    'https://github.com/moll/vim-bbye.git'
    'https://github.com/nathanaelkane/vim-indent-guides.git',
    'https://github.com/scrooloose/syntastic.git',
    'https://github.com/sjl/gundo.vim.git',
    'https://github.com/tomasr/molokai.git',
    'https://github.com/tomtom/tcomment_vim.git',
    'https://github.com/tpope/vim-repeat.git',
    'https://github.com/tpope/vim-surround.git',
    'https://github.com/tpope/vim-unimpaired.git',
    'https://github.com/xolox/vim-misc.git',
    'https://github.com/xolox/vim-session.git',
]

vim_org_bundles = [
    # destination;script id;file name
    'bufexplorer;20031;bufexplorer-7.3.6.zip',
]

vim_org_scripts = [
    # destination;script id;file name
    'syntax;17736;django.vim',
    'syntax;20632;python.vim',
]


def download_from_vim_org(conf, prefix_path=''):
    url = 'http://www.vim.org/scripts/download_script.php?src_id='
    destination, script_id, name = conf.split(';')
    url += script_id
    destination = os.path.join(prefix_path, destination)
    local('mkdir -p %s' % destination)
    destination_file = os.path.join(destination, name)
    urllib.urlretrieve(url, destination_file)

    if name.endswith('.zip'):
        with zipfile.ZipFile(destination_file) as myzip:
            myzip.extractall(destination)
        os.remove(destination_file)


@task
def create_vimrc_link():
    """Create a symlink for vimrc"""
    try:
        os.symlink(os.path.join('%(vim_root)s' % env, 'vimrc'),
                   os.path.join('%(home)s' % env, '.vimrc'))
    except OSError as e:
        print 'Warning: %s' % e


@task
def create_vim_layout_directories():

    with lcd(env.vim_root):
        local('mkdir -p %(vim_autoload)s' % env)
        local('mkdir -p %(vim_bundle)s' % env)
        local('mkdir -p %(vim_syntax)s' % env)


@task
def install_pathogen():
    """Intall pathogen.vim"""
    url = 'https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim'  # noqa
    urllib.urlretrieve(url, os.path.join(env.vim_autoload, 'pathogen.vim'))


def local_repository_for_bundle(bundle):
    """Return local repository absolute path"""
    destination = os.path.split(urlparse.urlparse(bundle).path)[-1]
    if destination.endswith('.git'):
        destination = destination[:-4]
    return destination


@task
def install_bundles():
    """Install bundles"""
    for bundle in git_bundles:
        destination = local_repository_for_bundle(bundle)

        print 'Cloning %s' % destination
        Repo.clone_from(bundle, os.path.join(env.vim_bundle, destination))

    for bundle in vim_org_bundles:
        print 'Downloading %s' % bundle.split(';')[-1]
        download_from_vim_org(bundle, prefix_path=env.vim_bundle)

    # Install Powerline using pip
    local('pip install --user git+git://github.com/Lokaltog/powerline')


@task
def install_scripts():

    for script in vim_org_scripts:
        print 'Downloading %s' % script.split(';')[-1]
        download_from_vim_org(script)


@task
def fresh_install():
    create_vim_layout_directories()
    install_pathogen()
    install_bundles()
    install_scripts()
    create_vimrc_link()


@task
def update_bundles():
    """Update bundles"""
    for bundle in git_bundles:
        destination = local_repository_for_bundle(bundle)
        print 'Updating %s' % destination
        r = Repo(os.path.join(env.vim_bundle, destination))
        r.remotes.origin.pull()
    # Upgrade Powerline using pip
    local('pip install --user -U git+git://github.com/Lokaltog/powerline')
