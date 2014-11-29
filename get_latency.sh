# Compute latency result from test logs on Hoot, Instagram

new_test=0;
end=0;
start=1;
file=$(echo "tmp.$1");
cat $1 | grep ") \|TIME_" > $file;

while read line
do
     var1=$(echo $line | cut -d' ' -f1);
     var2=$(echo $var1 | grep ")");
     if [ ${#var2} -eq 0 ]; then
        var3=$(echo $line | grep "TIME_USER");
        if [ ${#var3} -eq 0 ]; then
           end=$(echo $line | cut -d' ' -f4);
        else
           start=$(echo $line | cut -d' ' -f4);
        fi
     else
        echo -n "$(( $end - $start )), ";
     fi
done < $file;

echo $(( $end - $start ));

