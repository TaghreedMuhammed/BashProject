while true;do
read -p "Enter the name of database you want to drop :" name 

if [ -z "$name" ]; then
echo "Empty Name" 

else 
name=$(echo "$name" | tr ' ' '_')

if [[ $name =~ ^[0-9] ]];then
echo "Can't Found Name"

 elif
 [[ ! "$name" =~ ^[a-zA-Z0-9_]+$ ]]; then
 echo "Can't Found Name"
 
 elif
 [ -e "$name" ]; then
 rm -r $name
 echo "The Database $name is successfully dropped!"
 break
 else
 echo "There is no database with this name try again"
 
 fi
 fi
 done
