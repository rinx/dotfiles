#alias settings

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias rr='rm -ri'
alias rrf='rm -rf'

echo "        <<   alias settings   >> "
echo "command 'rr' is used as 'rm -ri' "
echo "command 'rrf' is used as 'rm -rf' "

alias :q='exit'

#tweet as @nepiadeath via nepia
#this requires ".twit_script.py" in home
alias twip='zenity --entry | python $HOME/.twit_script.py'
echo "You can tweet as @nepiadeath "
echo "if you use 'twip' command. "
echo "======================================== "

