" Load settings that are shared with other Vim-Like instances, e.g. Ideavim
source $HOME/.vim/shared.vim

" Options
"
" See ':help options' for more information.
" Also note that a number of options might be set by plugins (e.g.
" vim-sensible). 
set cmdheight=1
set completeopt+=longest
set completeopt=menuone,menu,longest
set expandtab
set mouse=a
set shiftwidth=2
set smartindent
set softtabstop=2
set termguicolors
set textwidth=0 
set wildignore+=*\\tmp\\*,*.swp,*.swo,*.zip,.git,.cabal-sandbox
set wildmode=longest,list,full
set wrapmargin=0
set updatetime=100
set enc=utf-8

" Tweak command line 
set noshowmode  
set noshowcmd  
set shortmess+=F 

" Set column ruler
set colorcolumn=120

" Fix mouse not working beyond column 220
" See https://stackoverflow.com/a/19253251
set ttymouse=sgr

" Enable smartcase for searches.
set smartcase
set ignorecase
set hlsearch

" Set system clipboard
set clipboard=unnamedplus

" Allow hiding of buffers
set hidden

filetype indent on

" Create some directories if it does not exist. This is necessary in order to
" simplify automatic installation
"
" See https://stackoverflow.com/a/12488082/2553104
if !isdirectory($HOME/".vim/swp")
    silent call mkdir($HOME."/.vim/swp", "p")
endif

if !isdirectory($HOME/".vim/undo")
    silent call mkdir($HOME."/.vim/undo", "p")
endif

" Automatically source vimrc when saving it
autocmd BufWritePost ~/.vimrc so ~/.vimrc

" Save swapfiles/undofiles a specific directory
"
" See here: https://medium.com/@Aenon/vim-swap-backup-undo-git-2bf353caa02f
set noswapfile
set directory=$HOME/.vim/swp//
set undofile
set undodir=$HOME/.vim/undo//

" Line wrapping options
"
" All tips inspired by
" https://agilesysadmin.net/how-to-manage-long-lines-in-vim/
set showbreak=…
set linebreak

" Nifty trick to write to write protected files
"
" See https://dev.to/jovica/the-vim-trick-which-will-save-your-time-and-nerves-45pg
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Autosave on focus lost
:au FocusLost * silent! wa

" Deactivate Arrow Keys
"
" Disable arrow keys. Helps getting gud in vim. 
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" Simpler multi line navigation
nnoremap k gk
nnoremap j gj

" Line wrapping options
"
" All tips inspired by
" https://agilesysadmin.net/how-to-manage-long-lines-in-vim/
set showbreak=…
set linebreak

" Show syntax group with F10
"
" See https://vim.fandom.com/wiki/Identify_the_syntax_highlighting_group_used_at_the_cursor
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Close all buffers except current
"
" See https://stackoverflow.com/a/57712826/2553104
nnoremap <leader>bd :BD <CR>
nnoremap <leader>ba :w <bar> %bd <bar> e# <bar> bd# <CR>

" Formatting Commands
autocmd FileType json nnoremap <buffer><silent><localleader>f :%!jq .<cr>

" ##############################################################################
"
" Nord Colorscheme
"
" ##############################################################################
"
" silent! is required in order to allow an automated installation.
silent! colorscheme nord

" ##############################################################################
" 
" vim-airline
"
" ##############################################################################
let g:airline_theme='minimalist'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" ##############################################################################
"
" EasyMotion 
"
" ##############################################################################

let g:EasyMotion_startofline = 0
let g:EasyMotion_smartcase = 1
" Use most default mappings
map <Leader>e <Plug>(easymotion-prefix)

" Custom mappings
nmap s <Plug>(easymotion-overwin-f)
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)
map  <Leader>f <Plug>(easymotion-bd-fl)
map  <Leader>t <Plug>(easymotion-bd-tl)

" Set colors and use color scheme colors
hi link EasyMotionTarget WarningMsg
hi link EasyMotionShade  Comment
hi link EasyMotionTarget2First MatchParen
hi link EasyMotionTarget2Second MatchParen
hi link EasyMotionMoveHL Search
hi link EasyMotionIncSearch Search

" ##############################################################################
" 
" vim-gitgutter
" 
" ##############################################################################

" Change the signs of the indicators
let g:gitgutter_sign_added = '·'
let g:gitgutter_sign_modified = '·'
let g:gitgutter_sign_removed = '·'
let g:gitgutter_sign_removed_first_line = '·'
let g:gitgutter_sign_modified_removed = '·'

" ##############################################################################
"
" fzf-vim
"
" ##############################################################################
 
