#!/bin/bash
shopt -s extglob
read -p "Enter table name :" table_name
dataOfTb=$table_name
dataType="${table_name}_meta" 
variable_types=$(head -1 "$dataType")
 declare -a type_array=($(echo "$variable_types" | tr    ':' ' '))
if [ ! -f "$dataOfTb" ]; then
    echo "$dataOfTb table not found."
    else
variableNames=$(tail -1 "$dataType") 
declare -a nameArr=($(echo "$variableNames" | tr ':' ' '))   
echo "${variableNames}"
PS3="which select want: "
  options=("select by Row" "select by Columns")

  select choice in "${options[@]}"
  do
  case $REPLY in
      1 ) 
      PS3="Selection by Row : "
  options=("select all records" "Select some records" 
  "Select from special record to last " 
  "select record on condition")
  select choice in "${options[@]}"
  do
  case $REPLY in
  1 )  echo "all table is"
      cat "$dataOfTb"
      ;;
  2 ) read -p "Enter start line :" start
      read -p "Enter end line :" end
       sed -n "${start},${end}p" "$dataOfTb"
      ;;
  3 ) read -p "Enter start line :" start
       tail +$start "$dataOfTb"
      ;; 
   4 )
    for ((i = 0 ; i < ${#nameArr[@]}; i++)); do
      j=$((i+1))
     echo "${j} ) ${nameArr[$i]}"
      done
     read -p "enter the number column conditon:" ncol
      read -p "enter the search value:" val
      if [ "${type_array[$ncol]}" == "String" ]; then
      awk -F : -v col="$ncol" -v value="$val" '{
	if($col == value){
	print $0
	}
	}' "$dataOfTb"  
      elif [ "${type_array[$ncol]}" == "Integer" ]; then
      PS3="choice codition: "
  options=("equal" "greater than" 
  "greater than or equal"
  "less than" "less than or equal" "exit")
  select choice in "${options[@]}"
  do
  case $REPLY in
  1 )
     awk -F : -v col="$ncol" -v value="$val" '{
	if($col == value){
	print $0
	}
	}' "$dataOfTb"
	;;
  2 )
     awk -F : -v col="$ncol" -v value="$val" '{
	if($col > value){
	print $0
	}
	}' "$dataOfTb"
     ;;	
  3 )
     awk -F : -v col="$ncol" -v value="$val" '{
	if($col >= value){
	print $0
	}
	}' "$dataOfTb"
      ;;
   4 )
          awk -F : -v col="$ncol" -v value="$val" '{
	if($col < value){
	print $0
	}
	}' "$dataOfTb"
	;;
    5 )
          awk -F : -v col="$ncol" -v value="$val" '{
	if($col <= value){
	print $0
	}
	}' "$dataOfTb"
	;;
     6 )
     exit
     ;; 
     * )
     echo "Error"
     ;;
     * )
     echo "Error"	
  esac
  done
  fi
  esac
  done
      ;;
      
      
      2 )
        PS3="Selection by Colums : "
  options=("select special column without condition" "select special column with condition")
  select choice in "${options[@]}"
  do
  case $REPLY in
 1 )
      for ((i = 0 ; i < ${#nameArr[@]}; i++)); do
      j=$((i+1))
     echo "${j} ) ${nameArr[$i]}"
      done
      read -p "enter the number of columns you want to display :" numofcols
      if [[ $numofcols -le ${#nameArr[@]} && $numofcols -gt 0 ]]; then
      for ((i = 1 ; i <= numofcols; i++)); do
      read -p "enter the number column $i  :" numcols
      columns+=("$numcols")
            done
#use paste to make marge after cut       
 tail -1 "$dataType" | cut -d: -f"${columns[*]}" | paste
cut -d: -f"${columns[*]}" "$dataOfTb" | paste
      exit
      else
      echo "Invalid Input :)"
      fi
      ;;
      
      2 )
      for ((i = 0 ; i < ${#nameArr[@]}; i++)); do
      j=$((i+1))
     echo "${j} ) ${nameArr[$i]}"
      done
      read -p "enter the number of columns you want to display :" numofcols
      read -p "enter the number column conditon:" ncol
      read -p "enter the search value:" val
      if [[ $numofcols -le ${#nameArr[@]} && $numofcols -gt 0 ]]; then
      for ((i = 1 ; i <= numofcols; i++)); do
      read -p "enter the number $i column   :" numcols
      columns+=("$numcols")
            done
            
             if [ "${type_array[$ncol]}" == "String" ]; then
             
      awk -F : -v col="$ncol" -v value="$val" '{
	if($col == value){
	print $0
	}
	}' "$dataOfTb" | cut -d: -f"${columns[*]}" | paste 
	
	     elif [ "${type_array[$ncol]}" == "Integer" ]; then
      PS3="choice codition: "
  options=("equal" "greater than" 
  "greater than or equal"
  "less than" "less than or equal" "exit")
  select choice in "${options[@]}"
  do
  case $REPLY in
  1 )
     awk -F : -v col="$ncol" -v value="$val" '{
	if($col == value){
	print $0
	}
	}' "$dataOfTb" | cut -d: -f"${columns[*]}" | paste 
	;;
  2 )
     awk -F : -v col="$ncol" -v value="$val" '{
	if($col > value){
	print $0
	}
	}' "$dataOfTb" | cut -d: -f"${columns[*]}" | paste 
     ;;	
  3 )
     awk -F : -v col="$ncol" -v value="$val" '{
	if($col >= value){
	print $0
	}
	}' "$dataOfTb" | cut -d: -f"${columns[*]}" | paste 
      ;;
   4 )
          awk -F : -v col="$ncol" -v value="$val" '{
	if($col < value){
	print $0
	}
	}' "$dataOfTb" | cut -d: -f"${columns[*]}" | paste 
	;;
    5 )
          awk -F : -v col="$ncol" -v value="$val" '{
	if($col <= value){
	print $0
	}
	}' "$dataOfTb" | cut -d: -f"${columns[*]}" | paste 
	;;
     6 )
     exit 
     ;;
     * )
     echo "Error"	
  esac
  done
	
      fi
      
      fi
      ;;
      3 )
      echo "Error"
      exit
     
     esac
  done  
  ;;
      * )
      echo "Error"
     exit
      ;;
      
    esac
  done   
fi 
      
      
      
      
      
      
      
      
      
      
      
      
      
      
