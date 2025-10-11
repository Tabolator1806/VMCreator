if [$# -ne 0];
then
    echo womp
else
    echo "Select a resource group to add machines"
    VMgroups=`az group list|grep '"name":*'|cut -d ":" -f 2`
    declare -i index=0
    for groupname in $VMgroups
    do
        echo "$index) $groupname"
        index+=1
    done
    echo "Or type a name for a new resource group: "
    read resourceGroup
    case $resourceGroup in
        "[0-9]") echo "`$VMgroups|cut -d "," -f $resourceGroup` has been chosen";;
        *) echo "$resourceGroup has been created";;
    esac
fi