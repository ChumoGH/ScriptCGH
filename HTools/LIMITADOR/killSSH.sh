#!/bin/bash
#CREADOR @ChumoGH | 06/06/2022

ADM='/etc/adm-lite/userDIR/'
touch /root/user

dropb () {
port_dropbear=`ps aux | grep dropbear | awk NR==1 | awk '{print $17;}'`
log=/var/log/auth.log
loginsukses='Password auth succeeded'
clear
pids=`ps ax |grep dropbear |grep  " $port_dropbear" |awk -F" " '{print $1}'`
for pid in $pids
do
pidlogs=`grep $pid $log |grep "$loginsukses" |awk -F" " '{print $3}'`
i=0
for pidend in $pidlogs
do
let i=i+1
done
if [ $pidend ];then
login=`grep $pid $log |grep "$pidend" |grep "$loginsukses"`
PID=$pid
user=`echo $login |awk -F" " '{print $10}' | sed -r "s/'/ /g"`
waktu=`echo $login |awk -F" " '{print $2"-"$1,$3}'`
while [ ${#waktu} -lt 13 ]; do
waktu=$waktu" "
done
while [ ${#user} -lt 16 ]; do
user=$user" "
done
while [ ${#PID} -lt 8 ]; do
PID=$PID" "
done
echo "$user $PID $waktu"
fi
done
}


killing () {
	kill $1
}

killerDROP () {
user=$1 && limit=$2
num=$(dropb | grep "$user" | wc -l)
[[ $num -gt $limit ]] && {
pidKILL=$(dropb | grep "$user" | awk '{print $2}')
killing $pidKILL
echo " $user DROPBEAR LIMITADO ${limit}/$num | $(printf '%(%D-%H:%M:%S)T') !" >> $HOME/limiter.log
}
}


for u in `awk -F : '$3 > 900 { print $1 }' /etc/passwd |grep -v "nobody" |grep -vi polkitd |grep -vi systemd-[a-z] |grep -vi systemd-[0-9] |sort`
do
[[ -e ${ADM}$u ]] && daaab=$(cat ${ADM}$u | grep "limite:" | awk '{print $2}')
[[ ${daaab} = "HWID" ]] && daaab=1
[[ ${daaab} = "TOKEN" ]] && daaab=1
killerDROP ${u} ${daaab}
echo "$u $daaab" >> /root/user
done

database="/root/user"
echo $$ > /tmp/pids
while read usline
	do
		user="$(echo $usline | cut -d' ' -f1)"
		s2ssh="$(echo $usline | cut -d' ' -f2)"
		if [ -z "$user" ] ; then
			echo "" > /dev/null
		else
			s1ssh="$(ps x | grep [[:space:]]$user[[:space:]] | grep -v grep | grep -v pts | wc -l)"
			if [ "$s1ssh" -gt "$s2ssh" ]; then
				while read line; do
					tmp="$(echo $line | cut -d' ' -f1)"
					kill $tmp
					echo " ( $user ) LIMITADO ${s2ssh}/${s1ssh} | $(printf '%(%D-%H:%M:%S)T') !" >> $HOME/limiter.log
				done <<< "$(ps x | grep [[:space:]]$user[[:space:]] | grep -v grep | grep -v pts)"
			fi
		fi
	done < "$database"

rm -rf /root/user
