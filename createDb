while true; do
read -p "Enter Your Database Name : " name 


if [ -z "$name" ]; then
echo "Empty Name" 

else 
name=$(echo "$name" | tr ' ' '_')

if [[ $name =~ ^[0-9] ]];then
echo "Invalid Name, Name Can't start with a number!"

 elif
 [[ ! "$name" =~ ^[a-zA-Z0-9_]+$ ]]; then
 echo "Invalid Name,Name can't Have special Characters"
 
  # $ sign is to make sure that all the string didnt contain any special character
 
 elif
 [ -e "$name" ]; then
 echo "The Database $name is already exist,Please Enter another name"
 
 else
 mkdir $name
 echo "Database "$name" is successfully created"
 break
 fi
 fi
 done
 

