#Setting Start Year and End Year
######################################################

export Download_Path="/lfs/home/whuang/ERA5/SM/"
declare -i Start_Year=2019
declare -i End_Year=2019

######################################################

export DIR="$(dirname "$(readlink -f "$0")")"

sed -i "s/Start_Year/${Start_Year}/g" $DIR/submit/Create_SFH_folder.sh
sed -i "s/End_Year/${End_Year}/g" $DIR/submit/Create_SFH_folder.sh

sed -i "s/Start_Year/${Start_Year}/g" $DIR/submit/Create_Folder_by_Year.sh
sed -i "s/End_Year/${End_Year}/g" $DIR/submit/Create_Folder_by_Year.sh

sed -i "s#Download_Path#${Download_Path}#g" $DIR/submit/submit_Year_FH.sh
sed -i "s#Download_Path#${Download_Path}#g" $DIR/submit/submit_Year_SH.sh
sed -i "s#PATH/YYYY/ABCDEFGH00.nc#${Download_Path}YYYY/ABCDEFGH00.nc#g" $DIR/CDS_Download_Year.py
sed -i "s#Download_Path#${Download_Path}#g" $DIR/submit/Create_Folder_by_Year.sh

sh submit/Create_SFH_folder.sh 
sh submit/Create_Folder_by_Year.sh

for i in $(eval echo "{$Start_Year..$End_Year}")
do
    rm $DIR/temp/$i/SH/nohup.out
    rm $DIR/temp/$i/FH/nohup.out
    nohup $DIR/temp/$i/FH/submit_${i}_FH.sh &> $DIR/temp/$i/FH/nohup.out &
    nohup $DIR/temp/$i/SH/submit_${i}_SH.sh &> $DIR/temp/$i/SH/nohup.out &
done

sed -i "s/${Start_Year}/Start_Year/g" $DIR/submit/Create_SFH_folder.sh
sed -i "s/${End_Year}/End_Year/g" $DIR/submit/Create_SFH_folder.sh

sed -i "s/${Start_Year}/Start_Year/g" $DIR/submit/Create_Folder_by_Year.sh
sed -i "s/${End_Year}/End_Year/g" $DIR/submit/Create_Folder_by_Year.sh

sed -i "s#${Download_Path}#Download_Path#g" $DIR/submit/submit_Year_FH.sh
sed -i "s#${Download_Path}#Download_Path#g" $DIR/submit/submit_Year_SH.sh
sed -i "s#${Download_Path}YYYY/ABCDEFGH00.nc#PATH/YYYY/ABCDEFGH00.nc#g" $DIR/CDS_Download_Year.py
sed -i "s#${Download_Path}#Download_Path#g" $DIR/submit/Create_Folder_by_Year.sh



