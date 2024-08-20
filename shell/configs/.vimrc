" Setting some decent VIM settings for programming
" This file comes from git-for-windows build-extra repo (git-extra/vimrc)

" Turn on systex highlight
syntax on

" Highlight based on file-type
filetype on

" Indent based on file-type
filetype indent on

" Show line numbers
set number

" Show current command
set showcmd

" Use spaces for Tab character
set expandtab

" Tab size: 4 spaces
set tabstop=4

" Level of indentation, columns of whitespace
set shiftwidth=4

" Use Enhanced Vim defaults
ru! defaults.vim

" Reset the mouse setting from defaults
set mouse=

" Revert last positioned jump, as it is defined below
aug vimStartup | au! | aug END

" Do not source defaults.vim again (after loading this system vimrc)
let g:skip_defaults_vim = 1

" Set auto-indenting on for programming
set ai

" Automatically show matching brackets. works like it does in bbedit
set showmatch

" Turn on the 'visual blink' which is much quieter than the 'audio bell'
" set vb

" Make the last line where the status is two lines deep so you can see status always
set laststatus=2

" Show the current mode
set showmode

" Set clipboard to unnamed to access the system clipboard under windows
set clipboard=unnamed

" Better command line completion
" set wildmode=list:longest,longest:full

" Show EOL type and last modified after the filename, filename relative to $PWD

" Set the statusline
set statusline=%f

" Help file flag
set statusline+=%h

" Modified flag
set statusline+=%m

" Readonly flag
set statusline+=%r

" Fileformat [unix]/[dos] etc.
set statusline+=\ [%{&ff}]

" Last modified timestamp
set statusline+=\ (%{strftime(\"%H:%M:%S\ %m/%d/%Y\",getftime(expand(\"%:p\")))})

" Rest: right align
set statusline+=%=

" Position in buffer: linenumber, column, virtual column
set statusline+=%l,%c%V

" Position in buffer: Percentage
set statusline+=\ %P

" Mintty identifies itself as xterm-compatible
if &term =~ 'xterm-256color'
  if &t_Co == 8
    " Use at least 256 colors
    set t_Co = 256
  endif

  " Allow truecolors on mintty
  set termguicolors
endif

" StatusLine Color Based on Mode or Buffer State.
function! Status_Line_Color()
  if mode() == 'n'
    hi statusline ctermbg=white ctermfg=033
  elseif mode() == 'i'
    hi statusline ctermbg=white ctermfg=red
  elseif mode() == 'v'
    hi statusline ctermbg=white ctermfg=green
  else
    hi statusline ctermbg=white ctermfg=blue
  endif
endfunction

augroup StatuslineModeColors
  autocmd!
  autocmd modechanged * call Status_Line_Color()
  autocmd vimenter * call Status_Line_Color()
augroup END

