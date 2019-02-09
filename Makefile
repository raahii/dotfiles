DIR = $(shell cd $(dirname $0); pwd)
OS  = $(shell uname | tr '[A-Z]' '[a-z]')
SCRIPT = $(DIR)/dotfiles/setup_$(OS).sh

init:
	@echo '==> Start to initialize'
	@$(SCRIPT) init

deploy:
	@echo '==> Start to deploy dotfiles to home directory.'
	@$(SCRIPT) deploy $(DIR)/dotfiles

clean:
	@echo '==> Remove dot files in your home directory...'
	@$(SCRIPT) clean

hello:
	@echo 'Hello, make!'