" Various custom keybindings. 
" For more information see https://github.com/junegunn/fzf.vim#customization
nmap <Leader><Leader>b :Buffers<CR>
nmap <Leader><Leader>: :History:<CR>
nmap <Leader><Leader>/ :History/<CR>
nmap <Leader><Leader>? :History/<CR>
nmap <Leader><Leader>f :Rg<CR>
nmap <Leader><Leader>t :Files<CR>
nmap <Leader><Leader>r :Tags<CR>

" ##############################################################################
"
" vim-markdown
"
" ##############################################################################
"
" Disable folding and fix list item behaviour. 
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_new_list_item_indent = 0

" ##############################################################################
"
" coc-vim
"
" ##############################################################################
"
" Custom tab completion, compatible with snippets
" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

let g:coc_node_path = trim(system('which node'))

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
let g:coc_snippet_next = '<Tab>'
let g:coc_snippet_prev = '<S-Tab>'

let g:coc_global_extensions = [
            \ 'coc-snippets',
            \ 'coc-solargraph',
            \ ]

xmap <leader>x  <Plug>(coc-convert-snippet)

" ##############################################################################
"
" Ale
"
" ##############################################################################
"
" Custom fixers
let g:ale_fixers = { 'javascript': ['prettier', 'eslint'] }
" Making it pretty
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'
highlight ALEErrorSign ctermbg=NONE ctermfg=red
highlight ALEWarningSign ctermbg=NONE ctermfg=yellow

" Custom linting behaviour
let g:ale_lint_on_save = 1
let g:ale_fix_on_save = 1

" ##############################################################################
"
" Prettier
"
" ##############################################################################
let g:prettier#config#print_width = 120
let g:prettier#autoformat = 0
autocmd BufWritePre *.css,*.less,*.scss,*.json,*.graphql,*.markdown,*.vue,*.yaml,*.html PrettierAsync

" ##############################################################################
"
" emmet-vim
"
" ##############################################################################
" Custom key and jsx Settings
let g:user_emmet_leader_key = ','
let g:user_emmet_settings = {
\  'javascript' : {
\      'extends' : 'jsx',
\  },
\}

" ##############################################################################
"
" vim-asterisk
"
" ##############################################################################
map *  <Plug>(asterisk-z*)<Plug>(is-nohl-1)
map g* <Plug>(asterisk-gz*)<Plug>(is-nohl-1)
map #  <Plug>(asterisk-z#)<Plug>(is-nohl-1)
map g# <Plug>(asterisk-gz#)<Plug>(is-nohl-1)
let g:asterisk#keeppos = 1

" ##############################################################################
"
" vimwiki
"
" ##############################################################################
let g:vimwiki_list = [{'path': '~/Documents/wiki', 'syntax': 'markdown', 'index': 'home', 'ext': '.md', 'auto_diary_index': 1 }]
let g:vimwiki_global_ext = 0
" See https://github.com/vimwiki/vimwiki/issues/845#issuecomment-683423984
au filetype vimwiki silent! iunmap <buffer> <Tab>
au filetype vimwiki silent! iunmap <buffer> <CR>
au BufNewFile ~/Documents/wiki/diary/*.md :silent 0r !~/.scripts/diary.sh

" ##############################################################################
"
" startify
"
" ##############################################################################
let g:startify_session_autoload = 1
let g:startify_session_delete_buffers = 1
let g:startify_change_to_dir = 0
let g:startify_change_to_vcs_root = 1
let g:startify_session_persistence = 1
let g:startify_enable_special = 1
let g:startify_custom_header = [
            \'   __     __  ______  __       __   ',
            \'  |  \   |  \|      \|  \     /  \  ',
            \'  | $$   | $$ \$$$$$$| $$\   /  $$  ',
            \'  | $$   | $$  | $$  | $$$\ /  $$$  ',
            \'   \$$\ /  $$  | $$  | $$$$\  $$$$  ',
            \'    \$$\  $$   | $$  | $$\$$ $$ $$  ',
            \'     \$$ $$   _| $$_ | $$ \$$$| $$  ',
            \'      \$$$   |   $$ \| $$  \$ | $$  ',
            \'       \$     \$$$$$$ \$$      \$$  ',
            \]                      

" ##############################################################################
"
" DevIcons + Startify
"
" ##############################################################################
function! StartifyEntryFormat()
  return 'WebDevIconsGetFileTypeSymbol(absolute_path) ." ". entry_path'
endfunction

let g:ranger_map_keys = 0
let g:ranger_replace_netrw = 1
map <leader>ro :Ranger<CR>.

" ##############################################################################
" 
" vim-which-key
"
" ##############################################################################
set timeoutlen=200
let g:which_key_map = {}
call which_key#register('<Space>', "g:which_key_map")
let g:which_key_sep = '→'

nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey  '<Space>'<CR>
