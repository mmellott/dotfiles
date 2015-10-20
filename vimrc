set nocompatible " auf wiedersehen, vi

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
else
  color evening
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" semi-generic settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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

" underline tabs and highlight trailing white space
" use autocmd because match only applies to current buffer
"au BufNewFile,BufRead * match Underlined '\t'
"au BufNewFile,BufRead * 2match ErrorMsg '\s\+$'
au Filetype * match Underlined '\t'
au Filetype * 2match ErrorMsg '\s\+$'
" next line is to test autocmds above, leave it be
		"	test  

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

" maximum number of tabs to open when using -p option
set tabpagemax=100

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

