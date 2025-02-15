#Taller de Iptables Ubuntu 24.04
#Juan Jose Hurtado Mejia
#febrero 15 del 2025

#Deja el firewall con todo abierto

#Borrar las reglas
iptables -F

#Fijar las politicas en permitir
iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT

