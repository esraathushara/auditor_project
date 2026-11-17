#!/bin/bash
source ./lib.sh
DIR=${1:-sample_data}
require_dir "$DIR"
log_info "program started"
scan_directory() {
local files=0
local dirs=0
for item in "$DIR"/*
do 
if [ -f "$item" ]
then
echo "[file] $item"
files=$((files+1))
elif [ -d "$item" ]
then 
echo "[dir ] $item"
dirs=$((dirs+1))

fi
done
echo "Files: $files"
echo "Directories: $dirs"
}
permission_audit() {
for item in "$DIR"/*
do
if [ -f "$item" ]
then
if [ -r "$item" ]
then 
echo "$item : readable"
else
echo "$item : not readable"
fi 
fi
done
}
extension_report() {
declare -A ext_count
for item in "$DIR"/*
do
if [ -f "$item" ]
then
ext="${item##*.}"
ext_count[$ext]=$((ext_count[$ext]+1))
fi 
done
for ext in "${!ext_count[@]}"
do
echo "$ext : ${ext_count[$ext]}"
done
}
search_file() {
read -p "enter filename: " name
for  item in "$DIR"/*
do
if [ -f "$item" ]
then
if [[ "$item" == *"$name"* ]]
then
echo "$item"
fi
fi
done
}
backup_all() {
mkdir -p backups
for item in "$DIR"/*
do
if [ -f "$item" ]
then
cp "$item" backups/
fi
done
echo "Backup completed"
}
list_backups() {
for file in backups/*
do
echo "$file"
done 
}
restore_backup() {
read -p "enter backup filename: " name
cp "backups/$name" "$DIR/restored_$name"
echo "restore completed"
}
show_menu() {
while true
do
echo "1. scan Directory"
echo "2. permission audit"
echo "3. extension report"
echo "4. search file"
echo "5. backup files"
echo "6. list backups"
echo "7. restore backup"
echo "8. exit"
read -p "choose: " choice
if [ "$choice" -eq 1 ]
then
scan_directory
elif  [ "$choice" -eq 2 ]
then
permission_audit

elif [ "$choice" -eq 3 ]
then
extension_report
elif [ "$choice" -eq 4  ]
then
search_file

elif [ "$choice" -eq 5 ]
then
backup_all
elif [ "$choice" -eq 6 ]
then
list_backups
elif [ "$choice" -eq 7 ]
then
restore_backup
else
echo "Goodbye"
fi
if [ "$choice" -eq 8 ]
then 
break
fi
done
}
show_menu

