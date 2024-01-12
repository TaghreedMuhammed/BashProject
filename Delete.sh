PS3="Enter a Number to Delete or Exit :"
read -p "Enter the Table Name: " table_name

meta_table="${table_name}_meta"
info_table="${table_name}"
pk="${primary_key}"

if [ -f "$info_table" ] ; then

col_names=$(awk '{print $2}' "$meta_table")

select choice in "Delete All Data" "Delete Specific Row" "Return To Main Menu"
do
case $REPLY in
1 ) echo -n > "$info_table"
echo "All Data Has Been Deleted"
;;
2 )    read -p "Enter Primary Key : " val_del
                if grep -q "^${val_del}" "$info_table"; then
                    comm="/^${val_del}/d"
                    sed -i "$comm" "$info_table"
                    echo "The Row Has Been Deleted"
                else
                    echo "Primary Key is Not Found"
                fi
                ;;

3 ) exit 
;;
* )
echo "Invalid Choice"
;;
esac
done
else
echo "ERROR"
fi