#!/bin/bash

#
echo "Escaneando la red local:"
sudo arp-scan -l

# 
echo ""
echo "Ingrese una dirección IP para escanear (por ejemplo, 192.168.1.1)"
read -p "IP's a Escanear: " ip_address
echo ""
# 
if [[ ! $ip_address =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo ""
	echo "La dirección IP ingresada no es válida."
    exit 1
fi

# 
function check_ttl {
    local ip="$1"
	echo ""
    echo "===== TTL ====="
    ping -c 1 $ip | grep -oE "ttl=[0-9]{2,3}" | sed 's/ttl=//'
}

# OPTIONAL se puede quitar, ELEGIR scan_ports / ports_line NO eliminar ambos
function scan_ports {
    local ip="$1"
	echo ""
    echo "===== Escaneando Puertos ====="
    sudo nmap -sS -v --min-rate 6000 -p- $ip | grep -E "^[0-9]+\/[a-zA-Z]+\s+[a-zA-Z]+\s+[a-zA-Z]+" | sed 's/  */ /g' | cut -d ' ' -f 1,2,3,4
}

# OPTIONAL se puede quitar, ELEGIR scan_ports / ports_line NO eliminar ambos
function ports_line {
    local ip="$1"
	echo ""
    echo "===== Array de Puertos ====="
    sudo nmap -sS -v --min-rate 6000 -p- $ip | grep -Eo "^[0-9]{1,5}" | tr '\n' ','
}


# 
check_ttl "$ip_address"

# 
scan_ports "$ip_address"

# 
ports_line "$ip_address"

echo ""
echo ".     (◣_◢)                             							J'r0ulf"
echo "░░░░░███████ ]▄▄▄▄▄▄===========░ ░ ▒▓▓█ G07B"
echo "  ▂▄▅████████▅▄▃ ..............."
echo "███████████████████]>"
echo "◥⊙▲⊙▲⊙▲⊙▲⊙▲⊙▲⊙◤.."

echo ""

# 
echo ""
echo "Ingrese los puertos a escanear para la consulta adicional (por ejemplo, 135,139,445)"
echo ""
read -p "Ingrese los puertos a escanear: " additional_ports
echo ""

#
echo ""
echo "Ingrese el nombre del archivo de salida para la consulta adicional:"
echo ""
read -p "(　-_･) ︻デ═一         * (/❛o❛)/" output_file_name
echo ""

#
echo "===== Consulta de VULNERABILIDADES ====="
sudo nmap -sV --script vuln -v --min-rate 6000 -p $additional_ports $ip_address -oA "$output_file_name"
echos ""
echo "========================================================================================"
echo "Los resultados de la consulta de vulnerabilidades se han guardado en $output_file_name"
echo "========================================================================================"
echo ""

# 
echo "====================================="
echo "Convirtiendo el archivo XML a HTML..."
echo "====================================="
echo ""
xsltproc "$output_file_name.xml" -o "$output_file_name.html"
echo "========================================"
echo "La conversión se ha realizado con éxito."
echo "========================================"
echo ""
echo "░░░░░░░░"
echo "░░░░░░░░"
echo "░░HTML░░"
echo "░░░░░░░░"
echo "░░░░░░░░"
echo ""
# 
echo "===================================================="
echo "El archivo HTML generado es: $output_file_name.html"
echo ""
echo "........z Z z"
echo "(”)_(”)_.-””-.,"
echo "' _ _ '; -._, ')_"
echo "( o_, )' __) '-._)__"
echo ""

