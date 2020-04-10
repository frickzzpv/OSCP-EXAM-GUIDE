#!/bin/bash
#
# AutoNSE - Massive NSE Autosploit/Autoscanner
# Momo Outaadi (M4ll0k)
# https://github.com/m4ll0k

# --colors--
red='\e[1;31m'
blue='\e[1;34m'
white='\e[0;38m'
green='\e[1;32m'
yellow='\e[1;33m'
reset_c='\e[0m'
# --tool var--
name='AutoNSE'
version='v0.2.0'
author='Momo Outaadi (m4ll0k)'
repository='https://github.com/m4ll0k'
description='AutoNSE - Massive NSE Autosploit/Autoscanner'
# --nmap fast scan--
exec_command='nmap -T5 -Pn --open -p 21,22,23,25,53'
exec_command+=",80,443,445,110,123,1521,143,5060,389"
exec_command+=",1433,2049,3306,5900,27017,5984,12345"
exec_command+=",502"
# nmap path 
nmap_path=$(whereis nmap|awk {'print $3'})

function banner() {
	clear
	echo -e $white"----------------------------------------"$reset_c
	echo -e $white"$description                            "$reset_c
	echo -e $white"$name - $version                        "$reset_c
	echo -e $white"$author                                 "$reset_c
	echo -e $white"$repository                             "$reset_c
	echo -e $white"----------------------------------------"$reset_c
	echo
}

function warn() {
	echo -e "$red[!]$reset_c $1"
	if [ $2 = "true" ]; then 
		exit 1
	fi
}

function plus() {
	echo -e "$green[+]$reset_c $1"
}

function info() {
	echo -e "$yellow[i]$reset_c $1"
}

function user() {
	if [ $(id -u) != "0" ]; then
		warn "Please run this script with root user!" "true"
	fi
}

function inmap() {
	info "Installing nmap... please wait..."
	apt-get install nmap > /dev/null 2>&1
	if [ "$?" != 0 ]; then
		warn "Nmap not installed..." "true"
	else 
		plus "Nmap was installed..."
	fi
}

function nnmap() {
	which nmap > /dev/null 2>&1
	if [ "$?" != 0 ]; then
		warn "This script needs nmap!",""
		inmap
	fi
}

function checker() {
	banner
	info "Checking user..."
	user;echo -e $green" \_ [OK]"$reset_c
	info "Checking nmap..."
	nnmap;echo -e $green" \_ [OK]"$reset_c
	sleep 1
}

function search_nse() {
	nse=$(ls "$nmap_path/scripts"|egrep -o "(^$1\S*)"|cut -d' ' -f4-|sort -b|tr '\n' ', ')
}

function scan_ftp() {
	ip=$1; output=$2
	plus "Loading ftp nse scripts..."
	search_nse 'ftp'
	plus "Found $(echo $nse|tr ', ' '\n'|wc -l) scripts..."
	if [ -n $output ]; then
		exec_command="nmap -p 21 $output --script=$nse --script-args userdb=user.txt,pass.txt $ip"
	else
		exec_command="nmap -p 21 --script=$nse --script-args userdb=user.txt,pass.txt $ip"
	fi
	info "Scanning... Please wait..."
	$exec_command
}

function scan_ssh() {
	ip=$1; output=$2
	plus "Loading ssh nse scripts..."
	search_nse 'ssh'
	plus "Found $(echo $nse|tr ', ' '\n'|wc -l) scripts..."
	if [ -n $output ]; then
		exec_command="nmap -p 22 $output --script=$nse --script-args userdb=user.txt,pass.txt $ip"
	else
		exec_command="nmap -p 22 --script=$nse --script-args userdb=user.txt,pass.txt $ip"
	fi
	info "Scanning... Please wait..."
	$exec_command
}

