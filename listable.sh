count=$(ls | wc -l)
if [ $count -eq 0 ]; then
echo "No tables exist" 
else
for i in `ls`
do 
echo "$i"
done
fi

