#!/usr/bin/env python
import pika
import os

# http://www.rabbitmq.com/tutorials/tutorial-one-python.html

serverip=os.environ['serverip']
connection = pika.BlockingConnection(pika.ConnectionParameters(serverip))
channel = connection.channel()
