# input para: csv_file start_time end_time (sec)
export IFS=","

cnt=0;
total_energy=0;
prev_time=0;
curr_time=0;
prev_power=0;
curr_power=0;
cat $1 | (
while read a b c d; 
do 
   if [ $cnt -gt 0 ]; then 
      curr_time=$a; 
      curr_power=$c; 
      if [ $(echo "$curr_time > $2" | bc) -eq 1 ]; then 
         if [ $(echo "$curr_time <= $3" | bc) -eq 1 ]; then
            time_diff=$(echo "$curr_time - $prev_time" | bc);
            avg_power=$(echo "$curr_power + $prev_power" | bc); 
            curr_energy=$(echo "$avg_power * $time_diff" | bc);
            total_energy=$(echo "$total_energy + $curr_energy" | bc);
         else
            break;
         fi;
      fi    
      prev_time=$curr_time; 
      prev_power=$curr_power;
   fi; 
   cnt=$(( $cnt+1 )); 
   if [ $(($cnt % 1000)) -eq 0 ]; then
      echo "$a:$b:$c:$d";
   fi;
done
# avoid averaging in the loop for efficiency and use -l option for bc to load math library to do floating-point division
total_energy=$(echo "$total_energy / 2000" | bc -l);
echo "Total energy consumed: $total_energy joule";
)
