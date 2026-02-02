#!/bin/bash

create_user(){
    read -r -p "Type your username: " username # -P important with it i'm able to print before read
    
    if [[ "$username" =~ ^[a-z_]([a-z0-9_-]{0,31}|[a-z0-9_-]{0,30}\$)$ ]]; then
        if iGITd -u "$username" &>/dev/null; then # Redirect stdout and stderr to this empty space
            echo "User already exists"
        else
            echo "User was successfuly created"
            echo "useradd -m -s /bin/bash '$username'" # -m create home diretory -s defines what shell the user will use
        fi
    else
        echo "Something went wrong"
        exit
    fi

    read -r -s -p "Enter password for $username: " password # -S important for password so we can protect password
    echo "$username:$password" | chpasswd # We need echo cuz it's the one who communicates with the chpasswd
    echo "User [$username] created successfully"
}

delete_user(){
    read -r -p "The name of the user to delete: " username

    if id -u "$username" &>/dev/null; then # Again asking for the id of the user with "$username"
       read -r -p "Are u sure that u want to delete the user ['$username']? (Y/N): "  var_delete
       if [[ ${var_delete,,} = "y" ]]; then # Convertes var_delete to lowercase, [[]] probaly [] dont support this new operations. We use {} so ",," are interpreted as operator and not the name of the variable
            userdel -r "$username"
            echo "User '$username' deleted successefully"
       else
            echo "Operation cancelled!"
       fi
    else
        echo "User '$username' not found!"
    fi 
}

listAll_user(){
    echo "Showing all users!"
    awk -F':' '{print $1}' /etc/passwd # AWK - Extract data. -F help excracting columns which uses ":" to separate de columns. /Etc/passwd is a file that contains information from the users.
    # We have 2 different types of users the humans and the services created by the system
}

block_user(){

}

unblock_user(){

}

change_password(){
    
}

listAll_user