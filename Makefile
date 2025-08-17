install: install-command install-config install-dotfiles

CONFIG_SRC_DIR := $(CURDIR)/.config

install-command:
	@command -v trash > /dev/null || brew install trash
	@command -v btop > /dev/null || brew install btop

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
	@echo "Linking directories from $(DOTFILES) to $$HOME"
	@for dir in $$(find $(DOTFILES) -type f); do \
	  name=$$(basename $$dir); \
	  target="$$HOME/$$name"; \
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
