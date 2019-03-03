DIR = $(shell dirname $(realpath $(MAKEFILE_LIST)))
OS  = $(shell uname | tr '[A-Z]' '[a-z]')
SCRIPT = $(DIR)/setup_$(OS).sh

init:
	@echo '==> Start to initialize...'
	@$(SCRIPT) init

deploy:
	@echo '==> Start to deploy dotfiles...'
	@$(SCRIPT) deploy $(DIR)

clean:
	@echo '==> Remove dotfiles...'
	@$(SCRIPT) clean

update:
	@echo '==> Update dotfiles...'
	@make clean
	@git pull
	@make deploy
