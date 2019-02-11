DIR = $(shell dirname $(realpath $(MAKEFILE_LIST)))
OS  = $(shell uname | tr '[A-Z]' '[a-z]')
SCRIPT = $(DIR)/setup_$(OS).sh

init:
	@echo '==> Start to initialize'
	@$(SCRIPT) init

deploy:
	@echo '==> Start to deploy dotfiles to home directory.'
	@$(SCRIPT) deploy $(DIR)

clean:
	@echo '==> Remove dot files in your home directory...'
	@$(SCRIPT) clean

update:
	@echo '==> Updating dot files in your home directory...'
	@make clean
	@git pull
	@make deploy
