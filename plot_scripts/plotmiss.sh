#!/bin/bash
echo "echo 1 > /proc/sys/vm/drop_caches" | sudo sh
perf stat -e cache-misses -o outp.txt ./phonebook_orig | grep execution | awk {'print $6'} > outp2.txt
cat outp.txt | grep cache-misses | awk {'gsub(/,/,""); print "1 " $1'} > outp3.txt
echo "echo 1 > /proc/sys/vm/drop_caches" | sudo sh
perf stat -e cache-misses -o outp.txt ./phonebook_opt | grep execution | awk {'print $6'} > outp2.txt
cat outp.txt | grep cache-misses | awk {'gsub(/,/,""); print "2 " $1'} >> outp3.txt
gnuplot ./plot_scripts/plotMisses
rm outp*
