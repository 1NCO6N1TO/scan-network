#!/bin/bash

# Definir colores
rojo='\033[0;31m'
verde='\033[0;32m'
amarillo='\033[1;33m'
sin_color='\033[0m'

# Función para manejar la interrupción con Ctrl+C
function Ctrl_c() {
    echo -e "\n${rojo}[!] Saliendo...${sin_color}"
    tput cnorm
    exit 1
}

# Atrapar la señal de interrupción (Ctrl+C)
trap Ctrl_c INT

# Ocultar cursor
tput civis

# Verificar si se ha proporcionado una dirección IP como argumento
if [ $# -ne 1 ]; then
    echo -e "\n${verde}[+] Debes ingresar una dirección IP como argumento.${sin_color}\n"
    echo -e "${amarillo}Ejemplo: $0 192.168.0.2${sin_color}\n"
    tput cnorm
    exit 1
fi

# Función para validar la dirección IP
function ValidarIP() {
    local ip=$1
    local regex="^([0-9]{1,3}\.){3}[0-9]{1,3}$"

    if [[ $ip =~ $regex ]]; then
        # Validar que cada octeto esté en el rango de 0 a 255
        IFS='.' read -r -a octetos <<< "$ip"
        for octeto in "${octetos[@]}"; do
            if [[ $octeto -lt 0 ]] || [[ $octeto -gt 255 ]]; then
                echo -e "${rojo}[!] Error: El octeto $octeto no está en el rango de 0 y 255.${sin_color}"
                exit 1
            fi
        done
        return 0
    else
        return 1
    fi
}

# Validar la dirección IP proporcionada
if ValidarIP $1; then
    echo -e "\n${verde}[+] La dirección IP es válida. Procediendo con el escaneo...${sin_color}\n"
    IPmodificado=$(echo $1 | grep -oE '([0-9]{1,3}\.){3}')
    ultimo_octeto=$(echo $1 | grep -oE '[0-9]+$')
    conteo_hosts=$(mktemp)

    # Escanear la red
    for i in $(seq 1 254); do
        # Saltar el último octeto de la IP proporcionada
        if [ "$i" -eq "$ultimo_octeto" ]; then
            continue
        fi

        # Ping a cada host y verificar si está activo
        if timeout 1 bash -c "ping -c 1 $IPmodificado$i" &> /dev/null; then
            echo -e "${verde}[+] Host $IPmodificado$i - ACTIVO${sin_color}"
            echo "$IPmodificado$i" >> $conteo_hosts
        fi &
    done

    wait

    # Contar y mostrar los hosts activos encontrados
    hosts=$(wc -l < "$conteo_hosts" | tr -d ' ')
    rm $conteo_hosts

    if [ "$hosts" -eq 0 ]; then
        echo -e "${amarillo}[!] No se encontraron hosts activos.${sin_color}"
    fi

else
    echo -e "\n${rojo}[!] Error: La dirección IP no es válida.${sin_color}"
    tput cnorm
    exit 1
fi

# Restaurar el cursor
tput cnorm

