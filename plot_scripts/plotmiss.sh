#!/bin/bash

# Origin
echo "echo 1 > /proc/sys/vm/drop_caches" | sudo sh
perf stat -e cache-misses -o outp.txt ./phonebook_orig > outp2.txt
cat outp.txt | grep cache-misses | awk {'gsub(/,/,""); print "1 " $1'} > outp3.txt

# Character index
echo "echo 1 > /proc/sys/vm/drop_caches" | sudo sh
perf stat -e cache-misses -o outp.txt ./phonebook_opt > outp2.txt
cat outp.txt | grep cache-misses | awk {'gsub(/,/,""); print "2 " $1'} >> outp3.txt

# Hash index
echo "echo 1 > /proc/sys/vm/drop_caches" | sudo sh
perf stat -e cache-misses -o outp.txt ./phonebook_opt2 > outp2.txt
cat outp.txt | grep cache-misses | awk {'gsub(/,/,""); print "3 " $1'} >> outp3.txt

gnuplot ./plot_scripts/plotMisses
rm outp*
