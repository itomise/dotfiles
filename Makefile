install: install-command install-config install-dotfiles

CONFIG_SRC_DIR := $(CURDIR)/.config

install-command:
	@command -v trash > /dev/null || brew install trash
	@command -v btop > /dev/null || brew install btop
	@command -v pure > /dev/null || brew install pure
	@command -v asdf > /dev/null || brew install asdf
	@command -v gh > /dev/null || brew install gh
	@command -v tig > /dev/null || brew install tig
	@brew list font-0xproto-nerd-font > /dev/null 2>&1 || brew install font-0xproto-nerd-font

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

DOTFILES := $(CURDIR)/home

install-dotfiles:
	@echo "Linking dotfiles from $(DOTFILES) to $$HOME"
	@for item in $$(find $(DOTFILES) -mindepth 1 -maxdepth 1); do \
	  name=$$(basename $$item); \
	  target="$$HOME/$$name"; \
	  if [ -L "$$target" ]; then \
	    current=$$(readlink "$$target"); \
	    if [ "$$current" = "$$item" ]; then \
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
	  echo "→ Linking $$target -> $$item"; \
	  ln -s "$$item" "$$target"; \
	done
