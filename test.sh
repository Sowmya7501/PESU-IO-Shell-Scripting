#! /bin/bash
if [ $(id -u) -eq 0 ]; then
	read -p "Enter name : " NAME
	read -p "Enter full name : " COMMENT
	read -s -p "Enter password : " PASSWORD
	useradd -c "${COMMENT}" -m ${NAME}
	echo ${PASSWORD} | passwd --stdin ${NAME}
	passwd -e ${NAME}
	echo "User has been  added to system!"
	exit 0
else
	echo "Only root may add a user to the system"
	exit 1
fi
