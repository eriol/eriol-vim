# coding: utf-8

import os
import urllib
import zipfile


from fabric.api import env, task, local, lcd

env.user = os.environ['USER']
env.home = os.environ['HOME']
env.vim_root = '%(home)s/.vim' % env
env.vim_autoload = '%(vim_root)s/autoload' % env
env.vim_plugged = '%(vim_root)s/plugged' % env
env.vim_syntax = '%(vim_root)s/syntax' % env

vim_org_bundles = [
    # destination;script id;file name
]

vim_org_scripts = [
    # destination;script id;file name
    'syntax;17736;django.vim',
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
        local('mkdir -p %(vim_plugged)s' % env)
        local('mkdir -p %(vim_syntax)s' % env)


@task
def install_vim_plug():
    """Intall plug.vim"""
    url = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    urllib.urlretrieve(url, os.path.join(env.vim_autoload, 'plug.vim'))


@task
def install_scripts():

    for script in vim_org_scripts:
        print 'Downloading %s' % script.split(';')[-1]
        download_from_vim_org(script)


@task
def fresh_install():
    create_vim_layout_directories()
    install_vim_plug()
    # install_scripts()
