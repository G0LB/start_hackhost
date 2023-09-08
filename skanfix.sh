#!/bin/bash

# Escanear la red usando arp-scan
echo "▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ Local Network Scan ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓"
sudo arp-scan -l

# Solicitar al usuario que ingrese una dirección IP
echo "▓▓▓▓▓▓▓▓ Enter One Of The IP Addresses to scan (For Example, 192.168.1.1): ▓▓▓▓▓▓▓▓"
echo ""
read -p "̿' ̿'\̵͇̿̿\з=(◣_◢)=ε/̵͇̿̿/'̿'̿ ̿ : " ip_address

# Verificar que se ingresó una dirección IP válida
if [[ ! $ip_address =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "The Entered IP Address Is Not Valid."
    exit 1
fi

# Función para verificar el TTL de la dirección IP ingresada
function check_ttl {
    local ip="$1"
    echo "▓▓▓▓▓▓▓▓ TTL ▓▓▓▓▓▓▓▓ :(　-_･) ︻デ═一                     *     "
    ping -c 1 $ip | grep -oE "ttl=[0-9]{2,3}" | sed 's/ttl=//'
    echo ""
}

# Función para escanear puertos de la dirección IP ingresada
function scan_ports {
    local ip="$1"
    echo "▓▓▓▓▓▓▓▓ Ports Scan ▓▓▓▓▓▓▓▓"
    sudo nmap -sS -v --min-rate 6000 -p- $ip | grep -E "^[0-9]+\/[a-zA-Z]+\s+[a-zA-Z]+\s+[a-zA-Z]+" | sed 's/  */ /g' | cut -d ' ' -f 1,2,3,4
}

# Función para escanear e imprimir en lista los puertos abiertos
function ports_line {
    local ip="$1"
    echo ""
    echo "▓▓▓▓▓▓▓▓ Port Array's ▓▓▓▓▓▓▓▓"
    sudo nmap -sS -v --min-rate 6000 -p- $ip | grep -Eo "^[0-9]{1,5}" | tr '\n' ','
}


# Ejecutar la función para verificar el TTL de la dirección IP ingresada
check_ttl "$ip_address"

# Ejecutar la función para escanear los puertos de la dirección IP ingresada
scan_ports "$ip_address"

# Ejecutar la función para escanear los puertos de la dirección IP ingresada e imprime en linea
ports_line "$ip_address"
echo ""
echo ""
echo ".     (◣_◢)                            									J'r0ulf"
echo "░░░░░███████ ]▄▄▄▄▄▄=====================================░ ░ ▒▓▓█ G07B"
echo "  ▂▄▅████████▅▄▃ ..............."
echo "███████████████████]>"
echo "◥⊙▲⊙▲⊙▲⊙▲⊙▲⊙▲⊙◤.."
echo ""

# Solicitar al usuario que ingrese los puertos a escanear para la consulta adicional
echo "▓▓▓▓▓▓▓▓ Enter Ports to Scan (For Example, 135,139,445) ▓▓▓▓▓▓▓▓"
read -p "====> " additional_ports

# Solicitar al usuario el nombre del archivo de salida para la consulta adicional
echo "Enter The Name of The Output File: "
read -p "FILE NAME: " output_file_name

# Ejecutar la consulta adicional de nmap con los puertos y el nombre del archivo de salida ingresados
echo "<(　-_･) ▄︻┻═┳一一                          *     (/❛o❛)/"
echo "▓▓▓▓▓▓▓▓▓▓ Analyzing Possible Vulnerabilities ▓▓▓▓▓▓▓▓▓▓"
echo ""
sudo nmap -sV --script vuln -v --min-rate 6000 -p $additional_ports $ip_address -oA "$output_file_name"
echo "The File Resulting From The Analysis Has The Name Of $output_file_name"

# Convertir el archivo XML resultante a HTML
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
# Imprimir el nombre del archivo HTML generado
echo "░░░░░░░░ The Generated HTML File Is: $output_file_name.html "
echo ""
echo "........z Z z"
echo "(”)_(”)_.-””-.,"
echo "' _ _ '; -._, ')_"
echo "( o_, )' __) '-._)__"
