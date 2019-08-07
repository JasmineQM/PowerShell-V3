############################################################
#This script is to manage local users
#create local user, rename an existing user ,and remove an existing user.
#Author :Jasmine Gao
#8/7/2019
#############################################################  

do
{
     #Show selection list for user to choose'
	 "############################################################"
	 "1 - to create a new user;"
	 "2 - to rename a local user;"
	 "3 - to remove a local user;"
	 "q - to exit;"
	 "############################################################"  	 
     $input = Read-Host "Please make a selection "                   
					  
     switch ($input)
     {      
            
############################################################
# Gets option 1 from input for creating new local user
#############################################################    
           '1' {
                cls
                '#You chose option 1 to create new local user#'				
                 try{ 
				     #List out current user name
				     "Avoid to use below existing user name :"
				     $LocalUser = Get-LocalUser 
				     Write-Host $LocalUser -Separator "," -ForeGroundColor green
				     #Get input for new user name
				     $newusername = Read-Host NewUserName
				     #Get input for full name
				     $fullname = Read-Host Fullname
				     #Reminder for password setup
				     "=============================================================================================="
				     "Passwords cannot contain the user's account name or parts of the user's full name that exceed two consecutive characters."
                     "Passwords must be at least six characters in length."
                     "Passwords must contain characters from three of the following four categories:"
					 "English uppercase characters (A through Z)."
                     "English lowercase characters (a through z)."
                     "Non-alphabetic characters (for example, !, $, #, %). "
				     "=============================================================================================="
				     $Password = Read-Host Password -AsSecureString 
				     $Desctiption = Read-Host Description
				     #Create new user with password
                     New-LocalUser $newusername -Password $Password -FullName $fullname -Description $Desctiption
                     }
                 catch {
                     $Script:ReturnStatus = "Fail"
                     $Script:ReturnMessage = "Failed to Create Account"
                     $Script:ReturnMessage = "already exists" 					 
					 $Script:ReturnMessage="Unable to update the password"
                     return
                      } 		
			
           } 
############################################################
# Gets option 2 from input for renaming new local user
############################################################# 			   
		   '2' {		   
                cls
                '#You chose option 2 to rename a local user#'				 
				 try{
				    "Local user list :"   #List down current users 
				    $LocalUser = Get-LocalUser 
				    Write-Host $LocalUser -Separator "," -ForeGroundColor green 
				    $oldname = Read-Host ChooseUserToRename 
				 
                     if (Get-LocalUser -Name $oldname) #Check if the name input by user exists in current user list
                         {
						  $newname=Read-Host newname
                          Rename-LocalUser -Name $oldname -NewName $newname    #Rename a user name with newname
				          "Current user list after rename:"  #Display current usrer list after rename
				          $CurrentLocalUser = Get-LocalUser 
				          Write-Host $CurrentLocalUser -Separator "," -ForeGroundColor green #Note:Starting in Windows PowerShell 5.0, Write-Host is a wrapper for Write-Information This allows to use Write-Host to emit output to the information stream. 
                          }  						
                     else {Write-Host "Couldn't find the user name"}					  					 					 								        			
                }
                catch{
					$Script:ReturnStatus = "Fail"
					$Script:ReturnMessage = "already exists"
					$Script:ReturnMessage = "UserNotFound"
                }				
					 
           } 
############################################################
# Gets option 3 from input for removing new local user
############################################################# 		   
		   '3' {
		        cls
                '#You chose option 3 to remove local user'
				try{
				    "Local user list :"
				    $LocalUser = Get-LocalUser 
				    Write-Host $LocalUser -Separator "," -ForeGroundColor green
				    $nametoremove = Read-Host ChooseUserToRemove 
				    if(Get-LocalUser -Name $nametoremove){
				       Remove-LocalUser -Name $nametoremove -Confirm     #Remove the user with Confirm operation
				     }
					 else{
					   Write-Host "Couldn't find the user name,please check again."
					 }
					 
				    "Current user list :"
				    $CurrentLocalUser = Get-LocalUser 
				    Write-Host $CurrentLocalUser -Separator "," -ForeGroundColor green	 
				 }
				 Catch{
				 
				     $Script:ReturnStatus = "Fail"
                     $Script:ReturnMessage = "Failed to deelete user"
				 }
				
           } 'q' {
                return
           }
     }
     pause
}
until ($input -eq 'q')