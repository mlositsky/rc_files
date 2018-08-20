#.bashrc

# Go home
cd

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Source .bashrc.d definiions
for file in ~/.bashrc.d/*.bashrc;
do
  source "$file"
done
