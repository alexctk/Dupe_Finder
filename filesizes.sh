#!/bin/bash



# look at all files in a given directory, add the results of du to list and print
function get_sizes(){
    file_size_array=()
    for file in "$dir1"/*; do
	echo $file
	#echo `du -k $file`
	file_size_array+=(`du -k "$file"`)
    done

    for size in "${file_size_array[@]}"; do
	echo "$size"
    done
}

function compare_dirs(){
    same_size_files=()
    files_in_dir1=()
    for file in "$dir1"/*; do
	#echo "$file"
	#echo `du -k "$file"`
	files_in_dir1+=(`du -k "$file"`)
    done

    # use nested loop to find sizes in directory 2
    # then for all sizes in directory 1, store the size that matches
    for file_d2 in "$dir2"/*; do
	file_size_and_path=`du -k "$file_d2"`
	file_size_d2=`du -k "$file_d2" | cut -f1`
	#echo `du -k "$file_d2"`
	#echo $file_size_d2
	for file_d1 in "$dir1"/*; do
	    #echo $file_d1
	    file_size_d1=`du -k "$file_d1" | cut -f1`
	    #echo  "$file_size_d2|$file_size_d1"
	    #echo  $file_size_d1
	    if [[ "$file_size_d2" == "$file_size_d1" ]]; then
		#echo condition met
		duplicate_sizes+=("$file_size_d2")
	    fi
	    
	done
    done

    # for all duplicated sizes, find the file path in both directories
    for size in "${duplicate_sizes[@]}"; do
	#echo "$(($size + 10))"
	#echo "$(($size - 10))"
	#need to define a range since du isn't exact
	tollerance="4"
	upper_limit="$(($size + $tollerance))"
	lower_limit="$(($size - $tollerance))"
	#echo $upper_limit
	#echo $lower_limit
	echo `find $dir2 -size -"$upper_limit"k -size +"$lower_limit"k`
	echo `find $dir1 -size -"$upper_limit"k -size +"$lower_limit"k`
    done
    
    
}
# main

# first argument is the file directory
# must have '*.jpg' at the end
dir1=$1
#echo $dir1
dir2=$2
#echo $dir2

# testing 
#filename='filesizes.sh'
# get estimate of file space usage (du) and the file name
#file_size_kb=`du -k "$filename"`
# print the variable contents
#echo "$file_size_kb"


#get_sizes
compare_dirs


