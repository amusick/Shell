#!/bin/bash

# Add new users & generate passwords for help desk entries.

# Make sure the script is being executed with superuser privileges.
TODAY=$(date)
HOST=$(hostname)

if [[ "${UID}" -eq 0 ]]
then
  echo 'You are root.'
else
  echo 'You are not root.'
  echo 'Your account was not created.'
  exit 1
fi

# If the user doesn't supply at least one argument, then give them help.
# Ask for the user name. # Get the username (login).
read -p 'Enter the username to create: ' USER_NAME

# Ask for the real name. # Get the real name (contents for the description field).
read -p 'Enter the name of the person who this account is for: ' COMMENT

# The first parameter is the user name.
# The rest of the parameters are for the account comments. 
# Generate a password. 

# Append a special character to the password.
SPECIAL_CHARACTER=$(echo '!@#$%^&*()_+0-' | fold -w1 | shuf | head -c1)
echo "${PASSWORD}${SPECIAL_CHARACTER}"

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
