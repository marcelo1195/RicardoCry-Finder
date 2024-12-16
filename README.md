# RicardoCry-Finder
## Descrição
Este script foi desenvolvido como parte do LAB "Semana 03 - Scripting like a Pro (VPN)" do curso Novo Pentest Profissional da Desec Security. Ele permite:

1. Buscar por hosts ativos na rede utilizando uma varredura discreta.
2. Realizar o Port Knocking em hosts específicos ou em todos os hosts ativos.
3. Verificar a presença do malware "RicardoCry" em hosts através da porta 1337 usando curl.

O script utiliza ferramentas conhecidas como hping3, curl e nmap para realizar as operações.

**Funcionalidades**
  1. Buscar Hosts Ativos na Rede:
     - Realiza uma varredura utilizando o `nmap` em modo silencioso para listar todos os hosts ativos na rede.
  
  2. Realizar Port Knocking em um Host:
     - Envia pacotes SYN para as portas 13, 37, 30000, 3000, configurando o host para aceitar conexões na porta 1337.
  
  3. Realizar Port Knocking em Todos os Hosts Ativos:
     - Executa o Port Knocking em cada um dos hosts detectados na varredura.
  
  4. Verificar um Host Específico na Porta 1337:
     - Conecta à porta 1337 de um host e verifica se ele está infectado com o malware "RicardoCry".
  
  5. Verificar Todos os Hosts Ativos na Porta 1337:
     - Verifica todos os hosts ativos detectados na varredura para identificar a presença do malware.

**Requisitos**
Certifique-se de que as ferramentas abaixo estão instaladas:
- hping3
- curl
- nmap

**No terminal Linux, instale-as com:**
```sudo apt install hping3 curl nmap -y```

**Como Usar**
1. Clone ou copie o script para sua máquina.
2. Dê permissão de execução ao script:
   chmod +x malware_scan.sh
3. Execute o script com privilégios de superusuário:
   sudo ./malware_scan.sh

**Menu Principal**
Após executar o script, você verá o seguinte menu interativo:

--- Painel de Controle ---
1. Buscar hosts ativos na rede
2. Realizar Port Knocking em um host
3. Realizar Port Knocking em todos os hosts ativos
4. Verificar um host na porta 1337
5. Verificar todos os hosts ativos na porta 1337
0. Sair

Opção 1: Insira a rede alvo (exemplo: 192.168.1.0/24) para buscar hosts ativos.  
Opção 2: Insira o IP do host onde deseja realizar o Port Knocking.  
Opção 3: Executa o Port Knocking em todos os hosts encontrados na Opção 1.  
Opção 4: Insira o IP do host para verificar se está infectado na porta 1337.  
Opção 5: Verifica todos os hosts ativos na porta 1337.


**Validação**
Use ferramentas como Wireshark para monitorar os pacotes gerados pelo script:
- Para ICMP (Ping): Filtrar pacotes de busca por hosts:
  icmp
- Para Port Knocking (SYN): Filtrar pacotes enviados às portas configuradas:
  tcp.flags.syn == 1
- Para conexões na porta 1337: Filtrar conexões HTTP:
  tcp.port == 1337

Aviso
- Este script é apenas para fins educacionais.
- Certifique-se de ter autorização antes de realizar qualquer varredura ou Port Knocking em redes externas ou sistemas que não são seus.

Desenvolvido para o curso "Novo Pentest Profissional" da Desec Security.  
Semana 03 - Scripting like a Pro (VPN).

