#Taller de Iptables Ubuntu 22.04
#Julio Cesar Gomez Castano
#marzo 24 de 2023

#variables
mi_ip=11.11.24.27
eq_win=11.11.24.23
dns1=172.16.2.8 
dns2=172.16.2.9
dns3=8.8.8.8
wwwum=192.124.249.68
wwwunal=168.176.155.85
wwwuao=104.26.9.14

#Punto 12

#Deja el firewall con todo cerrado

#Borrar las reglas
iptables -F

#Fijar las politicas denegar
iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP

#permitir comunicacion consigo mismo

iptables -A INPUT  -i lo -j ACCEPT -v
iptables -A OUTPUT -o lo -j ACCEPT -v

#Punto 14

#Punto 14 Permita icmp desde la lan local 192.168.99.0/24
echo " Punto 14 Permita icmp desde la lan local 192.168.1.0/24"

iptables -A INPUT  -s 11.11.24.0/24 -d 11.11.24.23 -p ICMP -j ACCEPT -v
iptables -A OUTPUT -d 11.11.24.0/24 -s 11.11.24.23 -p ICMP -j ACCEPT -v

#Punto 15

#Punto 15 Permita toda comunicacion desde el equipo windows $eq_win a mi equipo

iptables -A INPUT  -s $eq_win -d $mi_ip -j ACCEPT -v
iptables -A OUTPUT -d $eq_win -s $mi_ip -j ACCEPT -v

#punto 19

echo "Permitir consultas del dns $dns1"
#empiezo a utilizar variables en el caso de la direccion ip del dns1

iptables -A OUTPUT -s $mi_ip  -d $dns1 -p udp --sport 1024:65535 --dport 53 -j ACCEPT -v
iptables -A INPUT -d  $mi_ip  -s $dns1 -p udp --dport 1024:65535 --sport 53 -j ACCEPT -v

#Punto 20

echo "permitir consultas del dns $dns2"

iptables -A OUTPUT -s $mi_ip  -d $dns2 -p udp --sport 1024:65535 --dport 53 -j ACCEPT -v
iptables -A INPUT  -d $mi_ip  -s $dns2 -p udp --dport 1024:65535 --sport 53 -j ACCEPT -v

#echo "permitir consultas del dns $dns3"

iptables -A OUTPUT -s $mi_ip  -d $dns3 -p udp --sport 1024:65535 --dport 53 -j ACCEPT -v
iptables -A INPUT  -d $mi_ip  -s $dns3 -p udp --dport 1024:65535 --sport 53 -j ACCEPT -v

#Punto 21

echo "permitir consultas desde $mi_ip al  https de la Umanizales $wwwum"

iptables -A OUTPUT -s $mi_ip  -d $wwwum -p tcp --sport 1024:65535 --dport https -j ACCEPT -v
iptables -A INPUT  -d $mi_ip  -s $wwwum -p tcp --dport 1024:65535 --sport https -j ACCEPT -v

#echo "permitir consultas desde $mi_ip al  http de la manizales unal $wwwunal"

iptables -A OUTPUT -s $mi_ip  -d $wwwuao -p tcp --sport 1024:65535 --dport http -j ACCEPT -v
iptables -A INPUT  -d $mi_ip  -s $wwwuao -p tcp --dport 1024:65535 --sport http -j ACCEPT -v

#Punto 22

echo "permitir consultas desde $mi_ip a  http de Internet"

iptables -A OUTPUT -s $mi_ip  -d 0/0  -p tcp --sport 1024:65535 --dport http -j ACCEPT -v
iptables -A INPUT  -d $mi_ip  -s 0/0  -p tcp --dport 1024:65535 --sport http -j ACCEPT -v

#echo "permitir consultas desde $mi_ip a  https de Internet"

iptables -A OUTPUT -s $mi_ip  -d 0/0  -p tcp --sport 1024:65535 --dport https -j ACCEPT -v
iptables -A INPUT  -d $mi_ip  -s 0/0  -p tcp --dport 1024:65535 --sport https -j ACCEPT -v

#Punto 23

echo "ser servidor ssh del equipo windows:$eq_win"

iptables -A  INPUT -s $eq_win -d $mi_ip -p tcp --sport 1024:65535 --dport ssh -j ACCEPT -v
iptables -A OUTPUT -d $eq_win -s $mi_ip -p tcp --dport 1024:65535 --sport ssh -j ACCEPT -v

#Punto 24

echo "ser cliente ssh del equipo 192.168.1.9"

iptables -A OUTPUT -s $mi_ip -d 11.11.24.23 -p tcp --sport 1024:65535 --dport ssh -j ACCEPT -v

iptables -A INPUT -d $mi_ip -s 11.11.24.23 -p tcp --dport 1024:65535 --sport ssh -j ACCEPT -v

#Punto 25

echo "ser servidor http de la red local 192.168.1.0/24"

iptables -A  INPUT -s 11.11.24.0/24 -d $mi_ip -p tcp --sport 1024:65535 --dport http -j ACCEPT -v
iptables -A OUTPUT -d 11.11.24.0/24 -s $mi_ip -p tcp --dport 1024:65535 --sport http -j ACCEPT -v

1
#Punto 26

echo "ser servidor ftp de la red local 192.168.99.0/24"

iptables -A  INPUT -s 11.11.24.0/24 -d $mi_ip -p tcp --sport 1024:65535 --dport ftp -j ACCEPT -v
iptables -A OUTPUT -d 11.11.24.0/24 -s $mi_ip -p tcp --dport 1024:65535 --sport ftp -j ACCEPT -v


iptables -A  INPUT -s 11.11.24.0/24 -d $mi_ip -p tcp --sport 1024:65535 --dport ftp-data -j ACCEPT -v
iptables -A OUTPUT -d 11.11.24.0/24 -s $mi_ip -p tcp --dport 1024:65535 --sport ftp-data -j ACCEPT -v

#Punto 27

echo "Denegar solicitud que entre a la NIC con IP origen mi direccion IP"

iptables -A  INPUT -i enss33 -s $mi_ip -d $mi_ip -j DROP -v

#Punto 28

echo "Denegar solicitud que entre a la NIC con IP origen mi direccion red"

iptables -A  INPUT -i enss33 -s 11.11.24.0/24 -d $mi_ip -j DROP -v

echo "Denegar solicitud que entre a la NIC con IP origen mi direccion Broadcast"

iptables -A  INPUT -i enss33 -s 11.11.24.255/24 -d $mi_ip -j DROP -v


#Punto 29 Prevenir ataques desde mi equipo

echo "Denegar solicitud que salgan de la NIC con IP origen mi direccion red"

iptables -A  OUTPUT -o enss33 -s 11.11.24.0/24 -j DROP -v

echo "Denegar solicitud que salgan de la NIC con IP origen mi direccion Broadcast"

iptables -A  OUTPUT -o enss33 -s 11.11.24.255/24 -j DROP -v





