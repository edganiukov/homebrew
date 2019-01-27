# Packages

## Homebrew formula for the [Eclipse JDT Language Server](https://github.com/eclipse/eclipse.jdt.ls)

### Install
```sh
brew install https://raw.githubusercontent.com/edganiukov/homebrew/master/jdt-ls.rb
```

### Vim integration

First install install [vim-lsp](https://github.com/prabirshrestha/vim-lsp) plugin, and then register `jdt-lsp` in your vimrc:
```lua
if executable('jdt-ls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'jdt-ls',
        \ 'cmd': {server_info->['jdt-ls',
          \ '-data', lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'pom.xml')),
          \ ]},
        \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'pom.xml'))},
        \ 'whitelist': ['java'],
        \ })
endif
```
