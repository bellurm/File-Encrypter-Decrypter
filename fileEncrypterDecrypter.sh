#! /bin/bash

# File Encryption
function fileEncryption(){

	gpg -c $fileEncryption
	
	echo -e "[*] We'll hide your extension of encryption file like 'file.txt'.\n"
	read -p "[*] That's why, enter your new secret file name: " fileName

	extension="gpg"

	touch ${fileName}
	
	cp ${fileEncryption}.${extension} ${fileName}
	
	echo -e "\nDone.\n"
}

# File Decryption
function fileDecryption(){
	
	content=`gpg -d $fileDecryption`
	
	echo $content
	
	echo -e "\n"
	read -p "Do you want to move the content to a new file? (y/n): " moveContent

	if [ $moveContent == 'y' -o $moveContent == 'Y' ]
	then
		move_content
		
	elif [ $moveContent == 'n' -o $moveContent == 'N' ]
	then
		echo -e "Good luck.\n"

	else
		echo "Please, 'y' or 'n'."
	fi
}

# Transferring the contents of the decrypted file to a new file.
function move_content() {
	
	read -p "New file's name: " newFile

	if [ -f $newFile ]
	then
		echo -e "'$newFile' is exists.\n"
		echo -e "Warning: This operation will be delete the old content of the file.\n"
		read -p "Shall we overwrite? (y/n): " overWrite
			
		if [[ $overWrite == "y" || $overWrite == "Y" ]]
		then
			echo > $newFile $content
			echo -e "Done.\n"
			
		elif [[ $overWrite == "n" || $overWrite == "N" ]]
		then	
			read -p "Choose an another name: " fileName
			touch $fileName
			echo > $newFile $content
			echo -e "[*] Done.\n"
			
		else
				echo "Please, 'y' or 'n'."
		fi

	else
		touch $newFile	
		echo > $newFile $content
		echo -e "[*] Done.\n"
	fi
}

# Main menu and source of all operations.
select operations in "Encryption" "Decryption" "Quit"; do

	cd
	
	if [[ $operations == "Encryption" ]]
	then
		echo -e "[*] Selected: Encryption.\n"
		read -p "[?] Where is the file? > " location
		read -p "[?] File's name to be encrypted: " fileEncryption
		
		cd $location
		
		fileEncryption
	
	elif [[ $operations == "Decryption" ]]
	then
		echo -e "[*] Selected: Decryption.\n"
		
		read -p "[?] Where is the file? > " location
		read -p "[?] File's name to be decryption: " fileDecryption
		
		cd $location
		
		fileDecryption
		
	elif [[ $operations == "Quit" ]]
	then
		echo "[*] Thanks for using Cyber Worm's script."
		break
		
	else
		echo "[!] Please, 'Encryption' or 'Decryption'."
	fi
done