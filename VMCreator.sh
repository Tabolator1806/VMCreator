if [$# -ne 0];
then
    echo womp
else
    VMgroups=`az group list|grep '"name":*'|cut -d ":" -f 2`
    for groupname in $VMgroups
    do
        echo $groupname
    done
fi