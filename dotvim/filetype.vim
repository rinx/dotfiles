"filetype.vim
augroup filetypedetect
    autocmd!

    autocmd BufNewFile,BufRead .tmux.conf*,tmux.conf* setf tmux

    autocmd BufRead,BufNewFile *.hamlet  setf hamlet
    autocmd BufRead,BufNewFile *.cassius setf cassius
    autocmd BufRead,BufNewFile *.lucius  setf lucius
    autocmd BufRead,BufNewFile *.julius  setf julius

    autocmd BufNewFile,BufRead *.json set filetype=json
    autocmd BufNewFile,BufRead *.jsonp set filetype=json

augroup END


