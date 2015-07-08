" Vim global plugin to show unsaved differences (DiffOrig).
" Maintainer:	Barry Arthur <barry.arthur@gmail.com>
" Version:	0.1
" Description:	Diff the current buffer with the last saved version.
" License:	Vim License (see :help license)
" Location:	plugin/diffo.vim
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

" Maps: {{{1
nnoremap <Plug>difforig_open  :call diffo#open()
nnoremap <Plug>difforig_close :call diffo#close()

if !hasmapto('<Plug>diffo_open')
  nmap <unique><silent> <leader>do <Plug>diffo_open
endif

if !hasmapto('<Plug>diffo_close')
  nmap <unique><silent> <leader>dc <Plug>diffo_close
endif

" Commands: {{{1
command -nargs=0 DiffOrig call diffo#open()

" Teardown: {{{1
" reset &cpo back to users setting
let &cpo = s:save_cpo

" Template From: https://github.com/dahu/Area-41/
" vim: set sw=2 sts=2 et fdm=marker:
