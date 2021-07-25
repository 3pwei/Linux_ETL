
#DIR="$(dirname "$(readlink -f "$0")")"

for i in {Start_Year..Start_Year}
do
    mkdir $DIR/temp/$i
    mkdir $DIR/temp/$i/SH/
    mkdir $DIR/temp/$i/FH/
    cp $DIR/CDS_Download_Year.py $DIR/temp/$i/FH/CDS_Download_${i}.py
    cp $DIR/CDS_Download_Year.py $DIR/temp/$i/SH/CDS_Download_${i}.py
    cp $DIR/submit/submit_Year_FH.sh $DIR/temp/$i/FH/submit_${i}_FH.sh
    cp $DIR/submit/submit_Year_SH.sh $DIR/temp/$i/SH/submit_${i}_SH.sh
    sed -i "s/Year/$i/g" $DIR/temp/$i/FH/submit_${i}_FH.sh
    sed -i "s/Year/$i/g" $DIR/temp/$i/SH/submit_${i}_SH.sh
done
