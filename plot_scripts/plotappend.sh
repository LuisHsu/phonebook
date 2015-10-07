#!/bin/bash

# Origin
echo "echo 1 > /proc/sys/vm/drop_caches" | sudo sh
perf stat -e cache-misses -o outp.txt ./phonebook_orig | grep execution | awk {'print $4 " " $6'} > outp2.txt
cat outp2.txt | grep append | awk {'print "1 " $2'} > outp3.txt

# Character index
echo "echo 1 > /proc/sys/vm/drop_caches" | sudo sh
perf stat -e cache-misses -o outp.txt ./phonebook_opt | grep execution | awk {'print $4 " " $6'} > outp2.txt
cat outp2.txt | grep append | awk {'print "2 " $2'} >> outp3.txt

# Hash index
echo "echo 1 > /proc/sys/vm/drop_caches" | sudo sh
perf stat -e cache-misses -o outp.txt ./phonebook_opt2 | grep execution | awk {'print $4 " " $6'} > outp2.txt
cat outp2.txt | grep append | awk {'print "3 " $2'} >> outp3.txt

gnuplot ./plot_scripts/plotAppend
rm outp*
