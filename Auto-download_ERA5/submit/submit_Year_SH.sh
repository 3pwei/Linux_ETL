#!/bin/bash
source /etc/profile.d/modules.sh

begin_year=Year

file_path="Download_Path"$begin_year"/"

DIR="$(dirname "$(readlink -f "$0")")"

sed -i "s/YYYY/${begin_year}/g" $DIR/CDS_Download_Year.py

count=1

for idx2 in {192,202,213,223,233,244,254,264,274,284,294,305,315,325,335,345,355,366}

do
  if [ $(($begin_year%4)) -ne 0 ] && [ ${idx2} -gt  51 ]
  then
    idx=$(($idx2 - 1)) 
  else
    idx=$idx2
  fi
  start_date=$begin_year"0101"
  diff_days=$(expr $((($(date +%s)-$(date +%s -d $start_date))/86400)) + 1)
  if [ $count -eq 1 ]
  then
    P_DATE="ABCDEFGH"
  else
    P_DATE=$DATE
  fi
  DATE=$(date --date="$((-$diff_days+${idx})) day" +%Y%m%d)
  echo ${P_DATE}
  echo ${DATE}
  sed -i "s/${P_DATE}/${DATE}/g" $DIR/CDS_Download_Year.py
  python $DIR/CDS_Download_Year.py
  count=$(($count+1))
done

sed -i "s/${DATE}/ABCDEFGH/g" $DIR/CDS_Download_Year.py
sed -i "s/${begin_year}/YYYY/g" $DIR/CDS_Download_Year.py
