-- Lua linter configuration file
-- Suppresses "unused variable/argument" warnings
std = {
  globals = {
    "vim",        -- Neovim API
    "assert",     -- For tests
    "describe",   -- For tests
    "it",         -- For tests
    "before_each",-- For tests
    "after_each", -- For tests
    "pending",    -- For tests
    "teardown",   -- For tests
  },
}

-- Don't report unused self arguments of methods
self = false

-- Only allow symbols available in all Lua versions
std = "min"

-- Global objects defined by the C code
globals = {
  "vim",
}

-- Don't check submodules
exclude_files = {
  "lua/plugins/**/*.lua", -- Don't check plugins directory
}

-- Rerun tests only if their modification time changed
cache = true

-- Don't warn when accessing undefined fields of global vim
files["lua/**/*.lua"] = {
  globals = {"vim"},
  read_globals = {"vim"},
}