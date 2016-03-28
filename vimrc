set nocompatible " auf wiedersehen, vi

"execute pathogen#infect()
"syntax on
"filetype plugin indent on

" auto-reload vimrc on save
augroup reload_vimrc
  autocmd!
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

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
  nnoremap <C-Tab> :tabn<CR>
  nnoremap <C-S-Tab> :tabp<CR>
  nnoremap <C-PageDown> :bn<CR>
  nnoremap <C-PageUp> :bp<CR>
else
  color evening
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" semi-generic settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" set dir for storing swap files
"set directory=$HOME/.vim//
set noswapfile

" automatically reload file
set autoread

" global copy paste mappings
nnoremap <Leader>y "+y
nnoremap <Leader>p "+p

" open grep results in hotlinked buffer
command! -nargs=+ MyGrep execute 'silent grep! <args>' | copen 33

" tab stuff
set autoindent
set expandtab " replace tabs with spaces
set shiftwidth=4 " number of spaces to use for each indent
set softtabstop=4 " number of spaces tabs count for during editing operations
set tabstop=4 " size of a hard tabstop

" make tabs and trailing whitespace visible
hi ColorColumn ctermbg=lightgrey guibg=lightgrey
set listchars=tab:\|_,trail:?
function! ShowIndicators()
  set list!

  if &list
    set colorcolumn=+1
  else
    set colorcolumn=
  endif

" make tabs and trailing whitespace visible
" use autocmd because match only applies to current buffer
"au BufNewFile,BufRead * match Underlined '\t'
"au BufNewFile,BufRead * 2match ErrorMsg '\s\+$'
"au Filetype * match Underlined '\t'
"au Filetype * 2match ErrorMsg '\s\+$'
"set list!

" next line is to test visibility settings, leave it be
		"	test  

" visually indicate which lines are too long
" http://stackoverflow.com/a/3765575/1842880
"if exists('+colorcolumn')
"  set colorcolumn=+1
"else
"  au BufWinEnter * let w:m2=matchadd('ColorColumn', '\%>80v.\+', -1)
"endif
endfunction
nnoremap <Leader>d :call ShowIndicators()<CR>
autocmd Filetype c call ShowIndicators()
autocmd Filetype sh call ShowIndicators()

" remove trailing whitespace
nnoremap <Leader>r :%s/\s\+$//e<CR>

" remove trailing whitespace
nnoremap <Leader>s :set spell!<CR>

" tab settings for specific file types
autocmd Filetype ruby setlocal ts=2 sts=2 sw=2
autocmd Filetype sh setlocal ts=2 sts=2 sw=2

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

