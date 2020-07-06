" Flash yanked text
" File:         autoload/flash-yanked-text.vim
" Author:       statox (https://github.com/statox)
" License:      This file is distributed under the MIT License

" Initialization {{{
if exists('g:loaded_flash_yanked_text') || version < 800
    finish
endif
"}}}
" functions {{{
function! s:DeleteTemporaryMatch(timerId)
    while !empty(g:yankedTextMatches)
        let match = remove(g:yankedTextMatches, 0)
        let windowID = match[0]
        let matchID = match[1]

        try
            call matchdelete(matchID, windowID)
        endtry
    endwhile
endfunction

function! FYT#FlashYankedText()
    if (!exists('g:yankedTextMatches'))
        let g:yankedTextMatches = []
    endif

    " let matchId = matchadd('IncSearch', ".\\%>'\\[\\_.*\\%<']..")
    let matchId = matchadd('IncSearch', "\\%'\\[\\_.*\\%']")
    let window = winnr()

    call add(g:yankedTextMatches, [window, matchId])
    call timer_start(500, '<SID>DeleteTemporaryMatch')
endfunction
" }}}
" Reset {{{
let &cpo = s:save_cpo
unlet s:save_cpo
" }}}
" vim:fdm=marker:sw=4:
