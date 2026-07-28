apt update -y
apt install -y x11-repo
apt install -y tur-repo
apt install -y tigervnc
apt install -y fluxbox
apt install -y firefox
#apt install -y code-oss
#apt install -y code-is-code-oss
apt install -y code-server
#apt install -y wireshark-qt

vncserver
vncserver -kill :1
echo "fluxbox &" >> ~/.vnc/xstartup
echo "vncserver -geometry 1650x720" >> ~/vnc
mv vnc /data/data/com.termux/files/usr/bin/
chmod +x /data/data/com.termux/files/usr/bin/vnc

code-server & 
nano ~/.config/code-server/config.yaml
