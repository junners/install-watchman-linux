#Prep for install
sudo apt install -y autoconf automake build-essential python-dev libssl-dev libtool pkg-config

#clone, checkout, build and install
git clone https://github.com/facebook/watchman.git
cd watchman/
git checkout v4.9.0 #latest stable release
./autogen.sh
./configure
make
sudo make install

#raise inotify limit permanently
echo fs.inotify.max_user_watches=999999 | sudo tee -a /etc/sysctl.d/60-watchman.conf   && \
echo fs.inotify.max_user_instances=999999 | sudo tee -a /etc/sysctl.d/60-watchman.conf  && \
echo fs.inotify.max_queued_events=999999 | sudo tee -a /etc/sysctl.d/60-watchman.conf
#load new inotify limits
sudo sysctl -p /etc/sysctl.d/60-watchman.conf
watchman shutdown-server