function scan_telnet() {
	ip=$1; output=$2
	plus "Loading telnet nse scripts..."
	search_nse 'telnet'
	plus "Found $(echo $nse|tr ', ' '\n'|wc -l) scripts..."
	if [ -n $output ]; then
		exec_command="nmap -p 23 $output --script=$nse --script-args userdb=user.txt,pass.txt $ip"
	else
		exec_command="nmap -p 23 --script=$nse --script-args userdb=user.txt,pass.txt $ip"
	fi
	info "Scanning... Please wait..."
	$exec_command
}

function scan_smtp() {
	ip=$1; output=$2
	plus "Loading smtp nse scripts..."
	search_nse 'smtp'
	plus "Found $(echo $nse|tr ', ' '\n'|wc -l) scripts..."
	if [ -n $output ]; then
		exec_command="nmap -p 25 $output --script=$nse --script-args userdb=user.txt,pass.txt $ip"
	else
		exec_command="nmap -p 25 --script=$nse --script-args userdb=user.txt,pass.txt $ip"
	fi
	info "Scanning... Please wait..."
	$exec_command
}

function scan_dns() {
	ip=$1; output=$2
	plus "Loading dns nse scripts..."
	search_nse 'dns'
	plus "Found $(echo $nse|tr ', ' '\n'|wc -l) scripts..."
	if [ -n $output ]; then
		exec_command="nmap -p 53 $output --script=$nse --script-args userdb=user.txt,pass.txt $ip"
	else
		exec_command="nmap -p 53 --script=$nse --script-args userdb=user.txt,pass.txt $ip"
	fi
	info "Scanning... Please wait..."
	$exec_command
}

function scan_http() {
	ip=$1; output=$2
	plus "Loading http nse scripts..."
	search_nse 'http'
	plus "Found $(echo $nse|tr ', ' '\n'|wc -l) scripts..."
	if [ -n $output ]; then
		exec_command="nmap -p 80 $output --script=$nse --script-args userdb=user.txt,pass.txt $ip"
	else
		exec_command="nmap -p 80 --script=$nse --script-args userdb=user.txt,pass.txt $ip"
	fi
	info "Scanning... Please wait..."
	$exec_command
}

function scan_ssl() {
	ip=$1; output=$2
	plus "Loading ssl nse scripts..."
	search_nse 'ssl'
	plus "Found $(echo $nse|tr ', ' '\n'|wc -l) scripts..."
	if [ -n $output ]; then
		exec_command="nmap -p 443 $output --script=$nse --script-args userdb=user.txt,pass.txt $ip"
	else
		exec_command="nmap -p 443 --script=$nse --script-args userdb=user.txt,pass.txt $ip"
	fi
	info "Scanning... Please wait..."
	$exec_command
}

function scan_smb() {
	ip=$1; output=$2
	plus "Loading smb nse scripts..."
	search_nse 'smb'
	plus "Found $(echo $nse|tr ', ' '\n'|wc -l) scripts..."
	if [ -n $output ]; then
		exec_command="nmap -p 445 $output --script=$nse --script-args userdb=user.txt,pass.txt $ip"
	else
		exec_command="nmap -p 445 --script=$nse --script-args userdb=user.txt,pass.txt $ip"
	fi
	info "Scanning... Please wait..."
	$exec_command
}

function scan_pop3() {
	ip=$1; output=$2
	plus "Loading pop3 nse scripts..."
	search_nse 'pop3'
	plus "Found $(echo $nse|tr ', ' '\n'|wc -l) scripts..."
	if [ -n $output ]; then
		exec_command="nmap -p 110 $output --script=$nse --script-args userdb=user.txt,pass.txt $ip"
	else
		exec_command="nmap -p 110 --script=$nse --script-args userdb=user.txt,pass.txt $ip"
	fi
	info "Scanning... Please wait..."
	$exec_command
}

