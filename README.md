# Packages

## Homebrew formula for the [Eclipse JDT Language Server](https://github.com/eclipse/eclipse.jdt.ls)

### Install
```sh
brew install https://raw.githubusercontent.com/edganiukov/homebrew/master/jdt-ls.rb
```

### Usage
Create a start-up script: `/usr/local/bin/jdt-ls`
```sh
#!/bin/bash
JDT_LS_HOME="/usr/local/Cellar/jdt-ls/0.32.0-201901171733/libexec"
JDT_LS_LAUNCHER=$(find $JDT_LS_HOME -name "org.eclipse.equinox.launcher_*.jar")
JDT_LS_HEAP_SIZE=${JDT_LS_HEAP_SIZE:=-Xmx1G}

java /
  -Declipse.application=org.eclipse.jdt.ls.core.id1 /
  -Dosgi.bundles.defaultStartLevel=4 /
  -Declipse.product=org.eclipse.jdt.ls.core.product /
  -Dlog.protocol=true /
  -Dlog.level=ALL /
  -noverify /
  $JDT_LS_HEAP_SIZE /
  -jar "$JDT_LS_LAUNCHER" /
  -configuration "$JDT_LS_HOME/config_mac" /
  "$@"
```

### Vim integration

First install install [vim-lsp](https://github.com/prabirshrestha/vim-lsp) plugin, and then register `jdt-lsp` in your vimrc:
```lua
if executable('jdt-ls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'jdt-ls',
        \ 'cmd': {server_info->['jdt-ls',
          \ '-data', lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'pom.xml')),
          \ '--add-modules=ALL-SYSTEM ',
          \ '--add-opens', 'java.base/java.util=ALL-UNNAMED',
          \ '--add-opens java.base/java.lang=ALL-UNNAMED']},
        \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'pom.xml'))},
        \ 'whitelist': ['java'],
        \ })
endif
```
