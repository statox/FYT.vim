" Flash yanked text
" File:         autoload/flash-yanked-text.vim
" Author:       statox (https://github.com/statox)
" License:      This file is distributed under the MIT License

" Initialization {{{
if exists('g:autoloaded_FYT_vim')
    finish
endif

" Making sure we have TextYankPost event and matchdelete accepting a window ID
if ( !has('nvim') && version < 802 )
    finish
endif

let g:autoloaded_FYT_vim = 1
let s:save_cpo = &cpo
set cpo&vim
"}}}
" functions {{{
function! s:DeleteTemporaryMatch(timerId)
    while !empty(s:yankedTextMatches)
        let match = remove(s:yankedTextMatches, 0)
        let windowID = match[0]
        let matchID = match[1]

        try
            call matchdelete(matchID, windowID)
        endtry
    endwhile
endfunction

function! FYT#FlashYankedText()
    if (!exists('s:yankedTextMatches'))
        let s:yankedTextMatches = []
    endif

    let matchId = matchadd('IncSearch', ".\\%>'\\[\\_.*\\%<']..")
    let window = winnr()
    let flashTime =  get(g:, 'FYT_flash_time', 500)

    call add(s:yankedTextMatches, [window, matchId])
    call timer_start(flashTime, function('<SID>DeleteTemporaryMatch'))
endfunction
" }}}
" Reset {{{
let &cpo = s:save_cpo
unlet s:save_cpo
" }}}
" vim:fdm=marker:sw=4:
