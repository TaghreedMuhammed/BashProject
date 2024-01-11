
update_record() {
     data_table=$1
     meta_table=$2
     primary_key=$3
     column_name=$4
     new_value=$5

    if grep -q "^${primary_key}:" "${data_table}"; then
    
         column=$(awk -F: -v col="${column_name}" 'NR == 2 { for(i=1; i<=NF; i++) if ($i == col) print i }' "${meta_table}")

       
        awk -F: -v key="${primary_key}" -v indexx="${column}" -v val="${new_value}" 'BEGIN { OFS = ":" } $1 == key { $indexx = val } 1' "${data_table}" > "${data_table}.tmp" && mv "${data_table}.tmp" "${data_table}"
        echo "Record updated successfully."
    else
        echo "Record not found in the data table."
    fi
}

display_column_menu() {
     meta_table=$1

   
    columns=$(awk -F: 'NR == 2 { for(i=1; i<=NF; i++) print $i }' "${meta_table}")


    PS3="Select a column to update: "
    select column in ${columns}; do
        if [ -n "${column}" ]; then
            echo "${column}"
            break
        else
            echo "Invalid selection. Please try again."
        fi
    done
}


get_user_input() {
    read -p "Enter the data table name you want to update: " data_table
    meta_table="${data_table}_meta"  

 
    if [ -f "${data_table}" ] && [ -f "${meta_table}" ]; then
        read -p "Enter the primary key: " primary_key

     
        if grep -q "^${primary_key}:" "${data_table}"; then
            column_name=$(display_column_menu "${meta_table}")
            if [ -n "${column_name}" ]; then
                read -p "Enter the new value for column '${column_name}': " new_value
                update_record "${data_table}" "${meta_table}" "${primary_key}" "${column_name}" "${new_value}"
            else
                echo " No column selected."
            fi
        else
            echo " Primary key not found in the table."
        fi
    else
        echo "Data table or meta table not found."
    fi
}

table_menu() {
    echo "Available Tables"
    ls -p | grep -E -v '_meta$' | grep -v '/$'
}

get_user_input