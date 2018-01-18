SHELL := /bin/bash
CURRENT_DIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

all: clean setup test

clean:
	@echo "Clean"
	rm -rf .py27

setup:
	@echo "Setup"
	virtualenv .py27
	.py27/bin/pip install -r requirements.txt
	.py27/bin/pip install ansible python-jenkins
	.py27/bin/ansible-galaxy install -r roles/roles_requirements.yml --force --no-deps -p roles

test:
	@echo "Run Tests"
	.py27/bin/pybot test.robot
