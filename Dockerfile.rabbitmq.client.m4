FROM ubuntu:14.04

MAINTAINER Taylor Monacelli <taylormonacelli@gmail.com>

# Taylor's emacs setup
include(`dockerfile-taylor-setup.m4')

# Client testing
RUN sudo apt-get install -y python-pip
RUN sudo pip install pika
RUN git clone https://github.com/taylormonacelli/rabbitmq-practice-ubuntu.git||:
WORKDIR rabbitmq-practice-ubuntu
RUN git pull
