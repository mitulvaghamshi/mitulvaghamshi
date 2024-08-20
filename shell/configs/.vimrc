@REM Setting some decent VIM settings for programming
@REM This source file comes from git-for-windows build-extra repository (git-extra/vimrc)

@REM Turn on systex highlight
syntax on

@REM Highlight based on file-type
filetype on

@REM Indent based on file-type
filetype indent on

@REM Show line numbers
set number

@REM Show current command
set showcmd

@REM Use spaces for Tab character
set expandtab

@REM Tab size: 4 spaces
set tabstop=4

@REM Level of indentation, columns of whitespace
set shiftwidth=4

@REM Use Enhanced Vim defaults
ru! defaults.vim

@REM Reset the mouse setting from defaults
set mouse=

@REM Revert last positioned jump, as it is defined below
aug vimStartup | au! | aug END

@REM Do not source defaults.vim again (after loading this system vimrc)
let g:skip_defaults_vim = 1

@REM Set auto-indenting on for programming
set ai

@REM Automatically show matching brackets. works like it does in bbedit
set showmatch

@REM Turn on the 'visual bell' - which is much quieter than the 'audio blink'
@REM set vb

@REM Make the last line where the status is two lines deep so you can see status always
set laststatus=2

@REM Show the current mode
set showmode

@REM Set clipboard to unnamed to access the system clipboard under windows
set clipboard=unnamed

@REM Better command line completion
@REM set wildmode=list:longest,longest:full

@REM Show EOL type and last modified timestamp, right after the filename, filename relative to current $PWD

@REM Set the statusline
set statusline=%f

@REM Help file flag
set statusline+=%h

@REM Modified flag
set statusline+=%m

@REM Readonly flag
set statusline+=%r

@REM Fileformat [unix]/[dos] etc.
set statusline+=\ [%{&ff}]

@REM Last modified timestamp
set statusline+=\ (%{strftime(\"%H:%M\ %d/%m/%Y\",getftime(expand(\"%:p\")))})

@REM Rest: right align
set statusline+=%=

@REM Position in buffer: linenumber, column, virtual column
set statusline+=%l,%c%V

@REM Position in buffer: Percentage
set statusline+=\ %P

@REM Mintty identifies itself as xterm-compatible
if &term =~ 'xterm-256color'
  if &t_Co == 8
    @REM Use at least 256 colors
    set t_Co = 256
  endif

  @REM Allow truecolors on mintty
  @REM set termguicolors
endif
