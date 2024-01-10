table_menu () {
  PS3="Select Your Option: "
  options=("Create Table" "List Tables" "Drop Table" "Insert" "Select From Table" "Update From Table" "Delete")

  select choice in "${options[@]}"
  do
    case $REPLY in
      1 ) ../createtable.sh
      ;;
      2 ) ../listable.sh
      ;;
      3 ) ../droptable.sh
      ;;
      4 ) ../insertable.sh
      ;;
      5 ) echo "Select From Table"
      ;;
      6 ) echo "Update From Table"
      ;;
      7 ) echo "Delete"
      ;;
      *) echo "ERROR!!"
      break
      ;;
    esac

 
  done
}


read -p "Enter the name of Database to Connect: " name

if [ -z "$name" ]; then
  echo "Empty Name"
else
  name=$(echo "$name" | tr ' ' '_')

  if [[ $name =~ ^[0-9] ]]; then
    echo "Can't Found Name,It Begins With Numbers"
  elif [[ ! "$name" =~ ^[a-zA-Z0-9_]+$ ]]; then
    echo "Can't Found Name, It Contains Special Characters"
  elif [ -e "$name" ]; then
    echo "Successfully Connected to Database $name"
    cd ./"$name" 
    pwd
    table_menu
  else
  echo "Can't Found Name, Try Again "
  
  
    #dirs=("$name"/*)

   # if [ -n "${dirs[@]}" ]; then
     # selected_dir=""
    #  for dir in "${dirs[@]}"; do
        #if [ "$(basename "$dir")" == "$name" ]; then
        #  selected_dir="$dir"
         # break
      #  fi
    #  done

      #if [ -n "$selected_dir" ]; then
        #cd "$selected_dir" || exit
        #echo "Connected to Database $selected_dir"
        #table_menu
      #fi
   # fi
  fi
fi

