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

# TODO
### command line syntax 
### set up language server
### tmux integration?

