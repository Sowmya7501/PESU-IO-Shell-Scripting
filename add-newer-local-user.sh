#!/bin/bash
if [ "${UID}" -ne 0 ]; then
	echo "Please run with sudo or as root!" > std.err
	exit 1
fi

if [ "${#}" -lt 1 ]; then
	echo "Usage: ${0} USER_NAME [COMMENT]..." > std.err
	echo "Create an account on the local system with the name of USER_NAME and a comments field of COMMENT" >> std.err
	exit 1
fi
USER_NAME="${1}"
shift
COMMENT="${@}"

PASSWORD=$(date +%s%N | sha256sum | head -c48)

useradd -c "${COMMENT}" -m ${USER_NAME}

if [ "${?}" -ne 0 ]; then
	echo "The password for the account could not be set." > std.err
	exit 1
fi
passwd -e ${USER_NAME} 
echo
echo "username:"
echo "${USER_NAME}"
echo
echo "password:"
echo "${PASSWORD}"
echo
echo "host:"
echo "${HOSTNAME}"
exit 0








exit 0
