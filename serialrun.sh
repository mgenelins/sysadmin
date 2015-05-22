#!/bin/bash
# serialrun.sh - a BASH script that serial runs arbitrary scripts on remote hosts.
#
# Usage: 
#       serialrun.sh scriptname.sh hosts.txt
# 
#  Where: scriptname.sh is the name of a script to execute. Preferrably BASH.
#         hosts.txt is the line-by-line of FQDN host names that the above script should be run on.
#

# Set your username here:
username="mgenelin"

# Check for command line arguments:
if [[ ! $1 ]] 
then 
	echo -e "Need two command arguments. Whoops! \n"
	echo -e " Usage:" 
	echo -e "Usage:" 
	echo -e "      serialrun.sh <scriptname.sh> <hosts.txt>\n\n"
	echo -e "Where: scriptname.sh is the name of a script to execute. Preferrably BASH."
	echo -e "         hosts.txt is the line-by-line of FQDN host names that the above script should be run on."
	exit 1
fi

if [[ ! $2 ]] 
then
        echo -e "Need two command arguments. Whoops! \n"
        echo -e " Usage:" 
        echo -e "Usage:" 
        echo -e "      serialrun.sh <scriptname.sh> <hosts.txt>\n\n"
        echo -e "Where: scriptname.sh is the name of a script to execute. Preferrably BASH."
        echo -e "         hosts.txt is the line-by-line of FQDN host names that the above script should be run on."
        exit 1
fi



# Assuming two commands, copy the script and execute:

for host in $(cat hosts.txt)
do
	echo -e "Hostname: $host attmpting..."
	scp "$1" "$username"@"$host":/tmp/
	ssh -t "$username"@"$host" chmod 750 /tmp/"$1"
	ssh -t "$username"@"$host" /tmp/"$1"
	echo -e "        : $host COMPLETE.\n\n"
done


# Exit, returning success:
exit 0
# NNNNN
