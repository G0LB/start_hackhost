import os
import subprocess

# Escanear la red usando arp-scan
print("Escaneando la red local:")
os.system("sudo arp-scan -l")

# Solicitar al usuario que ingrese una dirección IP
ip_address = input("Ingrese una dirección IP para escanear (por ejemplo, 192.168.1.1): ")

# Verificar que se ingresó una dirección IP válida
if not ip_address.count(".") == 3 or not all(0 <= int(x) <= 255 for x in ip_address.split(".")):
    print("La dirección IP ingresada no es válida.")
    exit(1)

# Función para verificar el TTL de la dirección IP ingresada
def check_ttl(ip):
    print("===== TTL =====")
    result = subprocess.run(["ping", "-c", "1", ip], capture_output=True, text=True)
    ttl = result.stdout.split("ttl=")[1].split()[0]
    print(f"TTL: {ttl}")

    # Detectar el sistema operativo basado en el valor TTL
    os_detected = "Desconocido"
    if ttl == "64":
        os_detected = "Linux"
    elif ttl == "128":
        os_detected = "Windows"
    elif ttl == "255":
        os_detected = "Cisco"
    
    print(f"Sistema Operativo Detectado: {os_detected}")

# Función para escanear puertos de la dirección IP ingresada
def scan_ports(ip):
    print("===== Escaneando Puertos Open =====")
    result = subprocess.run(["sudo", "nmap", "-sS", "-v", "--min-rate", "6000", "-p-", ip], capture_output=True, text=True)
    open_ports = [line.split()[:4] for line in result.stdout.splitlines() if "open" in line]
    
    if open_ports:
        for port in open_ports:
            print(" ".join(port))
    else:
        print("No se encontraron puertos abiertos.")

# Función para escanear los puertos de la dirección IP ingresada e imprimir en línea
def ports_line(ip):
    print("===== Array de Puertos =====")
    result = subprocess.run(["sudo", "nmap", "-sS", "-v", "--min-rate", "6000", "-p-", ip], capture_output=True, text=True)
    open_ports = [line.split()[0] for line in result.stdout.splitlines() if "open" in line]
    
    if open_ports:
        print(",".join(open_ports))
    else:
        print("No se encontraron puertos abiertos.")

# Ejecutar la función para verificar el TTL de la dirección IP ingresada
check_ttl(ip_address)

# Ejecutar la función para escanear los puertos de la dirección IP ingresada
scan_ports(ip_address)

# Ejecutar la función para escanear los puertos de la dirección IP ingresada e imprimir en línea
ports_line(ip_address)

print("")
print(".     (◣_◢)")
print("░░░░░███████ ]▄▄▄▄▄▄===========░ ░ ▒▓▓█G07B")
print("  ▂▄▅████████▅▄▃ ...............")
print("███████████████████]>")
print("◥⊙▲⊙▲⊙▲⊙▲⊙▲⊙▲⊙◤..")

print("")

# Solicitar al usuario que ingrese los puertos a escanear para la consulta adicional
additional_ports = input("Ingrese los puertos a escanear para la consulta adicional (por ejemplo, 135,139,445): ")

# Solicitar al usuario el nombre del archivo de salida para la consulta adicional
output_file_name = input("Ingrese el nombre del archivo de salida para la consulta adicional: ")

# Ejecutar la consulta adicional de nmap con los puertos y el nombre del archivo de salida ingresados
print("===== Consulta de VULNERABILIDADES =====")
result = subprocess.run(["sudo", "nmap", "-sV", "--script", "vuln", "-v", "--min-rate", "6000", "-p", additional_ports, ip_address, "-oA", output_file_name], capture_output=True, text=True)
print(result.stdout)
print("=====================================")
print(f"Los resultados de la consulta de vulnerabilidades se han guardado en {output_file_name}")
print("=====================================")

# Convertir el archivo XML resultante a HTML
print("=====================================")
print("Convirtiendo el archivo XML a HTML...")
print("=====================================")
os.system(f"xsltproc {output_file_name}.xml -o {output_file_name}.html")
print("=====================================")
print("La conversión se ha realizado con éxito.")
print("=====================================")

# Imprimir el nombre del archivo HTML generado
print("=====================================")
print(f"El archivo HTML generado es: {output_file_name}.html")
print("=====================================")

