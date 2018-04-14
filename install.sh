#!/bin/bash

set -ex

apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y apt-transport-https software-properties-common unzip wget \
	    curl screen apt-utils make bzip2 git build-essential tmux libssl-dev \
	    sbcl python3 libzmq3-dev

cd /root/
curl -o get-pip.py https://bootstrap.pypa.io/get-pip.py
python3 get-pip.py

apt-get install libyaml-dev -y

python3 -m pip install --upgrade pip
python3 -m pip install jupyter

cd /root/
curl -o /root/quicklisp.lisp https://beta.quicklisp.org/quicklisp.lisp
if [ ! -e /root/.sbclrc ]; then
    sbcl --non-interactive --load quicklisp.lisp --eval '(quicklisp-quickstart:install :path "/root/quicklisp/")' --eval '(with-open-file (out "/root/.sbclrc" :direction :output) (format out "(load \"/root/quicklisp\/setup.lisp\")"))';
fi
# wget http://beta.quicklisp.org/quicklisp.lisp
# sbcl --load quicklisp.lisp --eval '(progn (quicklisp-quickstart:install) (sb-ext:exit))'

cd /root/
git clone https://github.com/fredokun/cl-jupyter.git
cd cl-jupyter
python3 install-cl-jupyter.py
sbcl --load cl-jupyter.lisp

