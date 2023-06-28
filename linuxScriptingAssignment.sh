#!/bin/bash

#
# This is my bash script for assignment 2 for my COMP504 Operating Systems class.
# This script is for creating backup files on any linux machine, without the need to configure the script as it uses $USER, the current logged in user.
# All files can be restored by entering the filename.
#
# Made by Thomas Karam 16448798

# Comment this out if you dont want this script to create users on your machine
# adduser thomas
# passwd thomas
# mkdir thomas
# chown thomas /home/thomas
# su thomas


#This section creates the folder structure and files for the assignment. 
#A folder is made with mkdir to make a directory, the -p removes the output to the terminal.
#The touch command is used to create a file, .txt specifies it to be a txt file
#Touch can create as many files as you want as long as they are seperated with a space
mkdir -p /home/"$USER"/projectfiles/budget
touch /home/"$USER"/projectfiles/budget/"$USER"budget1.txt /home/"$USER"/projectfiles/budget/"$USER"budget2.txt
mkdir -p /home/"$USER"/projectfiles/documents
touch /home/"$USER"/projectfiles/documents/"$USER"doc1.txt /home/"$USER"/projectfiles/documents/"$USER"doc2.txt
mkdir -p /home/"$USER"/projectfiles/old
touch /home/"$USER"/projectfiles/old/"$USER"old1.txt /home/"$USER"/projectfiles/old/"$USER"old2.txt
#ls displays a list of the files in the parent directory that was made when we created the directories above
#The -l option extends the list to include permissions and ownership/group setting details
ls -l /home/"$USER"/projectfiles


#This section uses a program called rsync to create a copy of files. 
mkdir -p /home/"$USER"/"$USER"rsynccopy
#Options v for verbose, a to create archive file, z for compressed and r for recursive to include directories within.
#You may select as many folders/files to be copied by seperating them with a space as long as the last one is the destination folder
#If the rsync command executes sucessfully it will display 'finished rsync' with echo
rsync -vzar /home/"$USER"/projectfiles/documents /home/"$USER"/projectfiles/budget /home/"$USER"/"$USER"rsynccopy && echo Finished rsync


#This section creates a backup folder and put all files in the projectfiles into it as compressed archives files with tar
mkdir -p /home/"$USER"/backups
#When we create the tar file, we can name it using a variable with $date.
#The date is assigned to this variable with =$(date times) where time can include units of time measurement such as %Y for year, %m for month and %d for day
date=$(date +%Y-%m-%d )
#The tar command with -P determines that absolute filepaths are used, c is for creating a new archive, f is file, as in use the file names we are giving it, z is for using gzip to compress files
#-v is for verbose output, which is being made into a log file and saved alongside the tar file in /backup
tar Pcvfz /home/"$USER"/backups/"$USER"backup"$date".tar.gz /home/"$USER"/projectfiles/ > /home/"$USER"/backups/"$USER".log

#This section is for restoring the backup files that were created in the previous section
#Screen is cleared for visual clatiry
clear
#Folder is created to store restored files into
mkdir -p /home/"$USER"/restore
#The contents of the backup directory is listed in console so that the user can easily see and type in which file they want to restore
ls /home/"$USER"/backups
#The console asks for input with read and stores the users input as a varaible called filename
read -r filename
#The tar command here does the same as above but in reverse. The -C is for absolute filepaths. I dont know why this command needs -C and the other doesnt but does need -P but if you remove it tar wont work.
#Console will output "removing leading / from member names" if you dont include -P but if you remove it then it doesnt work
#x is for extracting the files from archive, v is for verbose output which is made into a log file and saved alongside the folder in /restore
#If the file is restored sucessfully, then the terminal will print restore complete.
tar xvzf /home/"$USER"/backups/"$filename" -C /home/"$USER"/restore > /home/"$USER"/restore/"$USER"-restore.log && echo Restore complete