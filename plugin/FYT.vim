" Flash yanked text
" File:         plugin/flash-yanked-text.vim
" Author:       statox (https://github.com/statox)
" License:      This file is distributed under the MIT License

" Initialization {{{
if exists('g:loaded_FYT_vim')
    finish
endif

" Making sure we have TextYankPost event and matchdelete accepting a window ID
if ( !has('nvim') && version < 802 )
    echoerr "FYT.vim doesn't support Vim < 8.2"
    finish
endif

let g:loaded_FYT_vim = 1
let s:save_cpo = &cpo
set cpo&vim
" }}}
" Autocommand {{{
augroup highlightYankedText
    autocmd!
    autocmd TextYankPost * call FYT#FlashYankedText(deepcopy(v:event))
    autocmd WinLeave * call FYT#DeleteMatchesInCurrentWindow()
augroup END
" }}}
" Reset {{{
let &cpo = s:save_cpo
unlet s:save_cpo
" }}}
" vim:fdm=marker:sw=4:
