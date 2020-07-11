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

function! FYT#FlashYankedText(event)
    " Don't highlight if the last command was not a yank
    if (a:event.operator != 'y')
        return
    endif

    if (!exists('s:yankedTextMatches'))
        let s:yankedTextMatches = []
    endif

    let window = winnr()

    " Handle case of visual block using one match by line
    if (len(a:event.regtype) > 0 && a:event.regtype[0] == "\<C-V>")
        let lineStart = getpos("'<")[1]
        let lineStop = getpos("'>")[1]
        let columnStart = getpos("'<")[2]
        let columnStop = getpos("'>")[2]

        " For each line in the block selection create a pattern using the first and last column
        " The pattern looks like this:
        "   \%Xl\%Yc.*\%Zc
        " Where X is the line, Y the first column and Z the last column
        for line in range(lineStart, lineStop)
            echom "line " . line
            let matchId = matchadd(get(g:, 'FYT_highlight_group', 'IncSearch'), "\\%" . line . "l\\%" . columnStart . "c.*\\%" . columnStop . "c")
            call add(s:yankedTextMatches, [window, matchId])
        endfor
    else " Other visual types
        let matchId = matchadd(get(g:, 'FYT_highlight_group', 'IncSearch'), ".\\%>'\\[\\_.*\\%<']..")
        call add(s:yankedTextMatches, [window, matchId])
    endif

    call timer_start(get(g:, 'FYT_flash_time', 500), function('<SID>DeleteTemporaryMatch'))
endfunction
" }}}
" Reset {{{
let &cpo = s:save_cpo
unlet s:save_cpo
" }}}
" vim:fdm=marker:sw=4:
