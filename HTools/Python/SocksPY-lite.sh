#!/bin/bash
#19/05/2020
#UPDATE 27/08/2022
clear
source <(curl -sSL https://www.dropbox.com/s/i32r4rvk9doay0x/module)
msg -bar
ADM_inst="/etc/adm-lite" && [[ ! -d ${ADM_inst} ]] && exit
system=$(cat -n /etc/issue |grep 1 |cut -d ' ' -f6,7,8 |sed 's/1//' |sed 's/      //')
vercion=$(echo $system|awk '{print $2}'|cut -d '.' -f1,2)
echo -e "ESPERE UN MOMENTO MIENTRAS FIXEAMOS SU SISTEMA "


fun_limpram() {
	sync
	echo 3 >/proc/sys/vm/drop_caches
	sync && sysctl -w vm.drop_caches=3
	sysctl -w vm.drop_caches=0
	swapoff -a
	swapon -a
apt purge python* -y &> /dev/null
sudo apt install software-properties-common -y &> /dev/null
apt install python2 -y &> /dev/null
sudo update-alternatives --install /usr/bin/python python /usr/bin/python2 1 &> /dev/null
	rm -rf /tmp/* > /dev/null 2>&1
	killall kswapd0 > /dev/null 2>&1
	killall tcpdump > /dev/null 2>&1
	killall ksoftirqd > /dev/null 2>&1
	rm -f /var/log/*
	echo > /etc/fixpython
}
function aguarde() {
	sleep .1

echo -e "SU VERSION DE UBUNTU ${vercion} ES SUPERIOR A 18.04 "
	helice() {
		fun_limpram >/dev/null 2>&1 &
		tput civis
		while [ -d /proc/$! ]; do
			for i in / - \\ \|; do
				sleep .1
				echo -ne "\e[1D$i"
			done
		done
		tput cnorm
	}
	echo -ne "\033[1;37m OPTIMIZANDO Y \033[1;32mFIXEANDO \033[1;37mPYTHON \033[1;32m.\033[1;32m.\033[1;33m.\033[1;31m. \033[1;33m"
	helice
	echo -e "\e[1DOk"
}


[[ "${vercion}" > "20" ]] && {
echo -e ""
msg -bar
[[ -e /etc/fixpython ]] || aguarde
} || {
echo -e "	SU VERSION DE UBUNTU ${vercion} ES INFERIOR O 18.04 "
	[[ -e /etc/fixpython ]] || { 
	apt install python -y &>/dev/null
	apt install python3 -y &>/dev/null
	}
}
sleep 1s && clear
mportas () {
unset portas
portas_var=$(lsof -V -i tcp -P -n | grep -v "ESTABLISHED" |grep -v "COMMAND" | grep "LISTEN")
while read port; do
var1=$(echo $port | awk '{print $1}') && var2=$(echo $port | awk '{print $9}' | awk -F ":" '{print $2}')
[[ "$(echo -e $portas|grep "$var1 $var2")" ]] || portas+="$var1 $var2\n"
done <<< "$portas_var"
i=1
echo -e "$portas"
}

stop_all () {
    ck_py=$(lsof -V -i tcp -P -n | grep -v "ESTABLISHED" |grep -v "COMMAND"|grep "python")

    if [[ -z $(echo "$ck_py" | awk '{print $1}' | head -n 1) ]]; then
        print_center -verm "Puertos PYTHON no encontrados"
        msg -bar
    else
        ck_port=$(echo "$ck_py" | awk '{print $9}' | awk -F ":" '{print $2}')
        for i in $ck_port; do
            systemctl stop python.${i} &>/dev/null
            systemctl disable python.${i} &>/dev/null
            rm /etc/systemd/system/python.${i}.service &>/dev/null
        done
        print_center -verd "Puertos PYTHON detenidos"
        msg -bar    
    fi
    sleep 3
 }

  stop_port () {
  sleep 2
    clear
    STPY=$(mportas | grep python | awk '{print $2}' )

    msg -bar
    print_center -ama "DETENER UN PUERTO"
    msg -bar

    n=1
    for i in $STPY; do
        echo -e " \033[1;32m[$n] \033[1;31m> \033[1;37m$i\033[0m"
        pypr[$n]=$i
        let n++ 
    done

    msg -bar
    echo -ne "$(msg -verd "  [0]") $(msg -verm2 ">") " && msg -bra "\033[1;41mVOLVER"
    msg -bar
    echo -ne "\033[1;37m opcion: " && read prpy
    tput cuu1 && tput dl1

    [[ $prpy = "0" ]] && return

    systemctl stop python.${pypr[$prpy]} &>/dev/null
    systemctl disable python.${pypr[$prpy]} &>/dev/null
    rm /etc/systemd/system/python.${pypr[$prpy]}.service &>/dev/null

    print_center -verd "PUERTO PYTHON ${pypr[$prpy]} detenido"
    msg -bar
    sleep 3
 }

colector(){
    clear
    msg -bar
    print_center -azu "Selecciona Puerto Principal, para Proxy"
    msg -bar

while [[ -z $porta_socket ]]; do
    echo -ne "\033[1;37m Digite el Puerto: " && read porta_socket
	porta_socket=$(echo ${porta_socket}|sed 's/[^0-9]//g')
    tput cuu1 && tput dl1

        [[ $(mportas|grep -w "${porta_socket}") = "" ]] && {
            echo -e "\033[1;33m Puerto python:\033[1;32m ${porta_socket} OK"
            msg -bar3
        } || {
            echo -e "\033[1;33m Puerto python:\033[1;31m ${porta_socket} FAIL" && sleep 1
            tput cuu1 && tput dl1
            unset porta_socket
        }
 done

 if [[ $1 = "PDirect" ]]; then

     print_center -azu " Puerto Local SSH/DROPBEAR/OPENVPN"
     msg -bar3

     while [[ -z $local ]]; do
        echo -ne "\033[1;97m Digite el Puerto: \033[0m" && read local
		local=$(echo ${local}|sed 's/[^0-9]//g')
        tput cuu1 && tput dl1

        [[ $(mportas|grep -w "${local}") = "" ]] && {
            echo -e "\033[1;33m Puerto local:\033[1;31m ${local} FAIL" && sleep 1
            tput cuu1 && tput dl1
            unset local
        } || {
            echo -e "\033[1;33m Puerto local:\033[1;32m ${local} OK"
            msg -bar3
        }
    done
	msg -bar3
echo -e " Respuesta de Encabezado (101,200,484,500,etc)  \033[1;37m" 
msg -bar3
     print_center -azu "Response personalizado (enter por defecto 200)"
     print_center -ama "NOTA : Para OVER WEBSOCKET escribe (101)"
     msg -bar3
     echo -ne "\033[1;97m ENCABEZADO : \033[0m" && read response
	 response=$(echo ${response}|sed 's/[^0-9]//g')
     tput cuu1 && tput dl1
     if [[ -z $response ]]; then
        response="200"
        echo -e "\033[1;33m   CABECERA :\033[1;32m ${response} OK"
    else
        echo -e "\033[1;33m   CABECERA :\033[1;32m ${response} OK"
    fi
    msg -bar3
 fi

    if [[ ! $1 = "PGet" ]] && [[ ! $1 = "POpen" ]]; then
        print_center -azu "Introdusca su Mini-Banner"
        msg -bar3
        print_center -azu "Introduzca un texto [NORMAL] o en [HTML]"
        echo -ne "-> : "
        read texto_soket
    fi

    if [[ $1 = "PPriv" ]]; then
        py="python3"
        IP=$(fun_ip)
    elif [[ $1 = "PGet" ]]; then
        echo "master=ChumoGH" > ${ADM_tmp}/pwd.pwd
        while read service; do
            [[ -z $service ]] && break
            echo "127.0.0.1:$(echo $service|cut -d' ' -f2)=$(echo $service|cut -d' ' -f1)" >> ${ADM_tmp}/pwd.pwd
        done <<< "$(mportas)"
         porta_bind="0.0.0.0:$porta_socket"
         pass_file="${ADM_tmp}/pwd.pwd"
         py="python"
    else
        py="python"
    fi
[[ -z ${texto_soket} ]] && texto_soket='<span style="color: #ff0000;"><strong><span style="color: #ff9900;">By</span>-<span style="color: #008000;">@ChumoGH</span>-ADM</strong></span>'

    [[ ! -z $porta_bind ]] && conf="-b $porta_bind "|| conf="-p $porta_socket "
    [[ ! -z $pass_file ]] && conf+="-p $pass_file"
    [[ ! -z $local ]] && conf+="-l $local "
    [[ ! -z $response ]] && conf+="-r $response "
    [[ ! -z $IP ]] && conf+="-i $IP "
    [[ ! -z $texto_soket ]] && conf+="-t '$texto_soket'"

echo -e "[Unit]
Description=$1 Service by @ChumoGH
After=network.target
StartLimitIntervalSec=0

[Service]
Type=simple
User=root
WorkingDirectory=/root
ExecStart=/usr/bin/$py ${ADM_inst}/$1.py $conf
Restart=always


[Install]
WantedBy=multi-user.target" > /etc/systemd/system/python.$porta_socket.service

    systemctl enable python.$porta_socket &>/dev/null
    systemctl start python.$porta_socket &>/dev/null

    if [[ $1 = "PGet" ]]; then
        [[ "$(ps x | grep "PGet.py" | grep -v "grep" | awk -F "pts" '{print $1}')" ]] && {
            print_center -verd "Gettunel Iniciado com Exito"
            print_center -azu   "Su Contraseña Gettunel es: $(msg -ama "ChumoGH")"
            msg -bar3
        } || {
            print_center -verm2 "Gettunel no fue iniciado"
            msg -bar3
        }
    fi
    msg -bar
    print_center -verd "PYTHON INICIADO CON EXITO!!!"
    msg -bar
    sleep 1
}

iniciarsocks () {
pidproxy=$(ps x | grep -w "PPub.py" | grep -v "grep" | awk -F "pts" '{print $1}') && [[ ! -z $pidproxy ]] && P1="\033[1;32m[ON]" || P1="\033[1;31m[OFF]"
pidproxy2=$(ps x | grep -w  "PPriv.py" | grep -v "grep" | awk -F "pts" '{print $1}') && [[ ! -z $pidproxy2 ]] && P2="\033[1;32m[ON]" || P2="\033[1;31m[OFF]"
pidproxy3=$(ps x | grep -w  "PDirect.py" | grep -v "grep" | awk -F "pts" '{print $1}') && [[ ! -z $pidproxy3 ]] && P3="\033[1;32m[ON]" || P3="\033[1;31m[OFF]"
pidproxy4=$(ps x | grep -w  "POpen.py" | grep -v "grep" | awk -F "pts" '{print $1}') && [[ ! -z $pidproxy4 ]] && P4="\033[1;32m[ON]" || P4="\033[1;31m[OFF]"
pidproxy5=$(ps x | grep "PGet.py" | grep -v "grep" | awk -F "pts" '{print $1}') && [[ ! -z $pidproxy5 ]] && P5="\033[1;32m[ON]" || P5="\033[1;31m[OFF]"
pidproxy6=$(ps x | grep "scktcheck" | grep -v "grep" | awk -F "pts" '{print $1}') && [[ ! -z $pidproxy6 ]] && P6="\033[1;32m[ON]" || P6="\033[1;31m[OFF]"
echo -e "\e[91m\e[43m  ==== SCRIPT MOD ChumoGH|EDICION ====  \033[0m \033[0;33m[$(less ${ADM_inst}/v-local.log)]"
msg -bar
echo -ne "$(msg -verd "  [1]") $(msg -verm2 ">") " && msg -azu "Socks Python SIMPLE      $P1"
echo -ne "$(msg -verd "  [2]") $(msg -verm2 ">") " && msg -azu "Socks Python SEGURO      $P2"
echo -ne "$(msg -verd "  [3]") $(msg -verm2 ">") " && msg -azu "Socks Python DIRETO      $P3"
echo -ne "$(msg -verd "  [4]") $(msg -verm2 ">") " && msg -azu "Socks Python OPENVPN     $P4"
echo -ne "$(msg -verd "  [5]") $(msg -verm2 ">") " && msg -azu "Socks Python GETTUNEL    $P5"
msg -bar

py=6
if [[ $(lsof -V -i tcp -P -n|grep -v "ESTABLISHED"|grep -v "COMMAND"|grep "python"|wc -l) -ge "2" ]]; then
    echo -e "$(msg -verd "  [6]") $(msg -verm2 ">") $(msg -azu "ANULAR TODOS") $(msg -verd "  [7]") $(msg -verm2 ">") $(msg -azu "ELIMINAR UN PUERTO")"
    py=7
else
    echo -e "$(msg -verd "  [6]") $(msg -verm2 ">") $(msg -azu "ELIMINAR TODOS")"
fi

msg -bar
echo -ne "$(msg -verd "  [0]") $(msg -verm2 ">") " && msg -bra "   \033[1;41m VOLVER \033[0m"
msg -bar

selection=$(selection_fun ${py})
case ${selection} in
    1)colector PPub;;
    2)colector PPriv;;
    3)colector PDirect;;
    4)colector POpen;;
    5)colector PGet;;
    6)stop_all;;
    7)stop_port;;
    0)return 1;;
esac
return 1
}
iniciarsocks
