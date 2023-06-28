cls
Write-Host "Thomas Karam 16448798"


#New-Item creates a new object, -ItemType creates either a directory or file and -Path selects where its made
#-Force rewrites the file if its already been made, so this script can be run more than once.
#Out-Null prevents New-Item from printing to the console 
New-Item -Path "C:\" -Name "Backup" -ItemType Directory -Force | Out-Null
New-Item -Path "C:\Backup" -Name "Documents" -ItemType Directory -Force | Out-Null


#Copy-Item copys a source folder/file to a destination. -Include only copies .docx files 
#The \* at the end means all files in the directory are copied
#-PassThru creates an output for the Copy-Item command and $copyCount stores this as a variable to be printed in the next line
#I have used the $env:UserName variable to capture the current users name so that this program can be used on any computers file system
$copyCount = Copy-Item -Path "C:\Users\$env:UserName\Documents\*" -Destination "C:\Backup\Documents\" -Include *.docx -PassThru
#Write-Host prints to the console
Write-Host Copied $copyCount.count files


#As Remove-Item doesnt have -PassThru to make an output. Get-Children counts them before they are deleted and assigns them to a variable
$deleteCount = Get-ChildItem -Path "C:\Backup\Documents\*" -Include *.tmp
#Write-Host now prints this like we did for copying
Write-Host Deleted $deleteCount.count files
#Once it has been printed it removes them with the path saved in the variable and Remove-Item
$deleteCount | Remove-Item


#Compress-Archive is used to zip all fines in documents and put them in a zip file in backup. -Force will replace the existing file
Compress-Archive -Path C:\Backup\Documents\* -DestinationPath "C:\Backup\Backup_Documents_ThomasKaram.zip" -Force
Write-Host "Your backup has been zipped to C:\Backup"