function scan_ntp() {
	ip=$1; output=$2
	plus "Loading ntp nse scripts..."
	search_nse 'ntp'
	plus "Found $(echo $nse|tr ', ' '\n'|wc -l) scripts..."
	if [ -n $output ]; then
		exec_command="nmap -p 123 $output --script=$nse --script-args userdb=user.txt,pass.txt $ip"
	else
		exec_command="nmap -p 123 --script=$nse --script-args userdb=user.txt,pass.txt $ip"
	fi
	info "Scanning... Please wait..."
	$exec_command
}

function scan_oracle() {
	ip=$1; output=$2
	plus "Loading oracle nse scripts..."
	search_nse 'oracle'
	plus "Found $(echo $nse|tr ', ' '\n'|wc -l) scripts..."
	if [ -n $output ]; then
		exec_command="nmap -p 1521 $output --script=$nse --script-args userdb=user.txt,pass.txt $ip"
	else
		exec_command="nmap -p 1521 --script=$nse --script-args userdb=user.txt,pass.txt $ip"
	fi
	info "Scanning... Please wait..."
	$exec_command
}

function scan_imap() {
	ip=$1; output=$2
	plus "Loading imap nse scripts..."
	search_nse 'imap'
	plus "Found $(echo $nse|tr ', ' '\n'|wc -l) scripts..."
	if [ -n $output ]; then
		exec_command="nmap -p 143 $output --script=$nse --script-args userdb=user.txt,pass.txt $ip"
	else
		exec_command="nmap -p 143 --script=$nse --script-args userdb=user.txt,pass.txt $ip"
	fi
	info "Scanning... Please wait..."
	$exec_command
}

function scan_sip() {
	ip=$1; output=$2
	plus "Loading sip nse scripts..."
	search_nse 'sip'
	plus "Found $(echo $nse|tr ', ' '\n'|wc -l) scripts..."
	if [ -n $output ]; then
		exec_command="nmap -p 5060 $output --script=$nse --script-args userdb=user.txt,pass.txt $ip"
	else
		exec_command="nmap -p 5060 --script=$nse --script-args userdb=user.txt,pass.txt $ip"
	fi
	info "Scanning... Please wait..."
	$exec_command
}

function scan_ldap() {
	ip=$1; output=$2
	plus "Loading ldap nse scripts..."
	search_nse 'ldap'
	plus "Found $(echo $nse|tr ', ' '\n'|wc -l) scripts..."
	if [ -n $output ]; then
		exec_command="nmap -p 389 $output --script=$nse --script-args userdb=user.txt,pass.txt $ip"
	else
		exec_command="nmap -p 389 --script=$nse --script-args userdb=user.txt,pass.txt $ip"
	fi
	info "Scanning... Please wait..."
	$exec_command
}

function scan_mssql() {
	ip=$1; output=$2
	plus "Loading mssql nse scripts..."
	search_nse 'ms-sql'
	plus "Found $(echo $nse|tr ', ' '\n'|wc -l) scripts..."
	if [ -n $output ]; then
		exec_command="nmap -p 1433 $output --script=$nse --script-args userdb=user.txt,pass.txt $ip"
	else
		exec_command="nmap -p 1433 --script=$nse --script-args userdb=user.txt,pass.txt $ip"
	fi
	info "Scanning... Please wait..."
	$exec_command
}

function scan_nfs() {
	ip=$1; output=$2
	plus "Loading nfs nse scripts..."
	search_nse 'nfs'
	plus "Found $(echo $nse|tr ', ' '\n'|wc -l) scripts..."
	if [ -n $output ]; then
		exec_command="nmap -p 2049 $output --script=$nse --script-args userdb=user.txt,pass.txt $ip"
	else
		exec_command="nmap -p 2049 --script=$nse --script-args userdb=user.txt,pass.txt $ip"
	fi
	info "Scanning... Please wait..."
	$exec_command
}

function scan_mysql() {
	ip=$1; output=$2
	plus "Loading mysql nse scripts..."
	search_nse 'mysql'
	plus "Found $(echo $nse|tr ', ' '\n'|wc -l) scripts..."
	if [ -n $output ]; then
		exec_command="nmap -p 3306 $output --script=$nse --script-args userdb=user.txt,pass.txt $ip"
	else
		exec_command="nmap -p 3306 --script=$nse --script-args userdb=user.txt,pass.txt $ip"
	fi
	info "Scanning... Please wait..."
	$exec_command
}

