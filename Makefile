.PHONY: install

CONFIG_SRC_DIR := $(CURDIR)/.config

# Dotfiles list (src -> dst)
DOTFILES := \
	gitconfig:$(HOME)/.gitconfig

.PHONY: install install-config

# Default task

install: install-config install-dotfiles
	@command -v trash > /dev/null || brew install trash

# -----------------------------------------------------------------------------
# Link every directory directly under ./\.config to "$HOME/.config/<name>".
#
#  - Creates "$HOME/.config" if it does not exist.
#  - If the target already exists as a symlink pointing to the same location,
#    nothing is done.
#  - If the target exists as a symlink pointing elsewhere, it is replaced by a
#    new symlink.
#  - If the target exists as a regular file/directory, it is backed up by
#    renaming to "<name>.bak.<timestamp>" before the symlink is created.
# -----------------------------------------------------------------------------
install-config:
	@echo "Linking directories from $(CONFIG_SRC_DIR) to $$HOME/.config"
	@mkdir -p $$HOME/.config
	@for dir in $$(find $(CONFIG_SRC_DIR) -mindepth 1 -maxdepth 1 -type d); do \
	  name=$$(basename $$dir); \
	  target="$$HOME/.config/$$name"; \
	  if [ -L "$$target" ]; then \
	    current=$$(readlink "$$target"); \
	    if [ "$$current" = "$$dir" ]; then \
	      echo "✓ $$target already linked"; \
	      continue; \
	    else \
	      echo "↺ Replacing existing symlink $$target"; \
	      rm "$$target"; \
	    fi; \
	  elif [ -e "$$target" ]; then \
	    backup="$$target.bak.$$(date +%s)"; \
	    echo "⚠  $$target exists, backing up to $$backup"; \
	    mv "$$target" "$$backup"; \
	  fi; \
	  echo "→ Linking $$target -> $$dir"; \
	  ln -s "$$dir" "$$target"; \
	done

# -----------------------------------------------------------------------------
# Link individual dotfiles (./<src>) to destination ($HOME/.*)
# -----------------------------------------------------------------------------
.PHONY: install-dotfiles link-dotfile

install-dotfiles:
	@echo "Linking individual dotfiles"
	@$(foreach df,$(DOTFILES),$(MAKE) --no-print-directory link-dotfile src=$(firstword $(subst :, ,$(df))) dst=$(word 2,$(subst :, ,$(df)));)

# Internal target: create/replace symlink
link-dotfile:
	@src="$(src)"; dst="$(dst)"; \ 
	if [ ! -e "$$src" ]; then echo "⛔ $$src does not exist"; exit 1; fi; \ 
	if [ -L "$$dst" ] && [ "$$src" = "$$(readlink $$dst | sed 's|^$(CURDIR)/||')" ]; then \ 
	  echo "✓ $$dst already linked"; \ 
	elif [ -e "$$dst" ]; then \ 
	  backup="$$dst.bak.$$(date +%s)"; \ 
	  echo "⚠ $$dst exists, backing up to $$backup"; \ 
	  mv "$$dst" "$$backup"; \ 
	  ln -s "$(CURDIR)/$$src" "$$dst"; \ 
	else \ 
	  echo "→ Linking $$dst -> $(CURDIR)/$$src"; \ 
	  ln -s "$(CURDIR)/$$src" "$$dst"; \ 
	fi
