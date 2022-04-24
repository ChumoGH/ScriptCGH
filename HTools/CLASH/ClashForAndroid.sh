clear&&clear
fun_ip () {
MEU_IP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
MEU_IP2=$(wget -qO- ipv4.icanhazip.com)
[[ "$MEU_IP" != "$MEU_IP2" ]] && IP="$MEU_IP2" || IP="$MEU_IP"
trojanport=`lsof -V -i tcp -P -n | grep -v "ESTABLISHED" |grep -v "COMMAND" | grep "LISTEN" | grep trojan | awk '{print substr($9,3); }' > /tmp/trojan.txt && echo | cat /tmp/trojan.txt | tr '\n' ' ' > /etc/ADMcgh/trojanports.txt && cat /etc/ADMcgh/trojanports.txt`;
troport=$(cat /etc/ADMcgh/trojanports.txt  | sed 's/\s\+/,/g' | cut -d , -f1)
portFTP=$(lsof -V -i tcp -P -n | grep apache2 | grep -v "ESTABLISHED" |grep -v "COMMAND" | grep "LISTEN" | cut -d: -f2 | cut -d' ' -f1 | uniq)
portFTP=$(echo ${portFTP} | sed 's/\s\+/,/g' | cut -d , -f1)
}
#FUN_BAR
fun_bar () { 
comando="$1"  
_=$( $comando > /dev/null 2>&1 ) & > /dev/null 
pid=$! 
while [[ -d /proc/$pid ]]; do 
echo -ne " \033[1;33m["    
for((i=0; i<20; i++)); do    
echo -ne "\033[1;31m##"    
sleep 0.5    
done 
echo -ne "\033[1;33m]" 
sleep 1s 
echo tput cuu1 tput dl1 
done 
echo -e " \033[1;33m[\033[1;31m########################################\033[1;33m] - \033[1;32m100%\033[0m" 
sleep 1s 
} 

install_ini () {
add-apt-repository universe
apt update -y; apt upgrade -y
clear
msg -bar3
echo -e "\033[92m        -- INSTALANDO PAQUETES NECESARIOS -- "
msg -bar3
#bc
[[ $(dpkg --get-selections|grep -w "golang-go"|head -1) ]] || apt-get install golang-go -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "golang-go"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "golang-go"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install golang-go............ $ESTATUS "
#jq
[[ $(dpkg --get-selections|grep -w "jq"|head -1) ]] || apt-get install jq -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "jq"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "jq"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install jq................... $ESTATUS "
#curl
[[ $(dpkg --get-selections|grep -w "curl"|head -1) ]] || apt-get install curl -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "curl"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "curl"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install curl................. $ESTATUS "
#npm
[[ $(dpkg --get-selections|grep -w "npm"|head -1) ]] || apt-get install npm -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "npm"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "npm"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install npm.................. $ESTATUS "
#nodejs
[[ $(dpkg --get-selections|grep -w "nodejs"|head -1) ]] || apt-get install nodejs -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "nodejs"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "nodejs"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install nodejs............... $ESTATUS "
#socat
[[ $(dpkg --get-selections|grep -w "socat"|head -1) ]] || apt-get install socat -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "socat"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "socat"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install socat................ $ESTATUS "
#netcat
[[ $(dpkg --get-selections|grep -w "netcat"|head -1) ]] || apt-get install netcat -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "netcat"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "netcat"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install netcat............... $ESTATUS "
#net-tools
[[ $(dpkg --get-selections|grep -w "net-tools"|head -1) ]] || apt-get net-tools -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "net-tools"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "net-tools"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install net-tools............ $ESTATUS "
#figlet
[[ $(dpkg --get-selections|grep -w "figlet"|head -1) ]] || apt-get install figlet -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "figlet"|head -1) ]] || ESTATUS=`echo -e "\033[91mFALLO DE INSTALACION"` &>/dev/null
[[ $(dpkg --get-selections|grep -w "figlet"|head -1) ]] && ESTATUS=`echo -e "\033[92mINSTALADO"` &>/dev/null
echo -e "\033[97m  # apt-get install figlet............... $ESTATUS "
msg -bar3
echo -e "\033[92m La instalacion de paquetes necesarios a finalizado"
msg -bar3
echo -e "\033[97m Si la instalacion de paquetes tiene fallas"
echo -ne "\033[97m Puede intentar de nuevo [s/n]: "
read inst
[[ $inst = @(s|S|y|Y) ]] && install_ini
echo -ne "\033[97m Deseas agregar Menu Clash Rapido [s/n]: "
read insta
[[ $insta = @(s|S|y|Y) ]] && enttrada
}


