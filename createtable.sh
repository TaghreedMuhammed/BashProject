shopt -s extglob
while true
do
read -p "Enter the name of the table: " name
if [ -z "$name" ]; then

echo "Empty Name" 

else 
name=$(echo "$name" | tr ' ' '_')

if [[ $name =~ ^[0-9] ]];then
echo "Invalid Name, Name Can't start with a number!"

 elif
 [[ ! "$name" =~ ^[a-zA-Z0-9_]+$ ]]; then
 echo "Invalid Name,Name can't Have special Characters"
 elif
 [[  "$name" =~ ^[_]+$ ]]; then
 echo "Invalid Name,Name can't Have only _"
 
 elif
 [ -e "$name" ]; then
 echo "The Database $name is already exist,Please Enter another name"
 
 else
 touch $name
 touch "${name}_meta"
 echo "table "$name" is successfully created"
 break
 fi
 fi
done

#show no of colums and data type

read -p "Enter the number of the colums: " col
echo "first column is primary key"
 data="$col:"
columns_name=""
for ((i=1; i<=$col; i++)); do
  while true; do
    read -p "Enter the name of the columns: " col_name
    if [[ ! $columns_name =~ (^|:)$col_name(:|$) ]]; then
       if [ $i -eq $col ]; then
       columns_name+="$col_name"
       else
        columns_name+="$col_name:"
    fi
      break
    else
      echo "Column name '$col_name' is already used."
    fi
  done
done
for ((i=1; i<=$col; i++)); do
  options=("String" "Integer")

  select choice in "${options[@]}"
  do
    case $REPLY in
      1 ) data+="String"
      ;;
      2 ) data+="Integer"
      ;;
      *) data+="String"
      ;;
    esac
   if [ $i -lt $col ]; then
      data+=":"
    fi
  break
  done
done

echo "$data" >> "${name}_meta"
echo "$columns_name" >> ${name}_meta






