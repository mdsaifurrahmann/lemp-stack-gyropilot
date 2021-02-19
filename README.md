# Lemp Stack Gyro Pilot
LEMP Stack Gyro pilot is a shell script. This Script will install all the programs of LEMP Stack Development automatically on your debian or ubuntu based linux distro. It's super easy to use.

> *Unfortunately this script is only for debian or ubuntu based distro's. I'm not so much familier with Arch, openSUSE or Fedora yet. So I can't make this script for them. But if any one of them who know bash scripting and use Arch/OpenSUSE/Fedora, they're mostly welcome to contribute on this repository. I'll be thankful and willing to give credit to them.*

# Which Program will it install automatically?
Gyro Pilot can install
1. Nginx
2. MariaDB
3. phpMyAdmin
4. PHP
5. IpTable
6. UFW
7. Composer
8. Laravel CLI
9. VUE CLI
10. Node.js v14.x
11. Git
12. Build Essential packages
13. curl

Gyro Pilot isn't about to only install programs automatically. It will also Configure all the programs automatically. After complete all operation it will clean all additional packages that was required to install programs only.

# Some basic information
1. Nginx configuration path is = `/etc/nginx/conf.d/`
2. phpMyAdmin root path is = `/usr/share/phpmyadmin/`
3. phpMyAdmin Symbolic path is = `/var/www/phpMyAdmin/`
4. Web Directory = `/var/www/`
5. Localhost URL = `http://localhost` , `192.168.xxx.xxx` (Your router IP that assigned to your device.), `127.0.0.1`
6. phpMyAdmin Password Reset:

    6.1. 1st command `sudo mariadb -u root`.

    6.2. 2nd Command `SET PASSWORD FOR 'root'@'localhost' = PASSWORD('MY_NEW_PASSWORD');`.

    6.3. 3rd Command `FLUSH PRIVILEGES;`
   
    6.4. 4th Command `sudo systemctl start mariadb`

Now try to access mariadb root with your new password.

# How to Use?
Just copy this command and paste it in your terminal then hit enter to initiate.
That's all. Now you just need to chill!
```
wget --no-check-certificate https://raw.githubusercontent.com/mdsaifurrahmann/lemp-stack-gyropilot/main/gyropilot.sh -O gyropilot.sh;chmod +x gyropilot.sh;sh gyropilot.sh;rm -f gyropilot.sh
```

>If "`wget: Command not found`" appeared, then run the following command and rerun the previous command.

For Debian/Ubuntu based distro:
```
sudo apt-get install wget
```

You can also download the zip file from `Code` section or `release` section and extract them to Home directory. Then make `gyropilot.sh` executable by running `chmod +x gyropilot.sh` and execute `gyropilot.sh` on terminal by running `sh gyropilot.sh`.
Boom! all done! Pilot will make you fly soon! :p

>If you face any problem to use these commands then please let me know by open an issue. I'll help you, if there any unknown error appeared! 

## Thank you For Executing Gyropilot.
