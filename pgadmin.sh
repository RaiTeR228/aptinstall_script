apt update -y && apt upgrade -y

apt install curl -y

apt install gpg -y

sudo curl -fsSL https://www.pgadmin.org/static/packages_pgadmin_org.pub | sudo gpg --dearmor -o/usr/share/keyrings/pgadmin-keyring.gpg

sudo sh -c 'echo "deb [signed-by=/usr/share/keyrings/pgadmin-keyring.gpg] https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" > /etc/apt/sources.list.d/pgadmin4.list'

apt update -y && apt upgrade -y

sudo apt install pgadmin4-web -y