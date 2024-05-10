let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
let BufferlinePositions = "[\"\\/home\\/cizekm\\/.config\\/nvim\\/lua\\/keymaps.lua\",\"\\/home\\/cizekm\\/.config\\/nvim\\/lua\\/options.lua\",\"\\/home\\/cizekm\\/.config\\/nvim\\/init.lua\",\"\\/home\\/cizekm\\/.config\\/nvim\\/lua\\/plugins\\/colorscheme.lua\",\"\\/home\\/cizekm\\/.config\\/nvim\\/lua\\/plugins\\/editor.lua\",\"\\/home\\/cizekm\\/.config\\/nvim\\/lua\\/plugins\\/coding.lua\",\"\\/home\\/cizekm\\/.config\\/nvim\\/lua\\/plugins\\/completions.lua\",\"\\/home\\/cizekm\\/.config\\/nvim\\/lua\\/plugins\\/lsp.lua\",\"\\/home\\/cizekm\\/.config\\/nvim\\/lua\\/plugins\\/ui.lua\",\"\\/home\\/cizekm\\/.config\\/nvim\\/lua\\/telescope-config.lua\"]"
silent only
silent tabonly
cd ~/.config/nvim
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
if &shortmess =~ 'A'
  set shortmess=aoOA
else
  set shortmess=aoO
endif
badd +1 ~/.config/nvim/init.lua
badd +42 lua/keymaps.lua
badd +41 lua/plugins/editor.lua
badd +1 lua/options.lua
badd +1 lua/plugins/coding.lua
badd +1 lua/plugins/colorscheme.lua
badd +1 lua/plugins/completions.lua
badd +1 lua/plugins/lsp.lua
badd +1 lua/plugins/ui.lua
badd +1 lua/telescope-config.lua
argglobal
%argdel
edit lua/plugins/editor.lua
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
argglobal
balt lua/plugins/coding.lua
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 41 - ((39 * winheight(0) + 40) / 80)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 41
normal! 0
tabnext 1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20
let &shortmess = s:shortmess_save
let &winminheight = s:save_winminheight
let &winminwidth = s:save_winminwidth
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
set hlsearch
nohlsearch
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
