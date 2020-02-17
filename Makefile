runcoms := zlogin zlogout zpreztorc zprofile zshenv zshrc

install: $(runcoms:%=ln_%)
	@echo "Links created"

ln_%:
	@[ -e ~/.$* ] || ln -s $(realpath runcoms/$*) ~/.$*

clean: $(runcoms:%=unlink_%)
	@echo "Links removed"

unlink_%:
	@[ ! -h ~/.$* ] || rm -f ~/.$*