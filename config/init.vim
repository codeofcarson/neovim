call pathogen#infect()

" Correct color mode
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" Change cursor shape
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

" Dark background by default
set background=dark

" Set the colorscheme
colorscheme kalisi

" Backspace
set backspace=indent,eol,start

" Enable syntax
syntax on

" Show line numbers
set number

" Allow switching buffers without saving
set hidden

" Indentation detection
set expandtab
let g:detectindent_preferred_indent = 4
autocmd BufReadPost * :DetectIndent

" Bash-ish command completion
set wildchar=<Tab> wildmenu wildmode=longest,list

" Enable filetype detection and plugins
filetype on
filetype plugin on

" Track window creation
autocmd VimEnter * autocmd WinEnter * let w:created=1
autocmd VimEnter * let w:created=1

" Highlight end of line whitespace
highlight WhitespaceEOL ctermbg=red ctermfg=white guibg=#592929
autocmd WinEnter *
	\ if !exists('w:created') | call matchadd('WhitespaceEOL', '\s\+$') | endif
call matchadd('WhitespaceEOL', '\s\+$')

" Highlight the background of long lines
highlight ColorColumn ctermbg=239 guibg=#39393b
execute "set colorcolumn=" . join(range(81,335), ',')

" Completion options
set completeopt-=preview

" Open new splits to the right
set splitright

" Disable highlighting in search
set nohlsearch

" Use relative line numbers
set relativenumber
set number

" Exit terminal with <Esc>
tnoremap <Esc> <C-\><C-n>

" Add tsplit command to open a new terminal in a split
if !exists(":tsplit")
	command -nargs=? Tsplit vsplit | terminal <args>
	ca tsplit Tsplit
endif

" Relative line numbers in terminal (set nonumber to keep margin fixed size)
autocmd TermOpen * set nonumber relativenumber

" Hardtime Configuration
autocmd VimEnter,BufNewFile,BufReadPost * silent! HardTimeOn
nnoremap <leader>h <Esc>:HardTimeToggle<CR>

let g:hardtime_ignore_quickfix = 1
let g:hardtime_allow_different_key = 1

let g:list_of_normal_keys = ["h", "j", "k", "l", "-", "+", "<UP>",
  \                          "<DOWN>", "<LEFT>", "<RIGHT>", "<CR>"]

" Better Code Folding
set foldlevelstart=99 foldtext=CustomFoldText() foldmethod=syntax
function! CustomFoldText()
  " Get the first non-blank line
  let fs = v:foldstart
  while getline(fs) =~ '^\s*$' | let fs = nextnonblank(fs + 1)
  endwhile

  if fs > v:foldend
    let line = getline(v:foldstart)
  else
    let line = substitute(getline(fs), '\t', repeat(' ', &tabstop), 'g')
  endif

  " Get the last non-blank line
  let fe = v:foldend
  while getline(fe) =~ '^\s*$' | let fe = prevnonblank(fe - 1)
  endwhile

  if fe < v:foldstart
    let eline = getline(v:foldend)
  else
    let eline = substitute(getline(fe), '\t', repeat(' ', &tabstop), 'g')
  endif

  if fs != fe
    let line = line . " ... " . substitute(eline, '^\s*', '', '')
  endif

  let w = winwidth(0) - &foldcolumn - (&number ? 4 : 0)
  let foldSize = 1 + v:foldend - v:foldstart
  let foldSizeStr = " " . foldSize . " lines "
  let lineCount = line("$")
  let expansionString = repeat(" ", w - strwidth(foldSizeStr.line))
  return line . expansionString . foldSizeStr
endfunction
