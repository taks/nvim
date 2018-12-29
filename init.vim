if !&compatible
  set nocompatible
endif

" reset augroup
augroup MyAutoCmd
  autocmd!
augroup END

" dein settings {{{
" dein自体の自動インストール
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif
let &runtimepath = s:dein_repo_dir .",". &runtimepath
" プラグイン読み込み＆キャッシュ作成
let s:toml_file = fnamemodify(expand('<sfile>'), ':h').'/dein.toml'
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir, [$MYVIMRC, s:toml_file])
  call dein#load_toml(s:toml_file)
  call dein#end()
  call dein#save_state()
endif
" 不足プラグインの自動インストール
if has('vim_starting') && dein#check_install()
  call dein#install()
endif
" }}}

"""

syntax on

autocmd ColorScheme * highlight Normal ctermbg=none
autocmd ColorScheme * highlight LineNr ctermbg=none
set background=dark
colorscheme hybrid

set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,iso-2022-jp,sjis,euc-jp

" BASE {{{
set visualbell

set expandtab
set shiftwidth=2

set conceallevel=0
let g:vim_json_syntax_conceal = 0

set virtualedit+=all
" }}}

" keybind {{{
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

nnoremap ws :<C-u>sp<CR>
nnoremap wv :<C-u>vs<CR>
nnoremap ww <C-w>w

set whichwrap=b,s,h,l,<,>,[,]       " カーソルを行頭、行末で止まらないようにする

" 閉じる無効化
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>

function! s:toggle_visual()
  if mode() ==# 'v'
    return "\<C-v>" 
  elseif mode() ==# 'V'
    return "v"
  else  " mode() ==# "\<C-v>"
    return "V"
  endif
endfunction

vnoremap <expr> t <SID>toggle_visual()
" }}}
