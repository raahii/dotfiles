DIR = $(shell dirname $(realpath $(MAKEFILE_LIST)))
OS  = $(shell uname | tr '[A-Z]' '[a-z]')
SCRIPT = $(DIR)/setup_$(OS).sh

init:
	@echo '==> Initializing...'
	@$(SCRIPT) init
	@echo 'Done'

deploy:
	@echo '==> Deploying dotfiles...'
	@mkdir -p ${HOME}/.config/fish
	@mkdir -p ${HOME}/.config/nvim
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
