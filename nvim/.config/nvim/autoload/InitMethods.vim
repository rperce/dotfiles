function! InitMethods#GoyoEnter() abort
    silent !tmux set status off
    set noshowcmd
    set scrolloff=999
    Limelight
endfunction

function! InitMethods#GoyoLeave() abort
    silent !tmux set status on
    set showcmd
    set scrolloff=5
    " to keep viml from whining about the !
    exec 'Limelight!'
endfunction

function! InitMethods#RepeatChar(char, count) abort
    return repeat(a:char, a:count)
endfunction

function! InitMethods#RepeatInput() abort
    return InitMethods#RepeatChar(nr2char(getchar()), v:count1)
endfunction

function! DeleteTrailingWS() abort
    let l:save = winsaveview()
    exec 'normal mz'
    " vint: -ProhibitCommandWithUnintendedSideEffect -ProhibitCommandRelyOnUser
    %s/\v\s+$//ge
    " vint: +ProhibitCommandWithUnintendedSideEffect +ProhibitCommandRelyOnUser
    exec 'normal `z'
    call winrestview(l:save)
endfunc

