DIR = $(shell cd $(dirname $0); pwd)
OS  = $(shell uname | tr '[A-Z]' '[a-z]')

init:
	@echo '==> Start to initialize'
	@echo $(DIR)/dotfiles/setup_$(OS).sh init

deploy:
	@echo '==> Start to deploy dotfiles to home directory.'
	@echo $(DIR)/dotfiles/setup_$(OS).sh deploy $(DIR)

clean:
	@echo '==> Remove dot files in your home directory...'
	@$(DIR)/dotfiles/setup_$(OS).sh clean

hello:
	@echo 'Hello, make!'
