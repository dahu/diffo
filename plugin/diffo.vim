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
nnoremap <plug>diffo_open   :call diffo#open()<cr>
nnoremap <plug>diffo_close  :call diffo#close()<cr>
nnoremap <plug>diffo_update :diffupdate<cr>

if !hasmapto('<plug>diffo_open')
  nmap <unique><silent> <leader>do <plug>diffo_open
endif

if !hasmapto('<plug>diffo_close')
  nmap <unique><silent> <leader>dc <plug>diffo_close
endif

if !hasmapto('<plug>diffo_update')
  nmap <unique><silent> <leader>du <plug>diffo_update
endif

" Commands: {{{1
command -nargs=0 DiffOrig call diffo#open()

" Teardown: {{{1
" reset &cpo back to users setting
let &cpo = s:save_cpo

" Template From: https://github.com/dahu/Area-41/
" vim: set sw=2 sts=2 et fdm=marker:
