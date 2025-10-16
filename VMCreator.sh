#choosing group resource
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
	    resourceGroup=`cut --complement -c 2 <<< $resourceGroupName|rev|cut --complement -c 1|rev`;;
        *)
            az group create --location francecentral --resource-group $resourceGroup --only-show-errors
            echo "$resourceGroup has been created";;
    esac
    echo "$resourceGroup has been chosen"
#Choosing amount and type of machines
    echo "Amount of machines to be created: "
    read machineAmount
    echo "Select type of a machine:"
    printf "1)Windows \n2)Ubuntu\n3)Custom"
    read machineType
    case $machineType in
        1) machineType="Win2022AzureEditionCore";;
        2) machineType="Ubuntu2204";;
        3) echo "TBA";;
    esac
    echo "Input vm name: "
    read vmName
    echo "Input admin username:"
    read username
    echo "Input admin password:"
    read -s passwd
    for i in `seq 1 $machineAmount`
    do
        az vm create --resource-group $resourceGroup --name "$vmName$i" --image $machineType --admin-username $username --admin-password $passwd --size Standard_D2s_v3 --location francecentral
    done
