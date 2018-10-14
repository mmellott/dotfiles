set nocompatible " auf wiedersehen, vi

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" pathogen
"
" see vim-plugins.sh
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
try
  execute pathogen#infect()
catch
  " pathogen probably not installed
endtry
filetype plugin indent on

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" indentation
"
" if using vim-sleuth, these will serve as defaults
" if not, these are your tab settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set autoindent
set smarttab

set sw=4 expandtab
autocmd Filetype ruby setlocal sw=2 expandtab
autocmd Filetype vim  setlocal sw=2 expandtab
autocmd Filetype make setlocal ts=4

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" gui dependent options
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('gui_running')
  " font
  set guifont=Monospace\ 9

  " display menu, toolbar, etc.
  set guioptions=emgtLr

  " most appropriate color scheme for phx
  color desert

  " reward being lazy
  nnoremap <C-o> :browse tabnew<CR>
  nnoremap <C-s> :w<CR>

  " lazy tab navigation
  nnoremap <C-Tab> :cn<CR>
  nnoremap <C-S-Tab> :cp<CR>
else
  color evening
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" tabs and trailing whitespace pet peeve indulgence
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
hi ColorColumn ctermbg=lightgrey guibg=lightgrey
set listchars=tab:\|_,trail:?

function! ShowPeeve()
  set list
  set colorcolumn=+1
endfunction

function! HidePeeve()
  set nolist
  set colorcolumn=
endfunction

nnoremap <Leader>dd :call ShowPeeve()<CR>
nnoremap <Leader>df :call HidePeeve()<CR>

"set list
"autocmd Filetype c call ShowPeeve()
"autocmd Filetype sh call ShowPeeve()

" next line is to test visibility settings, leave it be
		"	test  

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" semi-generic settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" auto-reload vimrc on save
augroup reload_vimrc
  autocmd!
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

" set dir for storing swap files
set noswapfile

" automatically reload file
set autoread

" global copy paste mappings
nnoremap <Leader>y "+y
nnoremap <Leader>p "+p

" open grep results in hotlinked buffer
command! -nargs=+ MyGrep execute 'silent grep! <args>' | copen 33

" remove trailing whitespace
nnoremap <Leader>r :%s/\s\+$//e<CR>

nnoremap <Leader>s :set spell!<CR>

" i am a fan of the colors
syntax on " syntax (lexical?) highlighting

" ascending search for tag file starting in current directory
set tags=./tags;

" hg commit settings
au BufNewFile,BufRead hg-editor-*.txt setf hgcommit
au Filetype hgcommit setlocal spell textwidth=72 " not in windoze?

set nowrap " don't wrap lines
set hlsearch " highlight search matches
set incsearch " show match as search proceeds
set nu " show line numbers
set textwidth=80 " 80 chars per line, affects various options
set formatoptions=c " auto-wrap comments and insert current comment leader!
set fo+=q " use gq* commands to format paragraphs
"set autochdir " working dir same as file being edited
set ruler " always show which line we are on, etc.

" bash like tab completion
set wildmode=longest,list,full
set wildmenu

" ctrl+hjkl split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" open new splits below and right
set splitbelow
set splitright

" tab page settings
set tabpagemax=100 " maximum number of tabs to open when using -p option
set guitablabel=%t\ %r%m " show filename, if readonly , and if modified

" auto save/load views
" views save lots of cool information about file like cursor pos and folds
" if having issues only with a specific file but not other files of the same
" type, try deleting the corresponding view file in view folder
" auto save/load folds
"autocmd BufWinLeave *.* mkview
"autocmd BufWinEnter *.* silent loadview
" views are a pain sometimes...