fun_insta(){
fun_ip
install_ini
msg -bar3
killall clash 1> /dev/null 2> /dev/null
echo -e " ➣ Creando Directorios y Archivos"
msg -bar3 
[[ -d /root/.config ]] && rm -rf /root/.config/* || mkdir /root/.config 
mkdir /root/.config/clash 1> /dev/null 2> /dev/null
last_version=$(curl -Ls "https://api.github.com/repos/Dreamacro/clash/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
arch=$(arch)
if [[ $arch == "x86_64" || $arch == "x64" || $arch == "amd64" ]]; then
  arch="amd64"
elif [[ $arch == "aarch64" || $arch == "arm64" ]]; then
  arch="arm64"
else
  arch="amd64"
fi
wget -N --no-check-certificate -O /root/.config/clash/clash.gz https://github.com/Dreamacro/clash/releases/download/${last_version}/clash-linux-${arch}-${last_version}.gz
gzip -d /root/.config/clash/clash.gz
chmod +x /root/.config/clash/clash
echo -e " ➣ Clonando Repositorio Original Dreamacro "
go get -u -v github.com/Dreamacro/clash
clear
}



[[ -e /bin/ejecutar/msg ]] && source /bin/ejecutar/msg || source <(curl -sSL https://raw.githubusercontent.com/ChumoGH/ChumoGH-Script/master/msg-bar/msg)
numero='^[0-9]+$'
hora=$(printf '%(%H:%M:%S)T') 
fecha=$(printf '%(%D)T')
[[ ! -d /bin/ejecutar/clashFiles ]] && mkdir /bin/ejecutar/clashFiles
clashFiles='/bin/ejecutar/clashFiles/'

INITClash(){
conFIN
read -p "Ingrese Nombre del Poster WEB de la configuracion: " cocolon
cp /root/.config/clash/config.yaml /var/www/html/$cocolon.yaml && chmod +x /var/www/html/$cocolon.yaml
service apache2 restart
echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
echo -e "\033[1;33mClash Server Instalado"
echo -e "-------------------------------------------------------"
echo -e "		\033[4;31mNOTA importante\033[0m"
echo -e "Recuerda Descargar el Fichero, o cargarlo como URL!!"
echo -e "-------------------------------------------------------"
echo -e " \033[0;31mSi Usas Clash For Android, Ultima Version  "
echo -e "  Para luego usar el Link del Fichero, y puedas ."
echo -e " Descargarlo desde cualquier sitio con acceso WEB"
echo -e "        Link Clash Valido por 30 minutos "
echo -e "    Link : \033[1;42m  http://$IP:${portFTP}/$cocolon.yaml\033[0m"
echo -e "-------------------------------------------------------"
#read -p "PRESIONA ENTER PARA CARGAR ONLINE"
echo -e "\033[1;32mRuta de Configuracion: /root/.config/clash/config.yaml"
echo -e "\033[1;31mPRESIONE ENTER PARA CONTINUAR\033[0m"
scr=$(echo $(($RANDOM*3))|head -c 3)
unset yesno
echo -e " Deseas Poner Actividad de 30 Minutos " 
while [[ ${yesno} != @(s|S|y|Y|n|N) ]]; do
read -p "[S/N]: " yesno
tput cuu1 && tput dl1
done
[[ ${yesno} = @(s|S|y|Y) ]] &&  { 
killall clash > /dev/null &1>&2
screen -dmS clashse_$cocolon /root/.config/clash/clash
echo '#!/bin/bash -e' > /root/.config/clash/$cocolon.sh
echo "sleep 1800s" >> /root/.config/clash/$cocolon.sh && echo -e " ACTIVO POR 30 MINUTOS "  || echo " Validacion Incorrecta "
echo "mv /var/www/html/$cocolon.yaml ${clashFiles}$cocolon.yaml" >> /root/.config/clash/$cocolon.sh
echo 'echo "Fichero removido a ${clashFiles}$cocolon.yaml"' >> /root/.config/clash/$cocolon.sh
echo "service apache2 restart" >> /root/.config/clash/$cocolon.sh
echo "rm -f /root/.config/clash/$cocolon.sh" >> /root/.config/clash/$cocolon.sh
echo 'exit' >> /root/.config/clash/$cocolon.sh && screen -dmS clash${scr} bash /root/.config/clash/$cocolon.sh
} 
echo -e "Proceso Finalizado"

}

configINIT () {
unset tropass
echo 'port: 8080
socks-port: 7891
redir-port: 7892
allow-lan: true
bind-address: "*"
mode: rule
log-level: info
external-controller: +0.0.0.0:9090+
secret: ++
#dns:
#  enable: true
#  listen: 1.1.1.1:53
#default-nameserver:
#    - 1.0.0.1
#    - 1.1.1.1    
proxy-groups:
- name: "ChumoGH-ADM"
  type: select
  proxies:    ' > /root/.config/clash/config.yaml
sed -i "s/+/'/g"  /root/.config/clash/config.yaml
ConfTrojINI
unset yesno
ConfV2RINI
}

proxyTRO() {
fun_ip
echo -e "    - $1" >> /root/.config/clash/config.yaml
proTRO+="- name: $1\n  type: trojan\n  server: ${IP}\n  port: ${troport}\n  password: $2\n  udp: true\n  sni: $3\n  alpn:\n  - h2\n  - http/1.1\n  skip-cert-verify: true\n\n" 
  }

ConfTrojINI() {
echo -e " DESEAS AÑADIR TU ${foc} CONFIG TROJAN " 
while [[ ${yesno} != @(s|S|y|Y|n|N) ]]; do
read -p "[S/N]: " yesno

tput cuu1 && tput dl1
done
[[ ${yesno} = @(s|S|y|Y) ]] &&  { 
unset yesno
foc=$(($foc + 1))
echo -ne "\033[1;33m ➣ PERFIL TROJAN CLASH "
read -p ": " nameperfil
msg -bar3
[[ -z ${tropass} ]] && view_usert || { 
echo -e " USER ${tropass}"
msg -bar3
}
echo -ne "\033[1;33m ➣ SNI o HOST "
read -p ": " trosni
msg -bar3
proxyTRO ${nameperfil} ${tropass} ${trosni}
ConfTrojINI
								}
}

proxyV2R() {
#proxyV2R ${nameperfil} ${trosni} ${uid} ${aluuiid} ${net} ${parche} ${v2port}
fun_ip
echo -e "    - $1" >> /root/.config/clash/config.yaml
proV2R+="- name: $1\n  type: vmess\n  server: ${IP}\n  port: $7\n  uuid: $3\n  alterId: $4\n  cipher: auto\n  udp: true\n  tls: true\n  skip-cert-verify: true\n  network: $5\n  ws-path: $6\n  ws-headers: {Host: $2}\n  \n\n" 
  }
  
proxyV2Rgprc() {
#config=/usr/local/x-ui/bin/config.json
#cat $config | jq .inbounds[].settings.clients | grep id
#proxyV2R ${nameperfil} ${trosni} ${uid} ${aluuiid} ${net} ${parche} ${v2port}
fun_ip
echo -e "    - $1" >> /root/.config/clash/config.yaml
proV2Rgrpc+="- name: $1\n  type: vmess\n  server: ${IP}\n  port: $7\n  uuid: $3\n  alterId: $4\n  cipher: auto\n  network: grpc\n  udp: true\n  tls: true\n  servername: $2\n  skip-cert-verify: true\n  grpc-opts: \n    grpc-service-name: ""\n  \n\n" 
proV2Rgrpc+="- name: vmess-grpc
    server: server
    port: 443
    type: vmess
    uuid: uuid
    alterId: 32
    cipher: auto
    network: grpc
    tls: true
    servername: example.com
    # skip-cert-verify: true
    grpc-opts:
      grpc-service-name: "example""
  }

ConfV2RINI() {
unset foc
echo -e " DESEAS AÑADIR TU ${foc} CONFIG V2RAY " 
while [[ ${yesno} != @(s|S|y|Y|n|N) ]]; do
read -p "[S/N]: " yesno
tput cuu1 && tput dl1
done
[[ ${yesno} = @(s|S|y|Y) ]] &&  { 
unset yesno
foc=$(($foc + 1))
echo -ne "\033[1;33m ➣ PERFIL V2RAY CLASH "
read -p ": " nameperfil
msg -bar3
[[ -z ${uid} ]] && view_user || { 
echo -e " USER ${ps}"
msg -bar3
}
echo -ne "\033[1;33m ➣ SNI o HOST "
read -p ": " trosni
msg -bar3
proxyV2R ${nameperfil} ${trosni} ${uid} ${aluuiid} ${net} ${parche} ${v2port}
ConfV2RINI
								}
}

confRULE() {
echo -e '
  url: http://www.gstatic.com/generate_204
  interval: 300
 
###################################
# ChumoGH-ADM

# By ChumoGH By CGH
- name: "【 ✵ 𝚂𝚎𝚛𝚟𝚎𝚛-𝙿𝚁𝙴𝙼𝙸𝚄𝙼 ✵ 】"
  type: select
  proxies: 
    - "ChumoGH-ADM"

- name: "【 📱 +593987072611 】"
  type: select
  proxies:
    - "ChumoGH-ADM"

rules:
- DOMAIN-SUFFIX,local,ChumoGH-ADM
- DOMAIN-SUFFIX,google.com,ChumoGH-ADM
- DOMAIN-KEYWORD,google,ChumoGH-ADM
- DOMAIN,google.com,ChumoGH-ADM
- DOMAIN-SUFFIX,ad.com,ChumoGH-ADM
- SRC-IP-CIDR,192.168.1.201/32,ChumoGH-ADM
- IP-CIDR,127.0.0.0/8,ChumoGH-ADM
- GEOIP,IR,ChumoGH-ADM
- DST-PORT,80,ChumoGH-ADM
- SRC-PORT,7777,ChumoGH-ADM
- MATCH, ChumoGH-ADM

proxies:' >> /root/.config/clash/config.yaml
}

conFIN() {
confRULE
[[ ! -z ${proTRO} ]] && echo -e "${proTRO}" >> /root/.config/clash/config.yaml
[[ ! -z ${proV2R} ]] && echo -e "${proV2R}" >> /root/.config/clash/config.yaml

#echo ''

echo "#POWER BY @ChumoGH" >> /root/.config/clash/config.yaml
}

enon(){
echo 'source <(curl -sSL https://raw.githubusercontent.com/ChumoGH/ScriptCGH/main/HTools/CLASH/ClashForAndroid.sh)' > /bin/clash.sh && chmod +x /bin/clash.sh
		clear
		msg -bar3
		blanco " Se ha agregado un autoejecutor en el Sector de Inicios Rapidos"
		msg -bar3
		blanco "	  Para Acceder al menu Rapido \n	     Utilize * clash.sh * !!!"
		msg -bar3
		echo -e "		\033[4;31mNOTA importante\033[0m"
		echo -e " \033[0;31mSi deseas desabilitar esta opcion, apagala"
		echo -e " Y te recomiendo, no alterar nada en este menu, para"
		echo -e "             Evitar Errores Futuros"
		echo -e " y causar problemas en futuras instalaciones.\033[0m"
		msg -bar3
		continuar
		read foo
}
enoff(){
rm -f /bin/clash.sh
		msg -bar3
		echo -e "		\033[4;31mNOTA importante\033[0m"
		echo -e " \033[0;31mSe ha Desabilitado el menu Rapido de clash.sh"
		echo -e " Y te recomiendo, no alterar nada en este menu, para"
		echo -e "             Evitar Errores Futuros"
		echo -e " y causar problemas en futuras instalaciones.\033[0m"
		msg -bar3
		continuar
		read foo
}

enttrada () {

	while :
	do
	clear
	msg -bar3
	blanco "	  Ajustes e Entrasda Rapida de Menu CLash"
	msg -bar3
	col "1)" "Habilitar clash, Como entrada Rapida"
	col "2)" "Eliminar clash, Como entrada Rapida"
	msg -bar3
	col "0)" "Volver"
	msg -bar3
	blanco "opcion" 0
	read opcion

	[[ -z $opcion ]] && vacio && sleep 3 && break
	[[ $opcion = 0 ]] && break

	case $opcion in
		1)enon;;
		2)enoff;;
		*) blanco " solo numeros de 0 a 2" && sleep 0.3s;;
	esac
    done

}
blanco(){
	[[ !  $2 = 0 ]] && {
		echo -e "\033[1;37m$1\033[0m"
	} || {
		echo -ne " \033[1;37m$1:\033[0m "
	}
}
title(){
	msg -bar3
	blanco "$1"
	msg -bar3
}
col(){
	nom=$(printf '%-55s' "\033[0;92m${1} \033[0;31m>> \033[1;37m${2}")
	echo -e "	$nom\033[0;31m${3}   \033[0;92m${4}\033[0m"
}
col2(){
	echo -e " \033[1;91m$1\033[0m \033[1;37m$2\033[0m"
}
vacio(){
blanco "\n no se puede ingresar campos vacios..."
}
cancelar(){
echo -e "\n \033[3;49;31minstalacion cancelada...\033[0m"
}
continuar(){
echo -e " \033[3;49;32mEnter para continuar...\033[0m"
}
userDat(){
	blanco "	NÂ°    Usuarios 		  fech exp   dias"
	msg -bar3
}
view_usert(){
configt="/usr/local/etc/trojan/config.json"
tempt="/etc/trojan/temp.json"
trojdirt="/etc/trojan" 
user_conft="/etc/trojan/user"
backdirt="/etc/trojan/back" 
tmpdirt="$backdir/tmp"
trojanport=`lsof -V -i tcp -P -n | grep -v "ESTABLISHED" |grep -v "COMMAND" | grep "LISTEN" | grep trojan | awk '{print substr($9,3); }' > /tmp/trojan.txt && echo | cat /tmp/trojan.txt | tr '\n' ' ' > /etc/ADMcgh/trojanports.txt && cat /etc/ADMcgh/trojanports.txt`;
troport=$(cat /etc/ADMcgh/trojanports.txt  | sed 's/\s\+/,/g' | cut -d , -f1)
	unset seg
	seg=$(date +%s)
	while :
	do
	nick="$(cat $configt | grep ',"')"
	users="$(echo $nick|sed -e 's/[^a-z0-9 -]//ig')"
		title "	ESCOJE USUARIO TROJAN"
		userDat

		n=1
		for i in $users
		do
			unset DateExp
			unset seg_exp
			unset exp

			[[ $i = "chumoghscript" ]] && {
				i="Admin"
				DateExp=" Ilimitado"
			} || {
				DateExp="$(cat ${user_conft}|grep -w "${i}"|cut -d'|' -f3)"
				seg_exp=$(date +%s --date="$DateExp")
				exp="[$(($(($seg_exp - $seg)) / 86400))]"
			}

			col "$n)" "$i" "$DateExp" "$exp"
			let n++
		done
		msg -bar3
		col "0)" "VOLVER"
		msg -bar3
		blanco "SELECCIONA USUARIO" 0
		read opcion
		[[ -z $opcion ]] && vacio && sleep 0.3s && continue
		[[ $opcion = 0 ]] && tropass="user_null" && break
		n=1
		unset i
		for i in $users
		do
		[[ $n = $opcion ]] && tropass=$i
			let n++
		done
		let opcion--
		addip=$(wget -qO- ifconfig.me)
		echo "USER SELECIONADO : $tropass " 
		break
	done
}

view_user(){
config="/etc/v2ray/config.json"
temp="/etc/v2ray/temp.json"
v2rdir="/etc/v2r" && [[ ! -d $v2rdir ]] && mkdir $v2rdir
user_conf="/etc/v2r/user" && [[ ! -e $user_conf ]] && touch $user_conf
backdir="/etc/v2r/back" && [[ ! -d ${backdir} ]] && mkdir ${backdir}
tmpdir="$backdir/tmp"
	unset seg
	seg=$(date +%s)
	while :
	do
		users=$(cat $config | jq .inbounds[].settings.clients[] | jq -r .email)

		title "	VER USUARIO V2RAY REGISTRADO"
		userDat

		n=1
		for i in $users
		do
			unset DateExp
			unset seg_exp
			unset exp

			[[ $i = null ]] && {
				i="Admin"
				DateExp=" Ilimitado"
			} || {
				DateExp="$(cat ${user_conf}|grep -w "${i}"|cut -d'|' -f3)"
				seg_exp=$(date +%s --date="$DateExp")
				exp="[$(($(($seg_exp - $seg)) / 86400))]"
			}

			col "$n)" "$i" "$DateExp" "$exp"
			let n++
		done

		msg -bar3
		col "0)" "VOLVER"
		msg -bar3
		blanco "Escoje Tu Usuario : " 0
		read opcion
		[[ -z $opcion ]] && vacio && sleep 0.3s && continue
		[[ $opcion = 0 ]] && break
		let opcion--
		ps=$(jq .inbounds[].settings.clients[$opcion].email $config) && [[ $ps = null ]] && ps="default"
		uid=$(jq .inbounds[].settings.clients[$opcion].id $config)
		aluuiid=$(jq .inbounds[].settings.clients[$opcion].alterId $config)
		add=$(jq '.inbounds[].domain' $config) && [[ $add = null ]] && add=$(wget -qO- ipv4.icanhazip.com)
		host=$(jq '.inbounds[].streamSettings.wsSettings.headers.Host' $config) && [[ $host = null ]] && host=''
		net=$(jq '.inbounds[].streamSettings.network' $config)
		parche=$(jq -r .inbounds[].streamSettings.wsSettings.path $config) && [[ $path = null ]] && parche='' 
		v2port=$(jq '.inbounds[].port' $config)
		addip=$(wget -qO- ifconfig.me)
		echo "Usuario $ps Seleccionado" 
		break
	done
}

[[ ! -d /root/.config/clash ]] && fun_insta || fun_ip
clear
[[ -e /root/name ]] && figlet -p -f slant < /root/name || echo -e "\033[7;49;35m    =====>>â–ºâ–º ðŸ² New ChumoGHðŸ’¥VPS ðŸ² â—„â—„<<=====      \033[0m"
fileon=$(ls -la /var/www/html | grep "yaml" | wc -l)
filelo=$(ls -la /root/.config/clash | grep "yaml" | wc -l)
cd
msg -bar3
echo -e "\033[1;37m ✬  Linux Dist: $(less /etc/issue.net)\033[0m"
msg -bar3
echo -e "\033[1;37m ✬ Ficheros Online:	$fileon  ✬ Ficheros Locales: $filelo\033[0m"
msg -bar3
echo -e "\033[1;37m - Menu Iterativo Clash for Android - ChumoGH \033[0m"
msg -bar3
echo -e "\033[1;37mSeleccione :    Para Salir Ctrl + C o 0 Para Regresar\033[1;33m"
unset yesno
echo -e " DESEAS CONTINUAR CON LA CARGA DE CONFIG CLASH?"
while [[ ${yesno} != @(s|S|y|Y|n|N) ]]; do
read -p "[S/N]: " yesno
tput cuu1 && tput dl1
done
if [[ ${yesno} = @(s|S|y|Y) ]]; then
unset yesno numwt
#[[ -e /root/name ]] && figlet -p -f slant < /root/name || echo -e "\033[7;49;35m    =====>>â–ºâ–º ðŸ² New ChumoGHðŸ’¥VPS ðŸ² â—„â—„<<=====      \033[0m"
echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
echo -e "\033[1;33m ✬ Ingresa tu Whatsapp junto a tu codigo de Pais"
read -p " Ejemplo: +593987072611 : " numwt
if [[ -z $numwt ]]; then
numwt='+593987072611'
fi
echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
echo -e "\033[1;33m ✬ Ingresa Clase de Servidor ( Gratis - PREMIUM )"
read -p " Ejemplo: PREMIUM : " srvip
if [[ -z $srvip ]]; then
srvip="NewADM"
fi
configINIT
INITClash
fi
