all: README.md

README.md: guessinggame.sh file1.txt file2.txt
	echo "# Peer-graded assignment: bash, make, git and github \n" > README.md
	echo "Date and time of make run: \c" >> README.md
	date >> README.md
	echo "\nthe number of lines in guessinggame.sh: \c" >> README.md
	wc -l guessinggame.sh | egrep -o "[0-9]+" >> README.md

file1.txt:
	echo "nothing in file1.txt"

file2.txt:
	echo "nothing in file2.txt"

clean:
	rm README.md
