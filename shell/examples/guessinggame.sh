#...we start the program asking for the number of files...
echo "how many files are in that folder?"
read n_test

#...we get the real number of files with that function...
function get_real_n_files {
	local n_real=$(ls -l | wc -l)
	let n_real=n_real-1
	echo $n_real
}
n=$(get_real_n_files)

#...while-loop to repeat action until user guess....
while [[ $n_test -ne $n ]]
do
	if [[ $n_test -gt $n && $n_test -ne $n ]]
	then
		echo "...too high..."
		echo "how many files are in that folder?"
		read n_test
	else
		if [[ $n_test -ne $n ]]
		then
			echo "...too low..."
			echo "how many files are in that folder?"
			read n_test
		fi
	fi
done

echo "congratulations!! you guess the number of files!!"
 
