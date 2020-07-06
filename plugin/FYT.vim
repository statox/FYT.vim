" Flash yanked text
" File:         plugin/flash-yanked-text.vim
" Author:       statox (https://github.com/statox)
" License:      This file is distributed under the MIT License

" Initialization {{{
if exists('g:loaded_FYT_vim') || version < 800
    finish
endif

let g:loaded_FYT_vim = 1
let s:save_cpo = &cpo
set cpo&vim
" }}}
" Autocommand {{{
augroup highlightYankedText
    autocmd!
    autocmd TextYankPost * call FYT#FlashYankedText()
augroup END
" }}}
" Reset {{{
let &cpo = s:save_cpo
unlet s:save_cpo
" }}}
" vim:fdm=marker:sw=4:
