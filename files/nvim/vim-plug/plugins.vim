" || Plugins
call plug#begin('~/.config/nvim/plugged')

" coc - IDE features
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
Plug 'neoclide/coc-snippets', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-prettier', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-eslint', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-tslint', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-css', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-lists', {'do': 'yarn install --frozen-lockfile'} " mru and stuff
Plug 'neoclide/coc-highlight', {'do': 'yarn install --frozen-lockfile'} " color highlighting

" motion
Plug 'easymotion/vim-easymotion'
Plug 'haya14busa/incsearch-easymotion.vim'
Plug 'terryma/vim-smooth-scroll'

" nerdtree
Plug 'preservim/nerdtree'

" status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" surround
Plug 'tpope/vim-surround'

" syntax
Plug 'leafgarland/typescript-vim'
Plug 'HerringtonDarkholme/yats'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'tikhomirov/vim-glsl'
Plug 'hashivim/vim-terraform'
Plug 'tpope/vim-commentary'

" themes
Plug 'projekt0n/github-nvim-theme'

" file navigation
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" tmux
Plug 'christoomey/vim-tmux-navigator'

" " completion
" Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins' }
" Plug 'Shougo/vimproc', { 'do': 'make' }
" Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
" Plug 'Quramy/tsuquyomi'
" Plug 'mattn/emmet-vim'

" git
Plug 'tpope/vim-fugitive'

Plug 'jesseleite/vim-agriculture'

call plug#end()
