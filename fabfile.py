# coding: utf-8

import os
import urllib
import zipfile


from fabric.api import env, task, local, lcd

env.user = os.environ['USER']
env.home = os.environ['HOME']
env.vim_root = '%(home)s/.vim' % env
env.vim_autoload = '%(vim_root)s/autoload' % env
env.vim_bundle = '%(vim_root)s/bundle' % env
env.vim_syntax = '%(vim_root)s/syntax' % env

vim_org_bundles = [
    # destination;script id;file name
]

vim_org_scripts = [
    # destination;script id;file name
    'syntax;17736;django.vim',
    'syntax;21056;python.vim',
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


@task
def install_bundles():
    """Install bundles"""

    local('vopher -f vopher.list -dir %(vim_bundle)s up' % env)

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

    local('vopher -f vopher.list -force -dir %(vim_bundle)s up' % env)
    # Upgrade Powerline using pip
    local('pip install --user -U git+git://github.com/Lokaltog/powerline')
