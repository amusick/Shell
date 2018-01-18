#!/bin/bash

# Add users to the same Linux system as the script is executed on.

###
# Display the username, password, and the host where the user was
# created.
###

# Make sure the script is being executed with superuser privileges.
# If you are not root, inform user account could not be created.

if [[ "${UID}" -eq 0 ]]
then
  echo 'You are root.'
else
  echo 'You are not root.'
  echo 'Your account was not created.'
  exit 1
fi

# Ask for the user name. # Get the username (login).
read -p 'Enter the username to create: ' USER_NAME

# Ask for the real name. # Get the real name (contents for the description field).
read -p 'Enter the name of the person who this account is for: ' COMMENT

# Ask for the password. # Get the password.
read -p 'Enter the password to use for the account: ' PASSWORD

# Create the user. # Create the user with the password.
# Check to see if the useradd command succeeded.
useradd -c "${COMMENT}" -m ${USER_NAME}

# Check to see if the useradd command succeeded.
# We don't want to tell the user tha an account was created when it hasn't been.
if [[ "${?}" -ne 0 ]]
then
  echo 'The account could not be created.'
  exit 1
fi

# Set the password for the user.# Set the password.
# Check to see if the passwd command succeeded.
echo ${PASSWORD} | passwd --stdin ${USER_NAME}

# Force password change on first login.
passwd -e ${USER_NAME}

# Display the username, password, and the host where the user was
# created....display the user you entered, and the host where it was created.

# Display the hostname
# echo "Your hostname is ${HOSTNAME}."

# Display the username of the person executing this script.
# echo "Your username is ${USER_NAME}"

# Display the UID
# echo "Your UID is ${UID}"

# Display the username of the person executing this script
# echo "Your username is ${USER_NAME}"

# Display the user's account name
# echo "Your account name entered is ${COMMENT}."

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
