" Statusline settings

"leftstatus
set statusline=%F  "full path
set statusline+=%m "modified flag
set statusline+=%r "readonly flag
set statusline+=%h "help-buffer flag
set statusline+=%w "preview-window flag

set statusline+=%= "left-right

"rightstatus
set statusline+=%{SkkGetModeStr()}\        "SKK-status
"set statusline+=%{eskk#get_mode()}\ 
set statusline+=%{fugitive#statusline()}\  "git branch
set statusline+=[FMT=%{&ff}]\              "format
set statusline+=[ENC=%{&fileencoding}]\    "fileencoding
set statusline+=[TYP=%Y]\                  "filetype
set statusline+=[POS=%04v]\                "position
set statusline+=[LOW=%04l/%04L][%03p%%]    "low

set laststatus=2


