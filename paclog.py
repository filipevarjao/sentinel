#!/usr/bin/env python3

from sklearn.feature_extraction.text import HashingVectorizer
from sklearn.neighbors import NearestNeighbors
import socket
import time

def follow(thefile):
  thefile.seek(0,2)
  while True:
    line = thefile.readline()
    if not line:
      time.sleep(0.1)
      continue
    yield line

def converted_to_numeric(logline):
  vectorizer = HashingVectorizer(n_features=2**20)
  X = vectorizer.fit_transform(logline)
  return X

def start_paclog(Vector_failure, sock):
  nn = NearestNeighbors()
  nn.fit(Vector_failure)

  logfile = open("../../_rel/kazoo/log/console.log","r")
  loglines = follow(logfile)
  # min_distance = 0.3
  for line in loglines:
    Log = converted_to_numeric([line])
    distances = nn.kneighbors(Log)[0]

    if distances[0][0] <= 0.5:
      # smallest_distance = distances[0][0]
      msg = "%.2f" % distances[0][0]
      msg = msg + line
      print(msg)
    else:
      msg = "%.2f" % distances[0][0]
    # lif distances[0][0] <= min_distance:
      # min_distance = distances[0][0]

    sock.sendto(bytes(msg, "utf-8"), ('127.0.0.1', 8789))

def connect_to_kazoo_node():
  sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM) # UDP
  return sock
  # sock.sendto(bytes("Hello, World!", "utf-8"), ('127.0.0.1', 8789))

def load_datasets():
  failure = open("../../_rel/kazoo/log/error.log", "r").readlines()
  vectorizer = HashingVectorizer(n_features=2**20)
  V_failure = vectorizer.transform(failure)

  return V_failure

if __name__ == '__main__':
  skt = connect_to_kazoo_node()
  V_failure = load_datasets()
  start_paclog(V_failure, skt)