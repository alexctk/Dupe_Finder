# Dupe_Finder
A bash script to find duplicate files

Usage:
  - compare_dirs: Run the script as ./filesizes.sh directory_1 directory_2
  - same_dir: run as ./filesizes.sh directory_1

Future plans:
  - Size tollerance alone can result in false positives, or false negatives. Need to consider other parameters
  - Implement a machine learning approach: use some similarity factor to compare images/frame of video
  - Needs to be optimized to improve running time
  - use bins with a certain size "width" to sort files more efficiently than comparisons
  - Complete the original goal of finding duplicate files under different names in the same directory