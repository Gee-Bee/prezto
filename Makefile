runcoms := zlogin zlogout zpreztorc zprofile zshenv zshrc

.PHONY: install
install: $(runcoms:%=~/.%)

~/.%: runcoms/%
	@[ -e $@ ] || (ln -s $(realpath $^) $@ && echo "Link created $@")

.PHONY: clean
clean: $(runcoms:%=unlink_%)

.PHONY: unlink_%
unlink_%:
	@[ ! -h ~/.$* ] || ( rm -f ~/.$* && echo "Removed link ~/.$*" )
