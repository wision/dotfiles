" AUTOINSTALL VUNDLE
" Setting up Vundle - the vim plugin bundler
	let iCanHazVundle=1
	let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
	if !filereadable(vundle_readme)
		echo "Installing Vundle.."
		echo ""
		silent !mkdir -p ~/.vim/bundle
		silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
		let iCanHazVundle=0
	endif
	set rtp+=~/.vim/bundle/vundle/
	call vundle#rc()
	Bundle 'gmarik/vundle'
	"Add your bundles here
	"Plugin 'Lokaltog/powerline'
	Plugin 'editorconfig/editorconfig-vim'
	Plugin 'bling/vim-airline'
	Plugin 'airblade/vim-gitgutter'
	Plugin 'tpope/vim-fugitive'
	Plugin 'scrooloose/nerdtree'
	Plugin 'wincent/Command-T'
	Plugin 'terryma/vim-multiple-cursors'
	Plugin 'vim-scripts/AnsiEsc.vim'
	Plugin 'isRuslan/vim-es6'
	Plugin 'henrik/vim-indexed-search'
	Plugin 'ap/vim-css-color'
	Plugin 'prettier/vim-prettier'
	Bundle 'vim-scripts/twilight'
	"Bundle 'tpope/vim-sleuth' opening some files took 30s
	Bundle 'mattn/webapi-vim'
	Bundle 'mattn/gist-vim'
	Bundle 'derekwyatt/vim-scala'
	Bundle 'kchmck/vim-coffee-script'
	Bundle 'leafgarland/typescript-vim'

	"...All your other bundles...
	if iCanHazVundle == 0
		echo "Installing Bundles, please ignore key map error messages"
		echo ""
		:BundleInstall
	endif
" Setting up Vundle - the vim plugin bundler end
""""""""""""

""" to finish install of command-t
"cd ~/.vim/bundle/Command-T
"make
"vim
":e command-t.vba
":so %
":q
"cd ruby/command-t
"ruby extconf.rb
"make



set t_Co=256
set ignorecase
set smartcase
"set nowrapscan
set list
set nocompatible
set exrc
set number
set numberwidth=5
set history=1000
set backspace=indent,start,eol
set nojoinspaces
set ruler
set showcmd
set showmatch
set hlsearch
set smartindent
set shiftwidth=4
"set smarttab
set noexpandtab
set tabstop=4
set mouse=a
set wildmenu
set hls
set nowritebackup
set termencoding=utf-8
set laststatus=2
"set termencoding=latin2
"set background=light
set background=dark
set listchars=tab:▸—,eol:.,nbsp:_
set incsearch
set scrolloff=1000              " center cursor vertically
set tabpagemax=30
"set backup
"set backupdir=~/.vimbackups/
"set wildignore+=**/node_modules/*
"let g:ctrlp_custom_ignore = 'node_modules'
let g:CommandTMaxHeight=20
let g:gist_post_private = 1

"set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim
"let g:Powerline_symbols = 'fancy'


set showbreak=~~

set statusline=[%n]\ %<%F\ \ \ \ \ \ \ \ \ \ \ [%M%R%H%W%Y]\ [%{&ff}]\ \ %=\ line:%l/%L\ col:%c\ \ \ %p%%\ \ \ @%{strftime(\"%H:%M:%S\")}

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_powerline_fonts = 1


set runtimepath^=~/.vim/bundle/ctrlp.vim


" pathogen bundles
filetype off
"call pathogen#helptags()
"call pathogen#runtime_append_all_bundles()


" minibuffer Explorer settings:new
let g:miniBufExplMapCTabSwitchBufs = 1
"let g:miniBufExplVSplit = 20   " column width in chars
let g:miniBufExplMapWindowNavVim = 1
syntax on

" Tabs
"map <S-j> :tabprev<CR>
"map <S-K> :tabnext<CR>
"map <S-T> :tabnew<CR>

" kopirovani a ukladani do glob bufferu
vmap <C-y> "*y
" vlozeni z globalni schranky
"map <C-v> "+gP
" ukladani souboru na bezne <Ctrl>-<s>
"map <C-s> :w<CR>
"imap <C-s> <Esc>:w<CR>i



map <tab> :tabnext<cr>
"nmap <tab> :tabnext<cr>
"imap <tab> <ESC>:tabnext<cr>a

map <S-tab> :tabprev<cr>
"nmap <S-tab> :tabprev<cr>
"imap <S-tab> <ESC>:tabprev<cr>a

map <C-t> :tabnew 
"nmap <C-t> :tabnew 
"imap <C-t> <ESC>:tabnew 

map <C-p> :CommandT<cr>
"nmap <C-p> :CommandT<cr>
"imap <C-p> <ESC>:CommandT<cr>a

"nnoremap <C-J> <C-W><C-J>
"nnoremap <C-K> <C-W><C-K>
"nnoremap <C-L> <C-W><C-L>
"nnoremap <C-H> <C-W><C-H>
map <C-J> :bp<cr>
map <C-K> :bn<cr>
map <C-L> :bn<cr>
map <C-H> :bp<cr>


inoremap <expr> <C-Space> pumvisible() \|\| &omnifunc == '' ?
			\ "\<lt>C-n>" :
			\ "\<lt>C-x>\<lt>C-o><c-r>=pumvisible() ?" .
			\ "\"\\<lt>c-n>\\<lt>c-p>\\<lt>c-n>\" :" .
			\ "\" \\<lt>bs>\\<lt>C-n>\"\<CR>"
imap <C-@> <C-Space>


fun! <SID>StripTrailingWhitespaces()
	let l = line(".")
	let c = col(".")
	%s/\s\+$//e
	call cursor(l, c)
endfun


"function! EnhanceCppSyntax()
"  syn match cppFuncDef "::\~\?\zs\h\w*\ze([^)]*\()\s*\(const\)\?\)\?$"
"  hi def link cppFuncDef Special
"endfunction

"autocmd Syntax cpp call EnhanceCppSyntax()

" Only do this part when compiled with support for autocommands.
if has("autocmd")
  autocmd FileType c,cpp,java,php,ruby,python,js,cjsx,jsx,coffee,scala autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
  autocmd BufEnter * :syntax sync fromstart
  autocmd BufRead,BufNewFile *.cjsx set filetype=coffee
  autocmd BufNewFile,BufRead *.ejs set filetype=html
  autocmd BufWritePre <buffer> Prettier

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on
endif " has("autocmd")


colors twilight

hi normal       ctermbg=black                             guibg=black
hi Pmenu        ctermbg=235            ctermfg=white
hi LineNr       ctermbg=black          ctermfg=245        guibg=black
hi Visual       ctermbg=235            ctermfg=246
hi Search       ctermbg=darkgray       ctermfg=black      guibg=#bbbbbb       guifg=#000000
hi StatusLine   ctermbg=white          ctermfg=black
hi SignColumn   ctermbg=black
hi ColorColumn  ctermbg=234                               guibg=#333333

hi Comment        guibg=#000000
hi TODO           guibg=#000000
hi Title          guibg=#000000
hi Constant       guibg=#000000
hi String         guibg=#000000
hi Special        guibg=#000000
hi SpecialKey     guibg=#000000
hi Identifier     guibg=#000000
hi Statement      guibg=#000000
hi Conditional    guibg=#000000
hi Repeat         guibg=#000000
hi Structure      guibg=#000000
hi Function       guibg=#000000
hi PreProc        guibg=#000000
hi Operator       guibg=#000000
hi Type           guibg=#000000
hi NonText        guibg=#000000


set colorcolumn=81
"let &colorcolumn=join(range(81,999),",")
set termguicolors
