Tcount=$(ls | wc -l)
count=1

for i in `ls`; do
    echo "$count) $i"
    count=$((count+1))
done

read -p "Enter the number of the table you want to drop: " num
no_table=$((num-1))
if [ $no_table -ge 0 -a $no_table -lt $Tcount ]; then
    no_table=$((num-1))
    tables=($(ls))
    rm "${tables[no_table]}"
    echo "Table dropped: ${tables[no_table]}"
else
    echo "Invalid input. Please enter a valid table number."
fi

