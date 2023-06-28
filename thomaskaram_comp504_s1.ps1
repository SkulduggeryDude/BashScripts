cls
#New-Item creates a new object, -ItemType creates either a directory or file and -Path selects where its made
#-Force rewrites the file if its already been made, so this script can be run more than once.
New-Item -Path "C:\" -Name "Test" -ItemType Directory -Force | Out-Null
#Now the folder in C is made we can send the output of the Get-Date command there as a text file with the OutFile command
Get-Date | Out-File C:\Test\File1.txt
Get-Date | Out-File C:\Test\File2.txt
Get-Date | Out-File C:\Test\File3.txt
#To see the data, Get-Content reads the file at the chosen path and writes to console
Get-Content -Path C:\Test\File1.txt
Get-Content -Path C:\Test\File2.txt
Get-Content -Path C:\Test\File3.txt
echo "Thomas Karam 16448798"