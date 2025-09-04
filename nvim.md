# Neovim / vim tips, tricks, plugins

### nvim configuration videos from scratch (no plugins, using nvim as is)
```
https://www.youtube.com/watch?v=skW3clVG5Fo     from scratch, no plugins
https://www.youtube.com/watch?v=zHTeCSVAFNY     From 0 to IDE in NEOVIM from scratch | FREE COURSE // EP 1 (and ep 2, 3)
https://github.com/nanotee/nvim-lua-guide       Getting started using Lua in Neovim 
:help lua-guide                                 from within neovim
```

### nvim resources
```
https://github.com/LazyVim/LazyVim
```

### neovim as IDE (good series, also on shells, terms, tmux, etc)
```
From 0 to IDE in NEOVIM from scratch | FREE COURSE // EP 1
https://www.youtube.com/watch?v=zHTeCSVAFNY
```

### built-in explorer
```
:Explore
```

### list all buffers
```
:ls
```

### switch to buffer <n>
```
:buf <n>
```

### execute neovim lua code in current buffer
```
:%lua
or
:source
:so
```

### open a terminal
```
:term
```

### open a terminal in the below/right from the current buffers
```
:belowright term
:belowright term go run %
```

### in LazyVim snack indent to disable indent marker animation:
```
vim.g.snacks_animate_indent = false
```

### evaluate and print a vimscript expression
```
:echo <expr>
```

### evaluate and pretty print a lua expression
```
:= <lua expr>
which is the equivalent of :lua print(vim.inspect(<lua expr>))
```

### behavior of require()
Neovim's require() function, used for loading Lua modules, operates by searching for files within directories specified in Neovim's runtimepath and then within the lua/ subdirectory of those locations.
Specifically, when a module is `require()`d (e.g., require("mymodule")), Neovim will look for:
lua/mymodule.lua within each directory in the runtimepath.
lua/mymodule/init.lua within each directory in the runtimepath.
If the module name contains dots (e.g., require("myfolder.mymodule")), Neovim interprets these as directory separators, searching for: lua/myfolder/mymodule.lua and lua/myfolder/mymodule/init.lua.

### nvim functions for listing various things
```
:echo nvim_list_<TAB>
:echo nvim_list_runtime_paths()
```

### notes from TJ Devries's YT "advent of neovim" videos
vim.fn.xxx() functions are built-in to vim from vim-script days which means you can call them via ":echo xxx()"
You can exit the :Lazy dialog with "q"

### manipulating the file path
Note that if nvim's :pwd is not the wd of the file you're editing, ":w anotherfile" won't work as expected, it will 
produce a file "anotherfile"  in nvim's CWD.
:echo expand("%")      current file
:echo expand("%:p")    full path of current file
:echo expand("%:p:h")  full path up to (and including) parent directory of current file
:w %:p:h/another-file  write contents of current file to sibling file in same directory as %

### put the :messages output into a buffer
:new
:put = execute('messages')
(works for any command that can be executed

### problems loading plugins, e.g., in lazy.nvim
check carefully the respository spelling, I spent an hour debugging
why this didn't work
```
return {
	{
		"nvim-mini/mini.nvm", -- <<<< notice ".nvm" instead of ".nvim"
		config = function()
			local statusline = require 'mini.statusline'
			statusline.setup { use_icons = true }
		end
	}
}
```
switching to "git@github.com:" prefix for SSH authentication changed the error message from "couldn't propmt for user name"
to "repository not found" which should have really tipped me off!
# TODO
### command line syntax 
### set up language server
### tmux integration?

