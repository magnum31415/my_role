#!/bin/bash

# Set the threshold percentage
THRESHOLD=95

echo ""
echo "-------------------------------------------------------"
echo "Checking resources above THRESHOLD: ${THRESHOLD}%"
echo "-------------------------------------------------------"
echo ""

# ANSI color codes
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'  # No Color

# Check block usage (excluding memory filesystems like tmpfs, devtmpfs)
echo "Checking filesystem block usage..."
df -hP | grep -vE '^tmpfs|^devtmpfs' | awk 'NR>1 {print $5 " " $6}' | while read output;
do
  usage=$(echo $output | awk '{print $1}' | sed 's/%//')
  partition=$(echo $output | awk '{print $2}')

  if [ $usage -ge $THRESHOLD ]; then
    echo -e "${RED}WARNING: Filesystem $partition is at $usage% block usage!${NC}"
  else
    echo -e "${GREEN}OK: Filesystem $partition is at $usage% block usage.${NC}"
  fi
done
echo " ---- "

# Check inode usage (excluding memory filesystems like tmpfs, devtmpfs)
echo "Checking filesystem inode usage..."
df -hiP | grep -vE '^tmpfs|^devtmpfs|^shm' | awk 'NR>1 {print $5 " " $6}' | while read output;
do
  usage=$(echo $output | awk '{print $1}' | sed 's/%//')
  partition=$(echo $output | awk '{print $2}')

  if [ $usage -ge $THRESHOLD ]; then
    echo -e "${RED}WARNING: Filesystem $partition is at $usage% inode usage!${NC}"
  else
    echo -e "${GREEN}OK: Filesystem $partition is at $usage% inode usage.${NC}"
  fi
done

echo " ---- "

# Check CPU usage
echo  "Checking CPU usage..."
cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
cpu_usage=${cpu_usage%.*}  # Convert to integer for comparison

if [ $cpu_usage -ge $THRESHOLD ]; then
  echo -e "${RED}WARNING: CPU usage is at $cpu_usage%!${NC}"
else
  echo -e "${GREEN}OK: CPU usage is at $cpu_usage%.${NC}"
fi

echo " ---- "

# Check memory usage
echo  "Checking memory usage..."
memory_usage=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
memory_usage=${memory_usage%.*}  # Convert to integer for comparison

if [ $memory_usage -ge $THRESHOLD ]; then
  echo -e "${RED}WARNING: Memory usage is at $memory_usage%!${NC}"
else
  echo -e "${GREEN}OK: Memory usage is at $memory_usage%.${NC}"
fi


echo " ---- "

# Check swap usage
echo  "Checking swap usage..."
swap_usage=$(free | grep Swap | awk '{if ($2 > 0) print $3/$2 * 100.0; else print 0}')
swap_usage=${swap_usage%.*}  # Convert to integer for comparison

if [ $swap_usage -ge $THRESHOLD ]; then
  echo -e "${RED}WARNING: Swap usage is at $swap_usage%!${NC}"
else
  echo -e "${GREEN}OK: Swap usage is at $swap_usage%.${NC}"
fi

echo " ---- "