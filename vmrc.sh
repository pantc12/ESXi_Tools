#!/bin/bash

function listvms(){
    hasuser=$(echo $1 | grep -c '@');
    hasport=$(echo $1 | grep -c ':');

    host=$(echo $1);
    user="";
    port="";

    if [ $hasuser -gt 0 ]; then
        u=1;
        user=$(echo $1 | awk -F@ '{print $1}')
        host=$(echo $host | awk -F@ '{print $2}')
    else
        u=0;
    fi

    if [ $hasport -gt 0 ]; then
        p=1;
        port=$(echo $1 | awk -F: '{print $2}')
        host=$(echo $host | awk -F: '{print $1}')
    else
        p=0;
    fi

    if [ $u -gt 0 ] && [ $p -gt 0 ]; then
        ssh -p $port $user@$host vim-cmd vmsvc/getallvms
    elif [ $u -gt 0 ]; then
        ssh $user@$host vim-cmd vmsvc/getallvms
    elif [ $p -gt 0 ]; then
        ssh -p $port $host vim-cmd vmsvc/getallvms
    else
        ssh $host vim-cmd vmsvc/getallvms
    fi
}

function connect(){
    hasuser=$(echo $1 | grep -c '@');
    hasport=$(echo $1 | grep -c ':');
    vmid=$2;

    host=$(echo $1);
    user="";
    port="";


    if [ $hasuser -gt 0 ]; then
        u=1;
        user=$(echo $1 | awk -F@ '{print $1}')
        host=$(echo $host | awk -F@ '{print $2}')
    else
        u=0;
    fi

    if [ $hasport -gt 0 ]; then
        p=1;
        port=$(echo $1 | awk -F: '{print $2}')
        host=$(echo $host | awk -F: '{print $1}')
    else
        p=0;
    fi

    if [ $u -gt 0 ] && [ $p -gt 0 ]; then
        open vmrc://$user@$host:$port/?moid=$vmid
    elif [ $u -gt 0 ]; then
        open vmrc://$user@$host/?moid=$vmid
    elif [ $p -gt 0 ]; then
        open vmrc://$host:$port/?moid=$vmid
    else
        open vmrc://$host/?moid=$vmid
    fi
}

case $1 in
    "list-vms"|"-l")
        listvms $2
        ;;
    "connect"|"-c")
        if [ -z "$3" ]; then
            echo "Usage: $0 [ connect | -c ] [user@]host[:port] vmid";
            exit 1;
        else
            connect $2 $3;
        fi
        ;;
    *)
        echo "Usage: $0 [ list-vms | -l ] [user@]host[:port]";
        echo "Usage: $0 [ connect | -c ] [user@]host[:port] vmid";
        ;;
esac

