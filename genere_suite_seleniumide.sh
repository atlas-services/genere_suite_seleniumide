#!/bin/bash

#Set the project information

message="veuillez saisir le nom du projet"

while [ "$1" = "" ]
do
echo $message
exit
done

skeleton_base_suite_prefix="base_suite_prefix.side"
skeleton_base_unitaire="base_unitaire.side"
skeleton_base_suite_suffix="base_suite_suffix.side"
skeleton_base_suite="suite.side"

cd "$(dirname "$0")"
SCRIPT_DIR="$(pwd)"

### arguments recieved 
project=$1 

# set the template informations
skeleton_base="skeleton/$project/"

### create the directories
dir="$SCRIPT_DIR/$project/"

### target informations

prefix_newfile="test_unitaire"
target_join_suite="test_join_suite.side"
target_join_unitaire="test_join_unitaire.side"


cd $SCRIPT_DIR
mkdir $dir 2>/dev/null 1>/dev/null;

### get the datas from xlsx to csv file
libreoffice --headless --convert-to csv data/$project/data.xlsx --outdir data/$project/  2>/dev/null 1>/dev/null
filename="data/$project/data.csv"

# value to be replaced in templates
search_virgule="{{virgule}}"
search_test_id="{{test_id}}"

# value to be replaced in template suite
search_test_name="test_name"
search_test_suite="test_suite"
search_url_name="test_url"
search_uri_name="test_uri"


###count nb tests
count=$(grep -c ^ < "$filename") #get number of lines in particular file
last=$((count -1));

#Read each line of the file in each iteration
i=0;

### remove tests before creating new tests
rm -Rf "$dir/*"

slash="/"
replace_slash="\/"

while read data

do

let i++

export newfile="$prefix_newfile$i.side"
###export targetfile="$dir$newfile"
export targetfile="$dir$newfile"


cp $skeleton_base$skeleton_base_unitaire $targetfile

while IFS="," read -r url uri valeur1 valeur2 valeur3 valeur4 valeur5 valeur6 valeur7 valeur8 valeur9 valeur10 ;
 do
    uri=${uri//$slash/"$replace_slash"} 
    export url_test=$url 

    find $dir -name $newfile -type f -exec sed -i "s/valeur1/$valeur1/g" {} \;
    find $dir -name $newfile -type f -exec sed -i "s/valeur2/$valeur2/g" {} \;        
    find $dir -name $newfile -type f -exec sed -i "s/valeur3/$valeur3/g" {} \;
    find $dir -name $newfile -type f -exec sed -i "s/valeur4/$valeur4/g" {} \;        
    find $dir -name $newfile -type f -exec sed -i "s/valeur5/$valeur5/g" {} \;
    find $dir -name $newfile -type f -exec sed -i "s/valeur6/$valeur6/g" {} \;
    find $dir -name $newfile -type f -exec sed -i "s/valeur7/$valeur7/g" {} \;        
    find $dir -name $newfile -type f -exec sed -i "s/valeur8/$valeur8/g" {} \;
    find $dir -name $newfile -type f -exec sed -i "s/valeur9/$valeur9/g" {} \;        
    find $dir -name $newfile -type f -exec sed -i "s/valeur10/$valeur10/g" {} \;

    ## find and replace {{id}} and {{name}} from selenium file
    find $dir -name $newfile -type f -exec sed -i "s/$search_uri_name/$uri/g" {} \;


done <<< "$data"
find $dir -name $newfile -type f -exec sed -i "s/$search_test_id/a1a2a3a4-b1b2b3-c1c2c3-d1d2d3d4-e1e2e3e4e5$i/g" {} \;
find $dir -name $newfile -type f -exec sed -i "s/$search_test_name/test $i $url_test/g" {} \;
## find and replace {{virgule}} for each file except the last
if [ $i -lt $last ] 
then 
find $dir -name $newfile -type f -exec sed -i "s/$search_virgule/,/g" {} \;
else
find $dir -name $newfile -type f -exec sed -i "s/$search_virgule/ /g" {} \;
fi

### join contents of all newfile (targetFile) in one file
cat $targetfile >> $dir$target_join_unitaire

done < <(tail -n +2 $filename)

#add tests unit in one test suite
cat $skeleton_base$skeleton_base_suite_prefix >> $dir$skeleton_base_suite
cat $dir$target_join_unitaire >> $dir$skeleton_base_suite
cat $skeleton_base$skeleton_base_suite_suffix >> $dir$skeleton_base_suite

#replace url tests unit
find $dir -name $skeleton_base_suite -type f -exec sed -i "s/$search_test_suite/$url_test/g" {} \;
find $dir -name $skeleton_base_suite -type f -exec sed -i "s/$search_url_name/$url_test/g" {} \;

#remove temporary unitaire tests
cd $dir
rm -f *unitaire*.side
rm -f *join*.side

### everithing is ok!
echo "La suite de tests sélénium $skeleton_base_suite a été créée dans le répertoire $dir"


