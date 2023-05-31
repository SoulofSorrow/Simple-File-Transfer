#!/bin/bash
#Destination Host
HOSTSERVER=("litest:/home/test")
FILES=$(find "/home/test" -type f)

##Main
function main() {
    for TRANSHOST in "${HOSTSERVER[@]}"; do
        IP=$(echo "$TRANSHOST" | cut -d":" -f1)
        CHECK=$(pingfunction "$IP")
        echo "$CHECK"
        if [ "$CHECK" = true ]; then
            for ITEM in $FILES; do
                transfer=$(trans "$ITEM")
                if [ "$transfer" = true ]; then
                    local RETURN=OK
                    echo "$RETURN"
                fi
            done
        else
            echo "Pingfehler"
        fi
    done
    echo "$RETURN" "submain"
    submain "$RETURN"
}

##Submain
function submain() {
    if [ "$RETURN" = OK ]; then
        local RETURN=OK
        deletefile "$RETURN"
        echo "Fertig"
    else
        echo "Löschfehler!!!"
    fi
}

##Transfer
function trans() {
    CHECK=10
    while [ "$CHECK" -eq 10 ] || [ "$CHECK" -lt 20 ]; do
        scp "$1" "$TRANSHOST"
        if [ $? -eq 0 ]; then
            LOG=$(echo "$TRANSHOST" | cut -d":" -f1)
            local RETURN="true"
            echo "Transfer der Datei $1 auf den Zielhost $TRANSHOST erfolgreich" >> "/var/log/$LOG.txt"
            CHECK=$((CHECK + 10))
            echo "$RETURN"
        else
            LOG=$(echo "$TRANSHOST" | cut -d":" -f1)
            local RETURN="false"
            echo "Transfer der Datei $1 auf den Zielhost $TRANSHOST fehlgeschlagen" >> "/var/log/$LOG.txt"
            CHECK=$((CHECK + 1))
            sleep 5m
            echo "$RETURN"
        fi
    done
}

##PingCheck
function pingfunction() {
    if ping -c 1 -W 1 "$1" >/dev/null; then
        echo "PingCheck Erfolgreich" >> "/var/log/$1.txt"
        local RETURN="true"
        echo "$RETURN"
    else
        echo "PingCheck fehlgeschlagen" >> "/var/log/$1.txt"
        local RETURN="false"
        echo "$RETURN"
    fi
}

##Löschen
function deletefile() {
    if [ "$1" = OK ]; then
        for ITEM in $FILES; do
            rm "$ITEM"
        done
        echo "Alle Dateien wurden erfolgreich gelöscht"  >> "/var/log/$IP.txt"
    else
        echo "Löschen fehlgeschlagen" >> "/var/log/$IP.txt"
    fi
}

main
