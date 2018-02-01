#!/bin/bash
TODAY=$(date)
HOST=$(hostname)
# Add new users on local machine & generate passwords for help desk entries.
# You must supply a username as an argument to the script.
# Optionally, you can also provide a comment for the account as an argument.
# A password will be automaticlally generated for the account.
# The username, password, and host for the account will be displayed.

# Make sure the script is being executed with superuser privileges.

if [[ "${UID}" -eq 0 ]]
then
  echo 'You are root.'
else
  echo 'You are not root.'
  echo 'Your account was not created.'
  exit 1
fi

# If the user doesn't supply at least one argument, then give them help.
if [[ "${#}" -lt 1 ]]
then
  echo "Usage: ${0} USER_NAME [COMMENT]..."
  echo 'Create an account on the local system with the name of USER_NAME and a comments field of COMMENT.'
  exit 1
fi

# The first parameter is the user name.
USER_NAME="${1}"

# The rest of the parameters are for comments.
shift
COMMENT="${@}"

# Generate a password. 
PASSWORD=$(date +%s%N${RANDOM}${RANDOM} | sha256sum | head -c48)

# Create the user with the password. 
# Check to see if the useradd command succeeded.
useradd -c "${COMMENT}" -m ${USER_NAME}

 # Set the password.
#Check to see if the password command succeeded.
echo ${PASSWORD} | passwd --stdin ${USER_NAME}

 # Force password change on first login.
passwd -e ${USER_NAME}

# Display the username, password, and the host where the user was created.
echo
echo 'username:'
echo "${USER_NAME}"
echo
echo 'password:'
echo "${PASSWORD}"
echo
echo 'host:'
echo "${HOSTNAME}"
