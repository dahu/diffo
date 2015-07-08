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
  return info
endfunction

function! diffo#open()
  let filetype = &filetype
  let t:diffline = line('.')
  diffthis
  augroup diffo
    au!
    au InsertLeave <buffer> diffupdate
  augroup END
  vertical new
  augroup diffo
    au InsertLeave <buffer> diffupdate
  augroup END
  command -buffer -nargs=0 DiffOrig call diffo#close()
  let w:difforig = bufnr('%')
  let t:difforig = winnr()
  read ++edit #
  0 delete _
  diffthis
  setlocal buftype=nofile
  setlocal bufhidden=wipe
  setlocal noswapfile
  setlocal nobuflisted
  setlocal readonly
  exe 'setlocal filetype=' . filetype
  exe 'normal! ' . t:diffline . 'G'
  wincmd p
endfunction

function! diffo#close()
  augroup diffo
    au!
  augroup END
  if exists('t:difforig')
    exe t:difforig . ' wincmd w'
    if exists('w:difforig')
      exe 'buffer ' . w:difforig
      unlet w:difforig
      bwipe
    endif
    diffoff!
    exe 'normal! ' . t:diffline . 'G'
    unlet t:diffline
    unlet t:difforig
  endif
endfunction

" Teardown:{{{1
"reset &cpo back to users setting
let &cpo = s:save_cpo

" Template From: https://github.com/dahu/Area-41/
" vim: set sw=2 sts=2 et fdm=marker:
