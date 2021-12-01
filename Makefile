CWD = $(shell pwd -P)
ROOT ?= $(realpath $(CWD)/../..)
PROJECT = sentinel

all: compile

include $(ROOT)/make/kz.mk