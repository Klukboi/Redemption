#!/bin/sh
#
#This script generates the hook script for any defined hook steps
#Scripts are kept in the [hook-name]-hooks folder
#The installer generates a master script which loops through the folder and
#executes any scripts it finds there

# List of client-sided Git hooks
GIT_HOOKS="applypatch-msg pre-applypatch post-applypatch pre-commit prepare-commit-msg commit-msg
post-commit pre-rebase post-checkout post-merge pre-auto-gc post-rewrite
pre-push"

REPO_ROOT=`git rev-parse --show-toplevel`
REPO_GIT_DIR=`git rev-parse --git-dir`
BASEDIR="$REPO_ROOT/tools/git-hooks"

for hook in $GIT_HOOKS; do
	#Slave scripts are stored under this folder
	HOOKS_FOLDERNAME="$hook-hooks"
	#Where the hooks are currently stored
	HOOKS_FOLDER="$BASEDIR/$HOOKS_FOLDERNAME"
	#The target file for the hook master
	GIT_HOOKS_FILE="$REPO_GIT_DIR/hooks/$hook"
	
	if [ ! -d "$HOOKS_FOLDER" ]; then
		continue;
	fi

	#The master script hasn't been created yet
	if [ ! -e "$GIT_HOOKS_FILE" ]; then
		TIMESTAMP="$(date +"%T %d-%m-%Y")"
		cat > "$GIT_HOOKS_FILE" << SLAVE
#!/bin/sh

#Master script autogenerated by install-hooks.sh on $TIMESTAMP
#This script runs everything in $HOOKS_FOLDERNAME as part of the git $hook hook
#A non-zero exit indicates the script number which was failed on

SCRIPT_COUNTER=0
for SCRIPT in $HOOKS_FOLDER/*
do
	echo "Running : \$SCRIPT"
	SCRIPT_COUNTER=\$(expr \$SCRIPT_COUNTER + 1)
	#If the script file exists and can be executed
	if [ -f "\$SCRIPT" -a -x "\$SCRIPT" ]
	then
		\$SCRIPT
		if [ ! \$? -eq 0 ]
		then
			echo "Failed : \$SCRIPT"
			exit \$SCRIPT_COUNTER
		fi
	fi
done
SLAVE
		
		echo -e "\033[32m$hook: installed correctly\033[0m"
	else
		echo -e "\033[31m$hook: existing hook found, skipping...\033[0m"
	fi
done