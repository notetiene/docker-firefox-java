# Firefox over VNC
#
# VERSION               0.1
# DOCKER-VERSION        0.2

from	f69m/ubuntu32:14.04

# make sure the package repository is up to date
run	echo "deb http://old-releases.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
run	apt-get update

# Install vnc, xvfb in order to create a 'fake' display and firefox
run	apt-get install -y x11vnc xvfb openbox 

# Install the specific tzdata-java we need
run     apt-get -y install wget

run     wget --no-check-certificate http://launchpadlibrarian.net/255869664/tzdata_2016d-0ubuntu0.14.04_all.deb
run     dpkg -i tzdata_2016d-0ubuntu0.14.04_all.deb
run     wget --no-check-certificate https://launchpad.net/ubuntu/+source/tzdata/2016d-0ubuntu0.14.04/+build/9626356/+files/tzdata-java_2016d-0ubuntu0.14.04_all.deb
run     dpkg -i tzdata-java_2016d-0ubuntu0.14.04_all.deb

# Install Firefox and Java Plugins
run     apt-get install -y firefox icedtea-6-plugin icedtea-netx openjdk-6-jre openjdk-6-jre-headless tzdata-java 
run	mkdir ~/.vnc

# Autostart firefox (might not be the best way to do it, but it does the trick)
run     bash -c 'echo "exec openbox-session &" >> ~/.xinitrc'
run	bash -c 'echo "firefox" >> ~/.xinitrc'
run     bash -c 'chmod 755 ~/.xinitrc'

EXPOSE 5900

CMD ["x11vnc", "-forever", "-create"]
