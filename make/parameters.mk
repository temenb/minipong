PRISMA_SERVICES := auth profile engine fallout
NODE_SERVICES := gateway auth profile engine fallout
GIT_SERVICES:= auth profile
FLUTTER_SERVICES := front

NODE_BIN=./node_modules/.bin
SERVICE_DIR := services
BASE_DIR := $(shell pwd)


PROTO_FILES := $(shell find proto -name '*.proto')


NODE_PROTO_PATH=./src/grpc/generated
FLUTTER_PROTO_PATH=./lib/src/grpc/generated

COMMIT_MSG:=tmp