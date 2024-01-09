select choice in Create_Database List_Database Drop_Database Connect_Database 
do 
case $REPLY in
1 ) ./createDb.sh
;;
2 ) ./listDb.sh
;;
3 ) ./dropDb.sh
;;
4 ) ./connectDb.sh
;;
* ) 
echo "Error"
break
;;
esac 
done