function scan_vnc() {
	ip=$1; output=$2
	plus "Loading vnc nse scripts..."
	search_nse 'vnc'
	plus "Found $(echo $nse|tr ', ' '\n'|wc -l) scripts..."
	if [ -n $output ]; then
		exec_command="nmap -p 5900 $output --script=$nse --script-args userdb=user.txt,pass.txt $ip"
	else
		exec_command="nmap -p 5900 --script=$nse --script-args userdb=user.txt,pass.txt $ip"
	fi
	info "Scanning... Please wait..."
	$exec_command
}

function scan_mongodb() {
	ip=$1; output=$2
	plus "Loading mongodb nse scripts..."
	search_nse 'mongodb'
	plus "Found $(echo $nse|tr ', ' '\n'|wc -l) scripts..."
	if [ -n $output ]; then
		exec_command="nmap -p 27017 $output --script=$nse --script-args userdb=user.txt,pass.txt $ip"
	else
		exec_command="nmap -p 27017 --script=$nse --script-args userdb=user.txt,pass.txt $ip"
	fi
	info "Scanning... Please wait..."
	$exec_command
}

function scan_couchdb() {
	ip=$1; output=$2
	plus "Loading couchdb nse scripts..."
	search_nse 'couchdb'
	plus "Found $(echo $nse|tr ', ' '\n'|wc -l) scripts..."
	if [ -n $output ]; then
		exec_command="nmap -p 5984 $output --script=$nse --script-args userdb=user.txt,pass.txt $ip"
	else
		exec_command="nmap -p 5984 --script=$nse --script-args userdb=user.txt,pass.txt $ip"
	fi
	info "Scanning... Please wait..."
	$exec_command
}

function scan_netbus() {
	ip=$1; output=$2
	plus "Loading netbus nse scripts..."
	search_nse 'netbus'
	plus "Found $(echo $nse|tr ', ' '\n'|wc -l) scripts..."
	if [ -n $output ]; then
		exec_command="nmap -p 12345 $output --script=$nse --script-args userdb=user.txt,pass.txt $ip"
	else
		exec_command="nmap -p 12345 --script=$nse --script-args userdb=user.txt,pass.txt $ip"
	fi
	info "Scanning... Please wait..."
	$exec_command
}

function scan_modbus() {
        ip=$1; output=$2
	plus "Loading modbus nse scripts..."
        search_nse 'modbus'
        plus "Found $(echo $nse|tr ', ' '\n'|wc -l) scripts..."
        if [ -n $output ]; then
                exec_command="nmap -p 502 $output --script=$nse --script-args='modbus-discover.aggressive=true'  $ip"
        else
                exec_command="nmap -p 502 --script=$nse --script-args='modbus-discover.aggressive=true'  $ip"
        fi
        info "Scanning... Please wait..."
        $exec_command
}

