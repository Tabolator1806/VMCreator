if [$# -ne 0];
then
    echo womp
else
    echo "Select a resource group to add machines"
    VMgroups=`az group list|grep '"name":*'|cut -d ":" -f 2`
    declare -i index=1
    for groupname in $VMgroups
    do
        echo "$index) $groupname"
        index+=1
    done
    echo "Or type a name for a new resource group: "
    read resourceGroup
    case $resourceGroup in
        [0-$index])
            resourceGroupName=`cut -d '
' -f "$resourceGroup" <<< "$VMgroups"|cut -d ',' -f 1`
	    resourceGroup=$resourceGroupName;;
        *)
            az group create --location francecentral --resource-group $resourceGroup --only-show-errors
            echo "$resourceGroup has been created";;
    esac
    echo "$resourceGroup has been chosen"
fi
