# clear
df -h | grep /dev/sda1
uname -mrs
dpkg --list | grep linux-image

## daemon
sudo systemctl daemon-reload
sudo systemctl restart docker
nano /etc/docker/daemon.json

# config
docker compose config

# ports

netstat -tulpn
