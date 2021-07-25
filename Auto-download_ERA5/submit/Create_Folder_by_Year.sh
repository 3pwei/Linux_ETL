Position="Download_Path"

for year in {Start_Year..Start_Year}
do
    echo $Position$year
    mkdir $Position$year
done

chmod 775 $Position*
