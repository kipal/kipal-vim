FROM debian:jessie

RUN echo "deb http://ftp.debian.org/debian jessie-backports main" >> /etc/apt/sources.list

RUN apt-get update

RUN apt-get -y install apt-utils

RUN apt-get -y -t jessie-backports install vim-nox

COPY vimrc /root/.vimrc

COPY vim /root/.vim

RUN apt-get -y install curl git

RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

WORKDIR "/root/vim-workspace"

ENTRYPOINT [ "vim" ]
