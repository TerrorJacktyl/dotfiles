set nocompatible
" fix webpack conflict potentially
set backupcopy=yes

" Load plugins
source $HOME/.config/nvim/vim-plug/plugins.vim

" || Plugin config and bindings

" Core (must be first in bindings section)
  " leader is a key that allows you to have your own "namespace" of keybindings.
  " You'll see it a lot below as <leader>
  let mapleader = ","
  
  " autowrite to files whenever we type so we can edit and jumpto as we please
  set autowriteall

  " reload init.vim
  nnoremap <leader>sd :source $MYVIMRC<CR>

  " If you wrap lines, vim by default won't let you move down one line to the
  " wrapped portion. This fixes that.
  noremap j gj
  noremap k gk
" Carpal tunnel prevention
  " So we don't have to press shift when we want to get into command mode.
  nnoremap ; :
  vnoremap ; :
  " So we don't have to reach for escape to leave insert mode.
  inoremap jf <esc>

" buffers
  " create new vsplit, and switch to it.
  noremap <leader>v <C-w>
  " easily split in any direction
  nnoremap <C-h> <C-w>h
  nnoremap <C-j> <C-w>j
  nnoremap <C-k> <C-w>k
  nnoremap <C-l> <C-w>l

" coc
  " https://github.com/neoclide/coc.nvim#example-vim-configuration
  inoremap <silent><expr> <c-space> coc#refresh()

  " gd - go to definition of word under cursor
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)

  " gi - go to implementation
  nmap <silent> gi <Plug>(coc-implementation)

  " gr - find references
  nmap <silent> gr <Plug>(coc-references)

  " gh - get hint on whatever's under the cursor
  nnoremap <silent> K :call <SID>show_documentation()<CR>
  nnoremap <silent> gh :call <SID>show_documentation()<CR>

  function! s:show_documentation()
    if &filetype == 'vim'
      execute 'h '.expand('<cword>')
    else
      call CocAction('doHover')
    endif
  endfunction

  " Highlight symbol under cursor on CursorHold
  autocmd CursorHold * silent call CocActionAsync('highlight')

  nnoremap <silent> <leader>co  :<C-u>CocList outline<cr>
  nnoremap <silent> <leader>cs  :<C-u>CocList -I symbols<cr>

  " list commands available in tsserver (and others)
  nnoremap <silent> <leader>cc  :<C-u>CocList commands<cr>

  " restart when tsserver gets wonky
  nnoremap <silent> <leader>cR  :<C-u>CocRestart<CR>

  " view all errors
  nnoremap <silent> <leader>cl  :<C-u>CocList locationlist<CR>

  " manage extensions
  nnoremap <silent> <leader>cx  :<C-u>CocList extensions<cr>

  " rename the current word in the cursor
  nmap <leader>cr  <Plug>(coc-rename)
  nmap <leader>cf  <Plug>(coc-format-selected)
  vmap <leader>cf  <Plug>(coc-format-selected)

  " run code actions
  vmap <leader>ca  <Plug>(coc-codeaction-selected)
  nmap <leader>ca  <Plug>(coc-codeaction-selected)
  
" comments
  " Map the key for toggling comments with vim-commentary
  nnoremap <leader>c :Commentary<CR>
  " visual gcc togglecomment
  " normal gc{motion}

" easy motion
  """" EASYMOTION begin
    map f <Plug>(easymotion-bd-f)
    nmap s <Plug>(easymotion-overwin-f2)

    " let g:EasyMotion_do_mapping = 0 " Disable default mappings
    " let g:EasyMotion_smartcase = 1
    " nmap f <Plug>(easymotion-overwin-f)
    " map <C-j> <Plug>(easymotion-j)
    " map <C-k> <Plug>(easymotion-k)

  """" EASYMOTION end

" fzf
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow'
  map <C-f> :Rg <CR>
  map <C-f>w :RgRaw <cword> <CR>
  nnoremap <C-p> :FZF<CR>

" indentation
  set tabstop=2
  set shiftwidth=2
  set softtabstop=2
  set expandtab " use spaces instead of tabs.
  set smarttab " let's tab key insert 'tab stops', and bksp deletes tabs.
  set shiftround " tab / shifting moves to closest tabstop.
  set autoindent " Match indents on new lines.
  set smartindent " Intellegently dedent / indent new lines based on rules.

" line numbers
  " turn relative line numbers on
  :set relativenumber

" NERDTree
  nnoremap <C-t> :NERDTreeToggle<CR>
  nnoremap <Leader>f :NERDTreeFind<CR>

" prettier
  let g:prettier#config#bracket_spacing = 'true'
  let g:prettier#config#single_quote = 'true'

  " disable fix on type
  let g:prettier#quickfix_enabled=0
  let g:tsuquyomi_disable_quickfix = 1

" swapfiles
  set nobackup
  set nowb
  set noswapfile

" search
  set ignorecase " case insensitive search
  set smartcase " If there are uppercase letters, become case-sensitive.
  set incsearch " live incremental searching
  set showmatch " live match highlighting
  set hlsearch " highlight matches
  set gdefault " use the `g` flag by default.

  " Clear match highlighting
  noremap <leader><space> :noh<cr>:call clearmatches()<cr>
 
" syntax highlighting
  filetype plugin indent on " Filetype auto-detection
  syntax on " Syntax highlighting

" text
  set encoding=utf8
  set ffs=unix,dos,mac

" theme
  colorscheme github_*
  colorscheme github_dark

" timeout
  set timeoutlen=300

" tsx
  let g:yats_host_keyword = 1
