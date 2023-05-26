
all: install-dependencies install

install-dependencies:
	dnf install rsync wget bash-completion bash tar -y

install:
	bash install-blesh.sh
