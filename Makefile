DIR = $(shell dirname $(realpath $(MAKEFILE_LIST)))
OS  = $(shell uname | tr '[A-Z]' '[a-z]')
SCRIPT = $(DIR)/setup_$(OS).sh

init:
	@echo '==> Initializing...'
	@$(SCRIPT) init
	@echo 'Done'

deploy:
	@echo '==> Deploying dotfiles...'
	@$(SCRIPT) deploy $(DIR)
	@echo 'Done'

clean:
	@echo '==> Removing dotfiles...'
	@$(SCRIPT) clean
	@echo 'Done'

update:
	@echo '==> Updating dotfiles...'
	@make clean
	@git pull
	@make deploy
	@echo 'Done'
