.PHONY: \
    vim-ftplugins \
    vim-ftdetects \
    vim-snippets \
    vim-indents

vim-ftplugins: \
    $(HOME)/.vim/filetype.vim \
    $(HOME)/.config/nvim/filetype.vim \
    $(HOME)/.vim/ftplugin/clojure/clojure.vim \
    $(HOME)/.config/nvim/ftplugin/clojure/clojure.vim \
    $(HOME)/.vim/ftplugin/fortran/fortran.vim \
    $(HOME)/.config/nvim/ftplugin/fortran/fortran.vim \
    $(HOME)/.vim/ftplugin/python/python.vim \
    $(HOME)/.config/nvim/ftplugin/python/python.vim \
    $(HOME)/.vim/ftplugin/ruby/ruby.vim \
    $(HOME)/.config/nvim/ftplugin/ruby/ruby.vim \
    $(HOME)/.vim/ftplugin/tex/tex.vim \
    $(HOME)/.config/nvim/ftplugin/tex/tex.vim \
    $(HOME)/.vim/ftplugin/idlang/idlang.vim \
    $(HOME)/.config/nvim/ftplugin/idlang/idlang.vim \
    $(HOME)/.vim/ftplugin/haskell/haskell.vim \
    $(HOME)/.config/nvim/ftplugin/haskell/haskell.vim \
    $(HOME)/.vim/ftplugin/nim/nim.vim \
    $(HOME)/.config/nvim/ftplugin/nim/nim.vim

vim-ftdetects: \
    $(HOME)/.vim/ftdetect/purescript.vim \
    $(HOME)/.config/nvim/ftdetect/purescript.vim \
    $(HOME)/.vim/ftdetect/eta.vim \
    $(HOME)/.config/nvim/ftdetect/eta.vim \
    $(HOME)/.vim/ftdetect/markdown.vim \
    $(HOME)/.config/nvim/ftdetect/markdown.vim

vim-snippets: \
    $(HOME)/.vim/my-snippets \
    $(HOME)/.config/nvim/my-snippets

vim-indents: \
    $(HOME)/.vim/indent \
    $(HOME)/.config/nvim/indent

$(HOME)/.vim/filetype.vim:
	mkdir -p $(HOME)/.vim
	ln -s $(DOTDIR)/dotvim/filetype.vim $(HOME)/.vim/filetype.vim

$(HOME)/.config/nvim/filetype.vim:
	mkdir -p $(HOME)/.config/nvim
	ln -s $(DOTDIR)/dotvim/filetype.vim $(HOME)/.config/nvim/filetype.vim

$(HOME)/.vim/ftplugin/clojure/clojure.vim:
	mkdir -p $(HOME)/.vim/ftplugin/clojure
	ln -s $(DOTDIR)/dotvim/ftplugin/clojure/clojure.vim $(HOME)/.vim/ftplugin/clojure/clojure.vim

$(HOME)/.config/nvim/ftplugin/clojure/clojure.vim:
	mkdir -p $(HOME)/.config/nvim/ftplugin/clojure
	ln -s $(DOTDIR)/dotvim/ftplugin/clojure/clojure.vim $(HOME)/.config/nvim/ftplugin/clojure/clojure.vim

$(HOME)/.vim/ftplugin/fortran/fortran.vim:
	mkdir -p $(HOME)/.vim/ftplugin/fortran
	ln -s $(DOTDIR)/dotvim/ftplugin/fortran/fortran.vim $(HOME)/.vim/ftplugin/fortran/fortran.vim

$(HOME)/.config/nvim/ftplugin/fortran/fortran.vim:
	mkdir -p $(HOME)/.config/nvim/ftplugin/fortran
	ln -s $(DOTDIR)/dotvim/ftplugin/fortran/fortran.vim $(HOME)/.config/nvim/ftplugin/fortran/fortran.vim

$(HOME)/.vim/ftplugin/python/python.vim:
	mkdir -p $(HOME)/.vim/ftplugin/python
	ln -s $(DOTDIR)/dotvim/ftplugin/python/python.vim $(HOME)/.vim/ftplugin/python/python.vim

$(HOME)/.config/nvim/ftplugin/python/python.vim:
	mkdir -p $(HOME)/.config/nvim/ftplugin/python
	ln -s $(DOTDIR)/dotvim/ftplugin/python/python.vim $(HOME)/.config/nvim/ftplugin/python/python.vim

$(HOME)/.vim/ftplugin/ruby/ruby.vim:
	mkdir -p $(HOME)/.vim/ftplugin/ruby
	ln -s $(DOTDIR)/dotvim/ftplugin/ruby/ruby.vim $(HOME)/.vim/ftplugin/ruby/ruby.vim

$(HOME)/.config/nvim/ftplugin/ruby/ruby.vim:
	mkdir -p $(HOME)/.config/nvim/ftplugin/ruby
	ln -s $(DOTDIR)/dotvim/ftplugin/ruby/ruby.vim $(HOME)/.config/nvim/ftplugin/ruby/ruby.vim

