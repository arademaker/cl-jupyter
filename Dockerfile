FROM ubuntu:16.04

WORKDIR /root
COPY install.sh /root/
# COPY jupyter_notebook_config.py /root/

RUN bash /root/install.sh

CMD jupyter notebook --ip=0.0.0.0 --port=8080 --allow-root

