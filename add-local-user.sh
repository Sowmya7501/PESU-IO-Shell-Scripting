#! /bin/bash
if [ "${UID}" -ne 0 ]; then
	echo "Please run with sudo or as root"
	exit 1
fi



USER_NAME=${1}
shift 1
COMMENT=${*}
PASSWORD=$(date +%s%N${RANDOM}${RANDOM} | sha256sum | head -c48)


if [ "${#}" -eq 0 ]; then
	echo "User_name not specified!"
	echo "Please type in your username in this format './script_name.sh user_name comment.....' "
	exit 1
fi


useradd -c "${COMMENT}" -m ${USER_NAME}


if [ "${?}" -ne 0 ]; then
	echo "The account could not be created!"
	exit 1
fi 


echo ${PASSWORD} | passwd --stdin ${USER_NAME}
passwd -e ${USER_NAME}


echo "User_name:"
echo "${USER_NAME}"
echo "Password:"
echo "${PASSWORD}"
echo "Host:"
echo "${HOSTNAME}"
echo "Comment:"
echo "${COMMENT}"
exit 0

