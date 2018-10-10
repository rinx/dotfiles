"filetype.vim
augroup filetypedetect
    autocmd!

    autocmd BufNewFile,BufRead .tmux.conf*,tmux.conf* setf tmux

    autocmd BufRead,BufNewFile *.hamlet  setf hamlet
    autocmd BufRead,BufNewFile *.cassius setf cassius
    autocmd BufRead,BufNewFile *.lucius  setf lucius
    autocmd BufRead,BufNewFile *.julius  setf julius

    autocmd BufNewFile,BufRead *.json setf json
    autocmd BufNewFile,BufRead *.jsonp setf json

    autocmd BufNewFile,BufRead *.nml setf fortran
    autocmd BufNewFile,BufRead *.namelist setf fortran

    autocmd BufNewFile,BufRead *.go setf go
augroup END


