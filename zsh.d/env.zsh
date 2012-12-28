#env

#for python
#virtualenvwrapper.sh呼出
if [ -f /bin/virtualenvwrapper.sh ]; then
	export WORKON_HOME=$HOME/.virtualenvs
	source /bin/virtualenvwrapper.sh
fi

