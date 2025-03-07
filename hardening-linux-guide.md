# Guía para Comandos de Hardening en Linux

## 1. Actualización del Sistema

Primero, actualiza tu sistema para asegurarte de tener las últimas correcciones de seguridad:
```bash
apt update
apt upgrade
apt install neofetch
```

## 2. Firewall (UFW)

Configura el firewall para controlar el tráfico entrante y saliente:
```bash
ufw enable
ufw allow 80/tcp
ufw allow ssh
ufw status
```

## 3. Protección contra Ataques de Fuerza Bruta

Instala y configura fail2ban para bloquear intentos repetidos de acceso no autorizado:
```bash
apt install fail2ban
cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
nano /etc/fail2ban/jail.local
```

En el archivo `jail.local`, revisa la configuración y ajusta parámetros como:
- `bantime`: tiempo de bloqueo
- `findtime`: período para contar intentos
- `maxretry`: número máximo de intentos

## 4. Detección de Rootkits

```bash
apt install chkrootkit
chkrootkit
```

## 5. Seguridad de Acceso y SSH

Modifica los archivos de configuración para fortalecer las políticas de acceso:
```bash
vi /etc/login.defs
```
Ajusta parámetros como:
- `PASS_MAX_DAYS`: 90
- `PASS_MIN_DAYS`: 7
- `PASS_WARN_AGE`: 14

```bash
vi /etc/ssh/sshd_config
```
Realiza los cambios sugeridos, como:
- `PermitRootLogin no`
- `PasswordAuthentication no` (si usas claves SSH)
- `X11Forwarding no`

## 6. Desactivación de Servicios Innecesarios

Identifica y desactiva servicios que no necesitas:
```bash
service --status-all
```

Ejemplo para desactivar CUPS (sistema de impresión) y OpenVPN:
```bash
systemctl stop cups
systemctl disable cups
apt purge cups

systemctl stop openvpn
systemctl disable openvpn
```

## 7. Herramientas Adicionales de Seguridad

```bash
apt install libpam-tmpdir -y
apt install needrestart -y
apt install debsums -y
apt install apt-show-versions -y
```

## 8. Configuración de Módulos del Kernel

Crea el archivo si no existe:
```bash
vi /etc/modprobe.d/modprobe.conf
```

## 9. Mensajes de Advertencia

Configura mensajes disuasorios para posibles intrusos:
```bash
vi /etc/issue.net
```

Contenido recomendado:
```
Servidor protegido, no puede continuar
```

Después copia este mensaje al archivo issue:
```bash
cp /etc/issue.net /etc/issue
```

## 10. Auditoría y Monitoreo

```bash
apt install acct -y
/usr/sbin/accton on
apt install aide -y
```

## 11. Ajustes del Kernel

Crea un script con parámetros de seguridad:
```bash
vi Ajustes.sh
```

Contenido del script:
```bash
sysctl -w dev.tty.ldisc_autoload=0
sysctl -w fs.protected_fifos=2
sysctl -w fs.suid_dumpable=0
sysctl -w kernel.core_uses_pid=1
sysctl -w kernel.kptr_restrict=2
sysctl -w kernel.modules_disabled=1
sysctl -w kernel.sysrq=0
sysctl -w kernel.unprivileged_bpf_disabled=1
sysctl -w net.core.bpf_jit_harden=2
sysctl -w net.ipv4.conf.all.accept_redirects=0
sysctl -w net.ipv4.conf.all.log_martians=1
sysctl -w net.ipv4.conf.all.rp_filter=1
sysctl -w net.ipv4.conf.all.send_redirects=0
sysctl -w net.ipv4.conf.default.accept_redirects=0
sysctl -w net.ipv4.conf.default.accept_source_route=0
sysctl -w net.ipv4.conf.default.log_martians=1
sysctl -w net.ipv6.conf.all.accept_redirects=0
sysctl -w net.ipv6.conf.default.accept_redirects=0
```

Ejecuta el script:
```bash
bash Ajustes.sh
```

## 12. Mensajes de Advertencia Mejorados

Crea un mensaje más detallado para disuadir a intrusos:
```bash
vi /etc/issue
```

Contenido recomendado:
```
################################################################
#                  This is a private Server!                    #
#           All connections are monitored and record            #
#   Discconnect INMEDIATELY if you are not an authorized user   #
################################################################
```

Copia al archivo issue.net:
```bash
cp /etc/issue /etc/issue.net
```

## 13. Estadísticas del Sistema y Tareas Programadas

```bash
vi /etc/default/sysstat
systemctl enable sysstat
chmod 600 /etc/cron.daily
chmod 600 /etc/cron.hourly
chmod 600 /etc/cron.weekly
chmod 600 /etc/cron.monthly
```

## 14. Límites de Recursos

```bash
vi /etc/security/limits.conf
```

## 15. Parámetros Permanentes del Kernel

Para hacer permanentes los cambios en sysctl:
```bash
vi /etc/sysctl.conf
```

Añade estas líneas:
```
fs.suid_dumpable=0
kernel.core_pattern=|/bin/false
```

## 16. Verificación Final

Después de implementar todos los cambios, ejecuta Lynis para verificar el nivel de seguridad:
```bash
./lynis audit system
```

Deberías ver un incremento gradual en el porcentaje de hardening, desde 65% hasta aproximadamente 79% después de implementar todas las medidas.

## Recomendaciones

1. Implementa los cambios por secciones y verifica con Lynis después de cada bloque importante
2. Guarda copias de seguridad de los archivos de configuración antes de modificarlos
3. Asegúrate de tener un acceso alternativo al sistema en caso de bloqueos
4. Documenta todos los cambios que realices para futuras referencias

---
**Nota**: Esta guía está basada en las configuraciones mencionadas para Lynis version 3.1.5 y documentos referenciados en la consulta.
