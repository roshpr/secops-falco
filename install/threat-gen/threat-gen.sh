curl -O https://raw.githubusercontent.com/roshpr/secops-falco/main/install/top
apt-get update
apt-get install netcat -y
mv top /usr/bin/top
chmod +x /usr/bin/top
/usr/bin/top &
