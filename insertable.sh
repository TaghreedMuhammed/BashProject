#!/bin/bash
read -p "Enter table name :" table_name
dataType="${table_name}_meta"
dataOfTb=$table_name

if [ ! -f "$dataType" ]; then
    echo "$dataOfTb table not found."
    else
    variable_types=$(head -1 "$dataType")
    variable_names=$(tail -1 "$dataType")

    declare -a type_array=($(echo "$variable_types" | tr    ':' ' '))
    declare -a name_array=($(echo "$variable_names" | tr ':' ' '))

for ((i = 0; i < ${#name_array[@]}; i++)); do
    j=$(($i+1)) 	
    read -p "Enter ${name_array[$i]} (${type_array[$j]}): " user_value
  
  if [ $i -eq 0 ]; then
  primarych=$(awk -F: -v search="$user_value" '$1 == search' "$dataOfTb")
   # i use -n to show non-empty if not empty cannot value be primary 
    while [ -n "$primarych" ]; do
                read -p "${name_array[$i]} must be unique. Enter another ${name_array[$i]}: " user_value
                primarych=$(awk -F: -v search="$user_value" '$1 == search' "$dataOfTb")
            done
            fi
if [ "${type_array[$j]}" == "String" ]; then
	while [[ ! "$user_value" =~ ^[a-zA-Z] ]]; do
                    read -p "${name_array[$i]} must be a string. Enter another ${name_array[$i]}: " user_value
                done
        
elif [ "${type_array[$j]}" == "Integer" ];then
    while [[ ! "$user_value" =~ ^[0-9]+$ ]]; do
                    read -p "${name_array[$i]} must be a Integer. Enter another ${name_array[$i]}: " user_value
                done
	fi    
    
   if [ $i -eq $((${#name_array[@]}-1)) ]; then
       row+="$user_value"
       else
        row+="${user_value}:"
    fi
 
done

echo "$row" >> "$dataOfTb"
echo "new row added in $dataOfTb"

fi

