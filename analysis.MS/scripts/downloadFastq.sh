export repertory=$1

files=$(ls $repertory)
echo $files 
cd $repertory
chaine="gz"
see='nothing'

for file in $files;
do
	for line in $(<$file)
	do
		IFS='/' read a b c d e f<<< "$line"
	   	IFS='.' read g h i<<< "$f"
		if [ "$i" == "$chaine" ] && [ "$see" != "$line" ]
			then
			echo $i 
			wget $line
			see=$line

		fi
		
	done
done
