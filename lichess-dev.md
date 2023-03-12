# MacOS installation (March 2023)
Got it to work, but it was a hassle, because I'm running Mojave (10.14.6), which is considered old, and brew has issues and is unsupported.  Had to add and 
upgrade many packages.    ui/build didn't work because Mojave's readlink didn't support the "-f" parameter, fixed this with help from the lichess dev 
team on discord: https://github.com/lichess-org/lila/pull/12477

# Linux Installation (March 2023)
Ubuntu is a good distribution, it has most packages.  For this current effort I used Ubuntu 22.04.2 LTS

Followed directions in https://github.com/lichess-org/lila/wiki/Lichess-Development-Onboarding

## System setup
    3  sudo apt install git
   20  sudo apt install gcc
   24  sudo apt install g++
   28  sudo snap install emacs --classic
   42  sudo apt install gnome-tweaks  # caps lock -> CTRL!
   46  sudo apt install openjdk-19-jre-headless
   59  echo curl -fL "https://github.com/coursier/launchers/raw/master/cs-x86_64-pc-linux.gz" | gzip -d > cs
   60  sudo apt install curl
   61  chmod +x cs
   62  ./cs setup
   70  source ~/.profile
   76  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
  105  nvm install node
  106  npm i -g pnpm

  120  cd fishnet/
  121  cargo run -- --endpoint http://localhost:9665/fishnet/
  122  source ~/.profile 
  123  cd git/lichess/
  124  git clone https://github.com/lichess-org/lila-db-seed
  126  sudo apt install python3-pip
  127  pip3 install pymongo
  129  python3 lila-db-seed/spamdb/spamdb.py 

  158  sudo apt install redis
  161  wget -qO - https://www.mongodb.org/static/pgp/server-6.0.asc | sudo apt-key add - 
  162  sudo apt-get install gnupg 
  163  echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/6.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list 
  165  sudo apt-get update 
  170  sudo apt-get install -y mongodb-org 
  171  echo "mongodb-org hold" | sudo dpkg --set-selections 
  172  echo "mongodb-org-database hold" | sudo dpkg --set-selections 
  173  echo "mongodb-org-server hold" | sudo dpkg --set-selections 
  174  echo "mongodb-mongosh hold" | sudo dpkg --set-selections 
  175  echo "mongodb-org-mongos hold" | sudo dpkg --set-selections 
  176  echo "mongodb-org-tools hold" | sudo dpkg --set-selections 
  177  ls /var/log
  178  cat /etc/mongod.conf 
  179  ps --no-headers -o comm 1 
  180  sudo systemctl start mongod 
  181  ps aux|grep mongo
  182  sudo systemctl status mongod 
  183  mongosh
  184  hg sysmem
  185  ps aux|grep redis
  186  cd
  187  mkdir git
  188  cd git
  189  mkdir lichess
  190  cd lichess
  191  git clone --recursive https://github.com/keaaw/lila.git
  192  cd lila
  193  mongosh lichess < bin/mongodb/indexes.js 
  194  ui/build
  195  df -H
  196  df -h
  197  cd ..
  198  git clone https://github.com/lichess-org/lila-ws.git 
  199  cd lila-ws/
  200  sbt run -Dcsrf.origin=http://localhost:9663 
  201  source ~/.profile
  202  sbt run -Dcsrf.origin=http://localhost:9663 
  203  cd ..
  204  git clone https://github.com/lichess-org/lila-fishnet.git
  205  cd lila-fishnet/
  206  sbt run -Dhttp.port=9665
  207  source ~/.profile
  208  sbt run -Dhttp.port=9665
  209  cd ..
  210  source ~/.profile 
  211  git clone --recursive https://github.com/lichess-org/fishnet.git
  212  cd fishnet/
  213  cargo run -- --endpoint http://localhost:9663/fishnet/
  214  snap info rustup
  215  sudo apt install cargo
  216  cargo run -- --endpoint http://localhost:9663/fishnet/
  217  ifconfig
  218  ipconfig
  219  ip a
  220  exit
  221  ps aux|grep mongo
  222  ps aux|grep redis
  223  history|grep mongo
  224  sudo systemctl status mongod 
  225  sudo systemctl start mongod 
  226  ps aux|grep mongo
  227  mongosh
  228  cd git/lichess
  229  jobs
  230  ls
  231  cd lila
  232  git grep Ruy
  233  git grep Berlin
  234  git grep Masters
  235  history|grep mongo
  236  sudo systemctl --help
  237  systemctl list-units
  238  systemctl --help
  239  systemctl list-units|grep mongo
  240  systemctl list-units|grep mongo|grep serv
  241  systemctl list-units|grep serv
  242  lspci -k
  243  lsusb -v
  244  lsusb -v | grep Device
  245  lsusb -v | grep Device | grep Bus
  246  lspci -k
  247  ip link
  248  dmesg | grep firmware
  249  sudo dmesg|grep firmware
  250  iw dev
  251  exit
  252  df -h
  253  ls /media/kmw/K\&L/
  254  ls /media/kmw/K\&L/ken-macbook-pro-backup/
  255  ls /media/kmw/K\&L/ken-macbook-pro-backup/ -lR
  256  ls /media/kmw/K\&L/ken-macbook-pro-backup/ -l
  257  exit
  258  history
kmw@kmw-940X5N:~/git/howto$ 
sudo apt install git
sudo apt install gcc
sudo apt install g++
sudo apt install gnome-tweaks
sudo apt install openjdk-19-jre-headless
sudo snap install emacs --classic
sudo apt install curl
sudo apt install python3-pip
sudo apt install redis
wget -qO - https://www.mongodb.org/static/pgp/server-6.0.asc | sudo apt-key add - 
sudo apt-get install gnupg 
sudo apt-get update 
sudo apt-get install -y mongodb-org 
sudo apt install cargo

Coursier installed not Ubuntu packages: https://get-coursier.io/docs/cli-installation

NVM installed via external installer, not Ubuntu packages

Issues: MongoDB packages are not available on 22.04 because of licensing changes in MongoDB, but following the directions here worked:
https://www.mongodb.com/docs/manual/tutorial/install-mongodb-on-ubuntu/
These are the packages maintained by MongoDB, use these instead of Ubuntu packages

You *definitely* need websockets for pretty much everything (if you don't set up websockets, no games will work, nor play against the computer, 
and you'll always have a red "Reconnecting" in the lower left of the screen)


# Running
all user passwords are "password" by default

You can tweak user passwords in spamdb by editing lichess/lila-db-seed/spamdb/data/uids.txt

