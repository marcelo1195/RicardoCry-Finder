#!/bin/bash

# Variável global para armazenar hosts ativos
active_hosts=()

# Função para buscar hosts ativos na rede
scan_network() {
    local network=$1
    echo "Iniciando varredura na rede $network para buscar hosts ativos..."
    active_hosts=()
    for ip in $(nmap -sn "$network" | grep "Nmap scan report" | awk '{print $NF}'); do
        echo "Host ativo encontrado: $ip"
        active_hosts+=("$ip")
    done
    if [ ${#active_hosts[@]} -eq 0 ]; then
        echo "Nenhum host ativo encontrado na rede $network."
    fi
}

# Função para Port Knocking em um host específico
port_knocking() {
    local ip=$1
    local knocking_ports=(13 37 30000 3000)
    
    echo "Iniciando Port Knocking no host $ip..."
    for port in "${knocking_ports[@]}"; do
        echo "Enviando SYN para porta $port"
        hping3 -S -p $port -c 1 $ip >/dev/null 2>&1
    done
}

# Função para Port Knocking em todos os hosts ativos
port_knocking_all() {
    echo "Iniciando Port Knocking em todos os hosts ativos..."
    for ip in "${active_hosts[@]}"; do
        echo "Executando Port Knocking no host $ip..."
        port_knocking "$ip"
    done
    echo "Port Knocking concluído para todos os hosts ativos."
}

# Função para verificar o host na porta 1337
check_host() {
    local ip=$1
    local port=1337
    
    echo "Tentando verificar o host $ip na porta $port..."
    response=$(curl -s --max-time 3 http://$ip:$port)

    if [[ $response == *"RicardoCry"* ]]; then
        echo "###########-Malware detectado no host $ip!-###########"
    else
        echo "Nenhum malware detectado no host $ip."
    fi
}

# Função para verificar todos os hosts ativos na porta 1337
check_all_hosts() {
    echo "Verificando todos os hosts ativos na porta 1337..."
    for ip in "${active_hosts[@]}"; do
        check_host "$ip"
    done
}

# Menu principal
while true; do
    echo ""
    echo "--- Painel de Controle ---"
    echo "1. Buscar hosts ativos na rede"
    echo "2. Realizar Port Knocking em um host"
    echo "3. Realizar Port Knocking em todos os hosts ativos"
    echo "4. Verificar um host na porta 1337"
    echo "5. Verificar todos os hosts ativos na porta 1337"
    echo "0. Sair"
    echo ""
    read -rp "Escolha uma opção: " option

    case $option in
        1)
            # Varredura discreta para buscar hosts ativos
            read -rp "Digite a rede alvo (ex: 192.168.1.0/24): " network
            scan_network "$network"
            ;;
        2)
            # Realizar Port Knocking em um único host
            read -rp "Digite o endereço IP do host: " host_ip
            port_knocking "$host_ip"
            ;;
        3)
            # Realizar Port Knocking em todos os hosts ativos
            if [ ${#active_hosts[@]} -eq 0 ]; then
                echo "Nenhum host ativo encontrado. Execute a opção 1 para buscar hosts."
            else
                port_knocking_all
            fi
            ;;
        4)
            # Verificar um único host na porta 1337
            read -rp "Digite o endereço IP do host: " host_ip
            check_host "$host_ip"
            ;;
        5)
            # Verificar todos os hosts ativos na porta 1337
            if [ ${#active_hosts[@]} -eq 0 ]; then
                echo "Nenhum host ativo encontrado. Execute a opção 1 para buscar hosts."
            else
                check_all_hosts
            fi
            ;;
        0)
            echo "Saindo do script. Até mais!"
            break
            ;;
        *)
            echo "Opção inválida. Tente novamente."
            ;;
    esac
done
