#!/bin/bash

# Add users to the same Linux system as the script is executed on.

# Make sure the script is being executed with superuser privileges.
# Display if the user is the root user or not.
if [[ "${UID}" -eq 0 ]]
then
  echo 'You are root.'
else
  echo 'You are not root.'
  exit 1
fi

# If you are not root, inform user account could not be created

# Display the hostname
echo "Your hostname is ${HOSTNAME}."

# Display the UID
echo "Your UID is ${UID}"

# Display the username
USER_NAME=$(id -un)
#USER_NAME=`id -un`
echo "Your username is ${USER_NAME}"

# Ask for the user name.
read -p 'Enter the username to create: ' USER_NAME

# Ask for the real name.
read -p 'Enter the name of the person who this account is for: ' COMMENT

# Ask for the password.
read -p 'Enter the password to use for the account: ' PASSWORD

# Create the user.
useradd -c "${COMMENT}" -m ${USER_NAME}

# Set the password for the user.
echo ${PASSWORD} | passwd --stdin ${USER_NAME}

# Force password change on first login.
passwd -e ${USER_NAME}