" highlight all instances of word under cursor, when idle
" useful when studying strange source code
" type z/ to toggle highlighting on/off
" http://vim.wikia.com/wiki/Auto_highlight_current_word_when_idle
nnoremap z/ :if AutoHighlightToggle()<Bar>set hls<Bar>endif<CR>
function! AutoHighlightToggle()
  let @/ = ''
  if exists('#auto_highlight')
    au! auto_highlight
    augroup! auto_highlight
    setl updatetime=4000
    echo 'Highlight current word: off'
    return 0
  else
    augroup auto_highlight
      au!
      au CursorHold * let @/ = '\V\<'.escape(expand('<cword>'), '\').'\>'
    augroup end
    setl updatetime=500
    echo 'Highlight current word: ON'
    return 1
  endif
endfunction

" split automatically when opening tag
" http://goo.gl/V8r9iM
"fun! SPLITAG() range
"  let oldfile=expand("%:p")
"  if &modified
"    split
"  endif
"  exe "tag ". expand("<cword>")
"  let curfile=expand("%:p")
"  if curfile == oldfile
"    let pos=getpos(".")
"    if &modified
"      " if we have split before:
"      quit
"    endif
"    call setpos('.', pos)
"  endif
"endfun
"nmap <C-]> :call SPLITAG()<CR>z.

" delete buffers not shown in any window (including tabs)
" http://stackoverflow.com/a/7321131
function! DeleteInactiveBufs()
    "From tabpagebuflist() help, get a list of all buffers in all tabs
    let tablist = []
    for i in range(tabpagenr('$'))
        call extend(tablist, tabpagebuflist(i + 1))
    endfor

    "Below originally inspired by Hara Krishna Dara and Keith Roberts
    "http://tech.groups.yahoo.com/group/vim/message/56425
    let nWipeouts = 0
    for i in range(1, bufnr('$'))
        if bufexists(i) && !getbufvar(i,"&mod") && index(tablist, i) == -1
        "bufno exists AND isn't modified AND isn't in the list of buffers open in windows and tabs
            silent exec 'bwipeout' i
            let nWipeouts = nWipeouts + 1
        endif
    endfor
    echomsg nWipeouts . ' buffer(s) wiped out'
endfunction
command! Wipeout :call DeleteInactiveBufs()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" netrw settings
"
" combination of code from these two sources:
"   1. http://ivanbrennan.nyc/blog/2014/01/16/rigging-vims-netrw/
"   2. http://modal.us/blog/2013/07/27/back-to-vim-with-nerdtree-nope-netrw/
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:netrw_liststyle=3 " tree style
let g:netrw_banner=0 " no banner
let g:netrw_altv=1 " open files on right
let g:netrw_preview=1 " open previews vertically

function! ToggleVExplorer()
  if exists("t:expl_buf_num")
      let expl_win_num = bufwinnr(t:expl_buf_num)
      if expl_win_num != -1
          let cur_win_nr = winnr()
          exec expl_win_num . 'wincmd w'
          close
          exec cur_win_nr . 'wincmd w'
          unlet t:expl_buf_num
      else
          unlet t:expl_buf_num
      endif
  else
      exec '1wincmd w'
      Vexplore
      let t:expl_buf_num = bufnr("%")
      call VexSize(25)
  endif
endfunction
map <silent> <Leader>~ :call ToggleVExplorer()<CR>

fun! VexSize(vex_width)
  execute "vertical resize" . a:vex_width
  set winfixwidth
  call NormalizeWidths()
endf

fun! NormalizeWidths()
  let eadir_pref = &eadirection
  set eadirection=hor
  set equalalways! equalalways!
  let &eadirection = eadir_pref
endf

" make tabs and trailing whitespace visible
" use autocmd because match only applies to current buffer
"au BufNewFile,BufRead * match Underlined '\t'
"au BufNewFile,BufRead * 2match ErrorMsg '\s\+$'
"au Filetype * match Underlined '\t'
"au Filetype * 2match ErrorMsg '\s\+$'
"set list!


" visually indicate which lines are too long
" http://stackoverflow.com/a/3765575/1842880
"if exists('+colorcolumn')
"  set colorcolumn=+1
"else
"  au BufWinEnter * let w:m2=matchadd('ColorColumn', '\%>80v.\+', -1)
"endif
