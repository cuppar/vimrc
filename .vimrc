" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2019 Dec 17
"
" To use it, copy it to
"	       for Unix:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"	 for MS-Windows:  $VIM\_vimrc
"	      for Haiku:  ~/config/settings/vim/vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings, bail
" out.
if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
augroup END

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif

" ### settings
set laststatus=2
set textwidth=78

set splitbelow
set splitright

set wildignorecase

" line number
set rnu

set list
set listchars=tab:>-,trail:-

" ### format
" cpp format
autocmd BufNewFile,BufRead *.c,*.cpp,*.h,*.hpp set formatprg=astyle\ -A1pFH\ --unpad-brackets\ -xe\ --squeeze-ws\ -k1\ -W1\ -xb\ --squeeze-lines=1\ -xC70\ -xV\ -Y\ -U\ -xj\ -xfxh

" cmake format
autocmd BufNewFile,BufRead CMakeLists.txt set formatprg=cat\ >.tempFile\ &&\ cmake-format\ .tempFile\ &&\ rm\ .tempFile

" ### maps
" build cmake project
map ,x :!$VIMRUNTIME/bashscripts/buildcmake.sh .<Enter>

map <Tab> :nohl<Enter>

" format shortcut
map ,f magggqG`a

" push updated .vimrc file to github
map ,u :!$VIMRUNTIME/bashscripts/pushvimrc2hub.sh<Enter>

" edit .vimrc
map ,v :sp $MYVIMRC<Enter>

" comment and uncomment
map ,cc ma0i//<Space><Esc>`alll
map ,cd ma0:s+// ++<Enter>`ahhh<Tab>

" ycm maps
map ,d :YcmCompleter GoToDefinition<Enter>
map ,r :YcmCompleter RefactorRename 
map ,i :YcmCompleter FixIt<Enter>

" ### vim-plug plugins
" auto install vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" vim-plug plug list
call plug#begin()
Plug 'jiangmiao/auto-pairs'
Plug 'ycm-core/YouCompleteMe'
call plug#end()

" ### plugin configs
" ycm config
let g:ycm_global_ycm_extra_conf='~/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0

" ########### temp config ###########
" auto push code to github
map ,p :!~/project/dsa_in_cpp/scripts/autopush.sh<Enter>
