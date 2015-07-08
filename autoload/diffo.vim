" Vim library for showing unsaved differences (DiffOrig).
" Maintainer:	Barry Arthur <barry.arthur@gmail.com>
" Version:	0.1
" Description:	Library to support diffing the current buffer with the last saved version.
" License:	Vim License (see :help license)
" Location:	autoload/diffo.vim
" Website:	https://github.com/dahu/diffo
"
" See diffo.txt for help.  This can be accessed by doing:
"
" :helptags ~/.vim/doc
" :help diffo

" Vimscript Setup: {{{1
" Allow use of line continuation.
let s:save_cpo = &cpo
set cpo&vim

" Vim Script Information Function: {{{1
" Use this function to return information about your script.
function! diffo#info()
  let info = {}
  let info.name = 'diffo'
  let info.version = 1.0
  let info.description = 'Library to support diffing the current buffer with the last saved version.'
  let info.dependencies = []
  " let info.dependencies = [{'name': 'plugin1', 'version': 1.0}]
  return info
endfunction

" View changes made to a buffer since it was last saved
function! diffo#open()
  let t:diffline = line('.')
  vertical new
  set buftype=nofile
  let w:difforig = bufnr('%')
  let t:difforig = winnr()
  " 0read prevents a blank line at the top of the buffer
  " ++edit retains current option values for read operation
  " # is the alternate buffer (:help :_#)
  command -buffer -nargs=0 DiffOrig call diffo#close()
  0read ++edit #
  diffthis
  exe 'normal! ' . t:diffline . 'G'
  wincmd p
  diffthis
  wincmd p
endfunction

function! diffo#close()
  exe t:difforig . ' wincmd w'
  exe 'buffer ' . w:difforig
  unlet w:difforig
  bdelete
  diffoff
  exe 'normal! ' . t:diffline . 'G'
  unlet t:diffline
  unlet t:difforig
endfunction

" Teardown:{{{1
"reset &cpo back to users setting
let &cpo = s:save_cpo

" Template From: https://github.com/dahu/Area-41/
" vim: set sw=2 sts=2 et fdm=marker:
