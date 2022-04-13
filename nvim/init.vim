:set relativenumber
:set nocompatible 
:set autoindent
:set syntax=on

call plug#begin('~/.local/share/nvim/plugged')

Plug 'vim-python/python-syntax'                    
Plug 'ap/vim-css-color'
Plug 'tpope/vim-sleuth'
Plug 'editorconfig/editorconfig-vim'
Plug 'ms-jpq/coq_nvim'
Plug 'sbdchd/neoformat'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'windwp/windline.nvim'

call plug#end()

set expandtab
set tabstop=4
set shiftwidth=4

augroup fmt
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat
augroup END

lua << END
require('wlsample.airline')
--  the animated alternative. you can toggle animation by press `<leader>u9`
-- require('wlsample.airline_anim')
END
