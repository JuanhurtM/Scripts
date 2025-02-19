#Hardening Ubuntu
#JUAN JOSE HURTADO MEJIA
#Clave Ubuntu Nohelia0276
#15 de Febrero del 2025

#Variables
mi_ip=11.11.24.27
eq_win=11.11.24.23
dns1=172.16.2.8 
dns2=172.16.2.9
dns3=8.8.8.8

#Se actualiza el sistema
echo "Actualizacion de las dependecias"

apt update

echo "Actualizacion del sistema"

apt upgrade


#Reglas Firewall
echo "Permitir trafico por 80/tcp"

ufw allow 80/tcp

echo "Permitir ssh"

ufw allow ssh

#Instalacion de neofetch
echo "Instalacion de Neofetch"

apt install neofetch -y

#Instalacion file2Ban

echo "Instalacion file2ban"

apt install fail2ban -y

#Instalacion chkrootkit

echo "Instalar chkrootkit"

apt install chkrootkit -y

#Instalar libpam

echo "Instalar libpam"

apt install libpam-tmpdir -y

#Instalar Needrestart

echo "Instalar Needrestart"

apt install needrestart -y



# ./lynis audit system

# hardening 65%,  Warnings (2):, Suggestions (35):

# Página 4

# ufw enable                         //Falta este comando

# ufw allow 80/tcp

# ufw allow ssh

# ufw status

# Página 5

# apt install fail2ban

# cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local

# nano /etc/fail2ban/jail.local

# apt install chkrootkit      //sin configuracion

# chkrootkit

# vi /etc/login.defs

# vi /etc/ssh/sshd_config    //Otras variables como

# Realizar los cambios sugerido de la pagina 7

# ./lynis audit system

# hardening 68%,  Warnings (3):, Suggestions (35):

# service --status-all          //pág 8

# systemctl stop cups

# systemctl disable cups

# systemctl stop openvpn

# systemctl disable openvpn

# apt purge cups

# apt install libpam-tmpdir -y

# apt install needrestart -y

# apt install debsums -y

# apt install apt-show-versions -y
# vi /etc/modprobe.d/modprobe.conf   // No existe lo cree

# /pagina 10

# vi /etc/issue.net
# contenido:

# Servidor protegido, no puede continuar

# cp /etc/issue.net /etc/issue