#!/bin/bash

# arp-scan
echo "▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ Local Network Scan ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓"
sudo arp-scan -l

# IP
echo "▓▓▓▓▓▓▓▓ Enter One Of The IP Addresses to scan (For Example, 192.168.1.1): ▓▓▓▓▓▓▓▓"
echo ""
read -p "̿' ̿'\̵͇̿̿\з=(◣_◢)=ε/̵͇̿̿/'̿'̿ ̿ : " ip_address

#  IP ok
if [[ ! $ip_address =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "The Entered IP Address Is Not Valid."
    exit 1
fi

# IP
function check_ttl {
    local ip="$1"
    echo "▓▓▓▓▓▓▓▓ TTL ▓▓▓▓▓▓▓▓ :(　-_･) ︻デ═一                     *     "
    ttl=$(ping -c 1 $ip | grep -oE "ttl=[0-9]{2,3}" | sed 's/ttl=//')
    echo "   : $ttl :"
    echo "▓▓▓▓▓▓▓▓ SO ▓▓▓▓▓▓▓▓"
    
    # Detectar el sistema operativo basado en el valor TTL
    if [ "$ttl" -eq 64 ]; then
        os="Linux / macOS"
    elif [ "$ttl" -eq 32 ]; then
        os="Windows NT - less"    
    elif [ "$ttl" -eq 60 ]; then
        os="AIX / HP-UX"
    elif [ "$ttl" -eq 128 ]; then
        os="Windows"
    elif [ "$ttl" -eq 255 ]; then
        os="Cisco"
    else
        os="No Detallado"
    fi
    
    echo "----> : $os : <----"
    echo "============================="
}


# Función para escanear puertos de la dirección IP ingresada

function scan_ports {
    local ip="$1"
    echo "▓▓▓▓▓▓▓▓ Ports Scan ▓▓▓▓▓▓▓▓"
    open_ports=$(sudo nmap -sS -v --min-rate 6000 -p- $ip | grep -E "^[0-9]+\/[a-zA-Z]+\s+[a-zA-Z]+\s+[a-zA-Z]+" | sed 's/  */ /g' | cut -d ' ' -f 1,2,3,4)
    
    if [ -n "$open_ports" ]; then
        echo "$open_ports"
    else
        echo "No se encontraron puertos abiertos."
    fi
}

# Función para escanear e imprimir en lista los puertos abiertos

function ports_line {
    local ip="$1"
    echo "▓▓▓▓▓▓▓▓ Port Array's ▓▓▓▓▓▓▓▓"
    open_ports=$(sudo nmap -sS -v --min-rate 6000 -p- $ip | grep -Eo "^[0-9]{1,5}" | tr '\n' ',')
    
    if [ -n "$open_ports" ]; then
        echo "$open_ports"
    else
        echo "No se encontraron puertos abiertos."
    fi
}

# 
check_ttl "$ip_address"

# 
scan_ports "$ip_address"

# 
ports_line "$ip_address"
echo ""
echo ""
echo ".     (◣_◢)                            									J'r0ulf"
echo "░░░░░███████ ]▄▄▄▄▄▄=====================================░ ░ ▒▓▓█ G07B"
echo "  ▂▄▅████████▅▄▃ ..............."
echo "███████████████████]>"
echo "◥⊙▲⊙▲⊙▲⊙▲⊙▲⊙▲⊙◤.."
echo ""

# 
echo "▓▓▓▓▓▓▓▓ Enter Ports to Scan (For Example, 135,139,445) ▓▓▓▓▓▓▓▓"
echo ""
read -p "====> " additional_ports

#
echo "Enter The Name of The Output File: "
echo ""
read -p "FILE NAME: " output_file_name

#
echo "<(　-_･) ▄︻┻═┳一一                          *     (/❛o❛)/"
echo "▓▓▓▓▓▓▓▓▓▓ Analyzing Possible Vulnerabilities ▓▓▓▓▓▓▓▓▓▓"
echo ""
sudo nmap -sV --script vuln -v --min-rate 6000 -p $additional_ports $ip_address -oA "$output_file_name"
echo "The File Resulting From The Analysis Has The Name Of $output_file_name"

# 
echo "====================================="
echo "     Sharing File XML a HTML..."
echo "====================================="
echo "╔═══╗ ♪"
echo "║███║ ♫"
echo "║ (●) ♫"
echo "╚═══╝♪♪"
xsltproc "$output_file_name.xml" -o "$output_file_name.html"
echo "==============================================="
echo "The Convertion Has Been Completed Successfully."
echo "==============================================="
echo ""
echo "░░░░░░░░"
echo "░░░░░░░░"
echo "░░HTML░░"
echo "░░░░░░░░"
echo "░░░░░░░░"
echo ""
#
echo "░░░░░░░░ The Generated HTML File Is: $output_file_name.html "
echo ""
echo "........z Z z"
echo "(”)_(”)_.-””-.,"
echo "' _ _ '; -._, ')_"
echo "( o_, )' __) '-._)__"
