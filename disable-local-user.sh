#!/bin/bash

if [ "${UID}" -ne 0 ]; then
	echo 'Please run with sudo or as root!' > std.err
	exit 1
fi

U=${#}
if [ "${#}" -lt 1 ]; then
	echo "Usage: ./disable-local-user.sh [-dra] USER [USERN]" > std.err
	echo "Disable a local Linux account." >> std.err
	echo "-d Deletes accounts instead of disabling them." >> std.err
	echo "-r Removes the home directory associated with the account(s)." >> std.err
	echo "-a Creates an archive of the home directory associated with the accounts(s)." >> std.err
	exit 1
fi


#assigning VAR with the options for the operations to be performed later


while getopts 'dra:' c
do
	case ${c} in
                                                     
		d) VAR='d' ;;
                                
		r) VAR='r' ;;
                                
		a) VAR='a' ;;
                                
		?) echo "${0}: illegal option -- ${c}" > std.err
			exit 1 ;;                 
	esac
done






#removing the options from the list of arguments

parse=true
for arg in "${@}"
do
        [ "arg" == '--' ] && parse=false
        shift
        if $parse && [ "${arg:0:1}" == '-' ]; then
        	LI=$arg	        
        else
                set -- "$@" "$arg"
        fi
done


#Checking if there were any options

if [ "${#}" -eq "${U}" ]; then
        VAR='none'
fi

#traversing accross the list of usernames and performing operations accordingly

for arg in "${@}"
do	

	# Checking the UID of the user that should be above 1000
	
	if [ $(id -u $arg) > 1000 ]; then	
		if [ "${VAR}" == 'none' ]; then
			echo "Default: disabling the account....."
			chage -E0 $arg
			if [ "${?}" -eq 0 ]; then
				echo "$arg is disabled!"
			else
				echo "$arg : failed to disable!!" > std.err
				exit 1	
			fi
		elif [ "${VAR}" == 'd' ]; then
			echo "Deleting the user instead of disabling it...."
			userdel $arg
			if [ "${?}" -eq 0 ]; then
				echo "$arg is deleted!"
			else
				echo "$arg : failed to delete!!" > std.err
				exit 1
			fi
		elif [ "${VAR}" == 'r' ]; then
			echo "Removing the home directory associated with the account...."
			userdel -r $arg
			if [ "${?}" -eq 0 ]; then                                                                                                                                                           
				echo "$arg is deleted and home directory is removed!"
			else
				echo "$arg : Failed to remove home directory!" > std.err
				exit 1
			fi				
		elif [ "${VAR}" == 'a' ]; then
			echo "Saving it to archives....."
			tar cf /archives.tar /home/$arg/
			if [ "${?}" -eq 0 ]; then
				echo "$arg is archived and can be accessed using 'cat archives.tar'"
			else
				echo "$arg : failed to archive" > std.err
				exit 1
			fi
		else
			echo "The user does not exist!!" > std.err
			
		fi
	fi
done




exit 0