$(HOME)/.vim/ftplugin/tex/tex.vim:
	mkdir -p $(HOME)/.vim/ftplugin/tex
	ln -s $(DOTDIR)/dotvim/ftplugin/tex/tex.vim $(HOME)/.vim/ftplugin/tex/tex.vim

$(HOME)/.config/nvim/ftplugin/tex/tex.vim:
	mkdir -p $(HOME)/.config/nvim/ftplugin/tex
	ln -s $(DOTDIR)/dotvim/ftplugin/tex/tex.vim $(HOME)/.config/nvim/ftplugin/tex/tex.vim

$(HOME)/.vim/ftplugin/idlang/idlang.vim:
	mkdir -p $(HOME)/.vim/ftplugin/idlang
	ln -s $(DOTDIR)/dotvim/ftplugin/idlang/idlang.vim $(HOME)/.vim/ftplugin/idlang/idlang.vim

$(HOME)/.config/nvim/ftplugin/idlang/idlang.vim:
	mkdir -p $(HOME)/.config/nvim/ftplugin/idlang
	ln -s $(DOTDIR)/dotvim/ftplugin/idlang/idlang.vim $(HOME)/.config/nvim/ftplugin/idlang/idlang.vim

$(HOME)/.vim/ftplugin/haskell/haskell.vim:
	mkdir -p $(HOME)/.vim/ftplugin/haskell
	ln -s $(DOTDIR)/dotvim/ftplugin/haskell/haskell.vim $(HOME)/.vim/ftplugin/haskell/haskell.vim

$(HOME)/.config/nvim/ftplugin/haskell/haskell.vim:
	mkdir -p $(HOME)/.config/nvim/ftplugin/haskell
	ln -s $(DOTDIR)/dotvim/ftplugin/haskell/haskell.vim $(HOME)/.config/nvim/ftplugin/haskell/haskell.vim

$(HOME)/.vim/ftplugin/nim/nim.vim:
	mkdir -p $(HOME)/.vim/ftplugin/nim
	ln -s $(DOTDIR)/dotvim/ftplugin/nim/nim.vim $(HOME)/.vim/ftplugin/nim/nim.vim

$(HOME)/.config/nvim/ftplugin/nim/nim.vim:
	mkdir -p $(HOME)/.config/nvim/ftplugin/nim
	ln -s $(DOTDIR)/dotvim/ftplugin/nim/nim.vim $(HOME)/.config/nvim/ftplugin/nim/nim.vim

$(HOME)/.vim/ftdetect/purescript.vim:
	mkdir -p $(HOME)/.vim/ftdetect
	ln -s $(DOTDIR)/dotvim/ftdetect/purescript.vim $(HOME)/.vim/ftdetect/purescript.vim

$(HOME)/.config/nvim/ftdetect/purescript.vim:
	mkdir -p $(HOME)/.config/nvim/ftdetect
	ln -s $(DOTDIR)/dotvim/ftdetect/purescript.vim $(HOME)/.config/nvim/ftdetect/purescript.vim

$(HOME)/.vim/ftdetect/eta.vim:
	mkdir -p $(HOME)/.vim/ftdetect
	ln -s $(DOTDIR)/dotvim/ftdetect/eta.vim $(HOME)/.vim/ftdetect/eta.vim

$(HOME)/.config/nvim/ftdetect/eta.vim:
	mkdir -p $(HOME)/.config/nvim/ftdetect
	ln -s $(DOTDIR)/dotvim/ftdetect/eta.vim $(HOME)/.config/nvim/ftdetect/eta.vim

$(HOME)/.vim/ftdetect/markdown.vim:
	mkdir -p $(HOME)/.vim/ftdetect
	ln -s $(DOTDIR)/dotvim/ftdetect/markdown.vim $(HOME)/.vim/ftdetect/markdown.vim

$(HOME)/.config/nvim/ftdetect/markdown.vim:
	mkdir -p $(HOME)/.config/nvim/ftdetect
	ln -s $(DOTDIR)/dotvim/ftdetect/markdown.vim $(HOME)/.config/nvim/ftdetect/markdown.vim

$(HOME)/.vim/my-snippets:
	mkdir -p $(HOME)/.vim
	ln -s $(DOTDIR)/dotvim/my-snippets $(HOME)/.vim/my-snippets

$(HOME)/.config/nvim/my-snippets:
	mkdir -p $(HOME)/.config/nvim
	ln -s $(DOTDIR)/dotvim/my-snippets $(HOME)/.config/nvim/my-snippets

$(HOME)/.vim/indent:
	mkdir -p $(HOME)/.vim
	ln -s $(DOTDIR)/dotvim/indent $(HOME)/.vim/indent

$(HOME)/.config/nvim/indent:
	mkdir -p $(HOME)/.config/nvim
	ln -s $(DOTDIR)/dotvim/indent $(HOME)/.config/nvim/indent