function scanner() {
	ip=$1; port=$2; output=$3
	if [ $port = "21" ]; then
		scan_ftp "$ip" "$output"
	fi
	if [ $port = "22" ]; then
		scan_ssh "$ip" "$output"
	fi
	if [ $port = "23" ]; then
		scan_telnet "$ip" "$output"
	fi
	if [ $port = "25" ]; then
		scan_smtp "$ip" "$output"
	fi
	if [ $port = "53" ]; then
		scan_dns "$ip" "$output"
	fi
	if [ $port = "80" ]; then
		scan_http "$ip" "$output"
	fi
	if [ $port = "433" ]; then
		scan_ssl "$ip" "$output"
	fi
	if [ $port = "445" ]; then
		scan_smb "$ip" "$output"
	fi
	if [ $port = "110" ]; then
		scan_pop3 "$ip" "$output"
	fi
	if [ $port = "123" ]; then
		scan_ntp "$ip" "$output"
	fi
	if [ $port = "502" ]; then
                scan_modbus "$ip" "$output"
        fi
	if [ $port = "1521" ]; then
		scan_oracle "$ip" "$output"
	fi
	if [ $port = "143" ]; then
		scan_imap "$ip" "$output"
	fi
	if [ $port = "5060" ]; then
		scan_sip "$ip" "$output"
	fi
	if [ $port = "389" ]; then
		scan_ldap "$ip" "$output"
	fi
	if [ $port = "1433" ]; then
		scan_mssql "$ip" "$output"
	fi
	if [ $port = "2049" ]; then
		scab_nfs "$ip" "$output"
	fi
	if [ $port = "3306" ]; then
		scan_mysql "$ip" "$output"
	fi
	if [ $port = "5900" ]; then
		scan_vnc "$ip" "$output"
	fi
	if [ $port = "27017" ]; then
		scan_mongodb "$ip" "$output"
	fi
	if [ $port = "5984" ]; then
		scan_couchdb "$ip" "$output"
	fi
	if [ $port = "12345" ]; then
		scan_netbus "$ip" "$output"
	fi
}

function output() {
	plus " Select nmap output:\n"
	echo -e "  1) Output scan in xml format"
	echo -e "  2) Output scan in normal format"
	echo -e "  3) Output scan in grepable format\n"
	echo -e " 99) Exit\n"
}

function ask_ip() {
	echo -ne "$green[*]$reset_c Target >> "
	read ip
	echo
}

function ask_output() {
	echo
	echo -n -e "$green[*]$reset_c Output path >> "
	read path 
	echo -n -e "$green[*]$reset_c Name of report >> "
	read filename
	ask_ip
}

function ask() {
	echo
	while true
	do
		echo -n -e "$green[*]$reset_c nmap output? [y/n]: "
		read conf
		if [ $conf = "y" ];then
			break
		fi 
		if [ $conf = "n" ]; then
			echo
			break		
		fi
	done
}

function autonse() {
	clear
	banner
	ask
	if [ $conf = "y" ];then
		output
		echo -ne "AutoNSE@ #> ";tput sgr0
		read input
		if test $input = '1';then
			ask_output
			info "Fast Scanning..."
			scan="$exec_command $ip"
			results=$($scan|grep -o '[0-9]\+/'|awk -F'[^0-9]' '{print $1}')
			output="-oX $nmap_path/$filename"
			output+=".xml"
			for i in ${results};do
				plus "Port $i is open..."
				scanner "$ip" "$i" "$output"
			done
		fi
		if test $input = '2';then
			ask_output
			info "Fast Scanning..."
			scan="$exec_command $ip"
			results=$($scan|grep -o '[0-9]\+/'|awk -F'[^0-9]' '{print $1}')
			output="-oN $nmap_path/$filename"
			output+=".txt"
			for i in ${results};do
				plus "Port $i is open..."
				scanner "$ip" "$i" "$output"
			done
		fi
		if test $input = '3';then
			ask_output
			info "Fast Scanning..."
			scan="$exec_command $ip"
			results=$($scan|grep -o '[0-9]\+/'|awk -F'[^0-9]' '{print $1}')
			output="-oG $nmap_path/$filename"
			output+=".grep"
			for i in ${results};do
				plus "Port $i is open..."
				scanner "$ip" "$i" "$output"
			done
		fi
		if test $input = '99';then
			exit 1
		fi
	fi
	if [ $conf = "n" ];then
		ask_ip
		info "Fast Scanning..."
		scan="$exec_command $ip"
		results=$($scan|grep -o '[0-9]\+/'|awk -F'[^0-9]' '{print $1}')
		for i in ${results};do
			plus "Port $i is open..."
			scanner "$ip" "$i" "$output"
		done
	fi
}
function run() {
	clear
	checker
	autonse
}
run
