#!/bin/bash

#********************************************************************
#					Created By Md. Saifur Rahman					#
#	Knock Me  md.saifurrahmann029@gmail.com or saifur@saifur.xyz	#
#********************************************************************

#variables
s2='sleep 2s'
s1='sleep 1s'
home='pwd'
RED='\e[1;31m'
BLUE='\e[1;34m'
GREEN='\e[1;32m'
YELLOW='\e[1;33m'
END='\e[0m'
pacm="sudo apt"
yes="-y"
ssys='sudo systemctl'
nginx="nginx"
iptable='iptables'
confIPTable='sudo iptables -I INPUT -p tcp --dport 80 -j ACCEPT'
ufw="ufw"
allowUFWHTTP='sudo ufw allow http'
nginxOwData='sudo chown www-data:www-data /usr/share/nginx/html -R'
mariadb="mariadb"
mariadbsc="mariadb-server mariadb-client"
mss='sudo mysql_secure_installation'
iphp7='php7.4 php7.4-fpm php7.4-mysql php-common php7.4-cli php7.4-common php7.4-json php7.4-opcache php7.4-readline php7.4-mbstring php7.4-xml php7.4-gd php7.4-curl php-redis php-imagick php7.4-gd php-memcached php7.4-zip'
spc='software-properties-common'
aarophp='sudo add-apt-repository -y ppa:ondrej/php'
iphp8='php8.0 php8.0-fpm php8.0-mysql php-common php8.0-cli php8.0-common php8.0-opcache php8.0-readline php8.0-mbstring php8.0-xml php8.0-gd php8.0-curl php8.0-redis php8.0-imagick php8.0-gd php8.0-memcached php8.0-zip'
git="git"
build_essential='build-essential'
nodejs="nodejs"
enable_nginx='sudo systemctl enable nginx'
enable_mariadb='sudo systemctl enable mariadb'
enable_fpm7='sudo systemctl enable php7.4-fpm'
enable_fpm8='sudo systemctl enable php8.0-fpm'


echo "$RED

    __    ________  _______     _____ __             __  
   / /   / ____/  |/  / __ \   / ___// /_____ ______/ /__
  / /   / __/ / /|_/ / /_/ /   \__ \/ __/ __ \`/ ___/ //_/
 / /___/ /___/ /  / / ____/   ___/ / /_/ /_/ / /__/ ,<   
/_____/_____/_/  /_/_/       /____/\__/\__,_/\___/_/|_|  
   ______                 ____  _ __      __             
  / ____/_  ___________  / __ \(_) /___  / /_            
 / / __/ / / / ___/ __ \/ /_/ / / / __ \/ __/            
/ /_/ / /_/ / /  / /_/ / ____/ / / /_/ / /_              
\____/\__, /_/   \____/_/   /_/_/\____/\__/              
     /____/                                              
$END";


#UPDATE
echo "$RED
------------------------------------
|  Initializing System Update...!  |
------------------------------------
$END";
echo "$BLUE Executing \$${pacm} ${yes} update $END";

${pacm} ${yes} update
$s1

#UPGRADE
echo "$RED
-------------------------------------
|  Initializing System Upgrade...!  |
-------------------------------------
$END";
echo "$BLUE Executing \$${pacm} ${yes} upgrade $END";
${pacm} ${yes} upgrade
$s1

#NGINX
if [ $? -eq 0 ];
then
	echo "$RED
-----------------------------------------
|  Initializing NginX Installation...!  |
-----------------------------------------
$END";
echo "$BLUE Executing \$${pacm} ${yes} install $nginx \n $END";

		#NginX Process
	if ! command -v $nginx
	then
		${pacm} ${yes} install ${nginx}
		echo "$RED Starting NginX $END";
		${ssys} start ${nginx}
		echo "$GREEN Done! $END"
		echo
		$s2
	else
		echo "$GREEN $nginx is already installed on above directory. \n $END";
		${ssys} start ${nginx}
		echo
		$s2
	fi
else
	echo "$YELLOW NginX installation abort. Because Update & Upgrade failed or Canceled or something went wrong! Exit with code $?\nThank you for executing LEMP Stack Gyro pilot. Feel Free to Contribute.\nRegards\nMd. Saifur Rahman
	$END";
	$s2
	exit
fi
$s2

#IPTABLE
echo "$RED
-----------------------------
|  Configuring IPTable...!  |
-----------------------------
$END";
echo "$BLUE Executing \$${pacm} ${yes} install $iptable \n $END";

#Configuring IPTable Firewall
if command -v $iptable
then
	echo "$GREEN ${iptable} found on above directory. Aheading to the next stage! $END \n";
	echo "$YELLOW Applying iptables rule $END \n";
	echo "$BLUE Executing \$${confIPTable} $END";
	${confIPTable}
	echo
	echo "$YELLOW Success! $END \n";
else
	echo "$YELLOW iptable not found. Installing iptable! $END"
	${pacm} ${yes} install ${iptable}
	if command -v $iptable
	then
		echo "$YELLOW Applying iptables rule $END \n";
		echo "$BLUE Executing \$${confIPTable} $END";
		${confIPTable}
		$s2
	else
		echo "$YELLOW ${iptable} installation Failed. ${iptable} rules has not been successfully configured. \n
		$END"
		read -p "Do you want to skip this step? Default is Y. [Y,n]: " skipipt
		case $skipipt in
			y|Y) echo "$RED Okay! Going Ahead $END" ;;
			n|N) echo "$RED Okay! No Problem! Exiting Gyro pilot.\nOperation failed or Canceled or something went wrong! Exit with code $?.\nThank you for executing LEMP Stack Gyro pilot. Feel Free to Contribute.\nRegards\nMd. Saifur Rahman
			$END" & exit ;;
			*) echo "$RED Invalid Input. Aborting Installation $END" & exit;;
		esac
	fi
fi

#UFW
echo "$RED
--------------------------------------
|  Permitting UFW to allow HTTP...!  |
--------------------------------------
$END";
echo "$BLUE Executing \$$allowUFWHTTP $END";

if command -v ${ufw}
then
	echo "$GREEN ${ufw} found on above directory.aheading to next stage! $END \n";
	echo "$YELLOW Asking ${ufw} to allow HTTP Requests. $END \n";
	echo "$BLUE \$${allowUFWHTTP} $END";
	${allowUFWHTTP}
	$s2
else
	echo "$GREEN ${ufw} not found. Installing ${ufw}..! $END \n";
	${pacm} ${yes} install ${ufw}
	if command -v ${ufw}
	then
		echo "$GREEN ${ufw} found on above directory. Aheading to the next stage! $END \n";
		echo "$YELLOW Asking ${ufw} to allow HTTP Requests. $END ";
		echo "$BLUE \$${allowUFWHTTP} $END";
		${allowUFWHTTP}
		echo "$GREEN Done! $END"
	else
		echo "$YELLOW ${ufw} installation Failed. ${ufw} rules has not been successfully configured. \n
			$END"
			read -p "Do you want to skip this step? [Y,n]: " skip
			case $skip in
				y|Y) echo "$RED Okay! Going Ahead $END" ;;
				n|N) echo "$RED Okay! No Problem! Exiting Gyro pilot.\nOperation failed or Canceled or something went wrong! Exit with code $?.\nThank you for executing LEMP Stack Gyro pilot. Feel Free to Contribute.\nRegards\nMd. Saifur Rahman $END" & exit ;;
				*) echo "$RED Going To the Next Step! $END" ;;
			esac
	fi
fi


#DIR OWNERING
echo "$RED
--------------------------------------------------------------------
|  Making www-data (Nginx user) as the owner of web directory...!  |
--------------------------------------------------------------------
$END";

if command -v $nginx
then
	echo "$GREEN NginX Found! $END"
	echo "$BLUE Executing \$$nginxOwData $END \n";
	${nginxOwData}
	echo "$YELLOW Done! $END"
	$s2
else
	echo "$YELLOW Operation Failed. Please do this step manually.
 Installation Will continue after 5 seconds.  $END";
	sleep 5s
fi


#MARIA DB
echo "$RED
----------------------------
|  Installing MariaDB...!  |
----------------------------
$END";

if ! command -v $mariadb
then
	echo "$GREEN Executing \$${pacm} ${yes} install ${mariadbsc} $END \n";
		${pacm} ${yes} install ${mariadbsc}
		if command -v $mariadb
		then
			echo "$YELLOW Starting MariaDB! $END"
			${ssys} start ${mariadb}
		else
			echo "$YELLOW MariaDB is Missing or Can't Start. Check the Log!"
			$s2
			echo
		fi
else
	echo "$YELLOW MariaDB Already Installed on above directory. going to next step. $END"
	echo "$YELLOW Starting MariaDB! $END"
	${ssys} start ${mariadb}
	echo "$GREEN Done! $END"
	echo
fi

#POST SECURITY
echo "$RED
---------------------------------------------------
|  Initializing MySQL Security Installation ...!  |
---------------------------------------------------
$END";

if command -v $mariadb
then
	echo "$GREEN $mariadb Found! $END"
	echo "$BLUE \$$mss $END"
	$mss
	$s2
fi

#PHP
echo "$RED
---------------------------------------
|  Initializing PHP Installation...!  |
---------------------------------------
$END";

echo "$YELLOW
Which Version of PHP you want to install?
1. 7.4
2. 8.0
(Defualt is PHP v8.0. Press Any key to continue or input your choice.)
$END";

read -p "Choice: " phpv
case $phpv in
	1) 
		echo "$GREEN You Choose 7.4. Installaing PHP 7.4 with PHP 7.4 Extensions! $END"
		${pacm} ${yes} install ${iphp7}
		echo "$GREEN Done! $END"
		$s1
		echo "$RED Starting PHP7.4-FPM $END"
		${ssys} start php7.4-fpm
		echo "$GREEN Done! $END"
		echo
		$s1
		
		#NGINX CONF
		echo "$YELLOW Creating Nginx Configuration File... $END"
		wget -O default.conf -P ~/ https://raw.githubusercontent.com/mdsaifurrahmann/lemp-stack-gyropilot/main/php7.4-default.conf
		sudo mv default.conf /etc/nginx/conf.d/
		echo 
		echo "$GREEN Success $END"
		$s1
		#PHPMYADMIN CONF
		echo
		echo "$YELLOW Creating phpMyAdmin Preconfiguration File... $END"
		wget -O phpmyadmin.conf -P ~/ https://raw.githubusercontent.com/mdsaifurrahmann/lemp-stack-gyropilot/main/php7.4-phpmyadmin.conf
		sudo mv phpmyadmin.conf /etc/nginx/conf.d/
		echo 
		echo "$GREEN Success $END"
		$s1

	;;

	2) 
		echo "$GREEN You Choose 8.0. Installaing PHP 8.0 with PHP 8.0 Extensions! $END"
		${pacm} ${yes} install ${spc}
		${aarophp}
		${pacm} ${yes} install ${iphp8}
		echo "$GREEN Done! $END"
		$s1
		echo "$RED Starting PHP8.0-FPM $END"
		${ssys} start php8.0-fpm
		echo "$GREEN Done! $END"
		echo
		$s1

		#NGINX CONF
		echo "$YELLOW Creating Nginx Configuration File... $END"
		wget -O default.conf -P ~/ https://raw.githubusercontent.com/mdsaifurrahmann/lemp-stack-gyropilot/main/php8.0-default.conf
		sudo mv default.conf /etc/nginx/conf.d/
		echo 
		echo "$GREEN Success $END"
		$s1
		#PHPMYADMIN CONF
		echo
		echo "$YELLOW Creating phpMyAdmin Preconfiguration File... $END"
		wget -O phpmyadmin.conf -P ~/ https://raw.githubusercontent.com/mdsaifurrahmann/lemp-stack-gyropilot/main/php8.0-phpmyadmin.conf
		sudo mv phpmyadmin.conf /etc/nginx/conf.d/
		echo 
		echo "$GREEN Success $END"
		$s1
	
	;;

	*) 
		echo "$RED Installing PHP 8.0 with PHP 8.0 Extensions. $END"
		${pacm} ${yes} install ${spc}
		${aarophp}
		${pacm} ${yes} install ${iphp8}
		echo "$GREEN Done! $END"
		$s1
		echo "$RED Starting PHP8.0-FPM $END"
		${ssys} start php8.0-fpm
		echo "$GREEN Done! $END"
		echo
		$s1

		#NGINX CONF
		echo "$YELLOW Creating Nginx Configuration File... $END"
		wget -O default.conf -P ~/ https://raw.githubusercontent.com/mdsaifurrahmann/lemp-stack-gyropilot/main/php8.0-default.conf
		sudo mv default.conf /etc/nginx/conf.d/
		echo 
		echo "$GREEN Done! $END"
		$s1
		#PHPMYADMIN CONF
		echo
		echo "$YELLOW Creating phpMyAdmin Preconfiguration File... $END"
		wget -O phpmyadmin.conf -P ~/ https://raw.githubusercontent.com/mdsaifurrahmann/lemp-stack-gyropilot/main/php8.0-phpmyadmin.conf
		sudo mv phpmyadmin.conf /etc/nginx/conf.d/
		echo 
		echo "$GREEN Done! $END"
		$s1
	;;
esac

#NGINX SERVER BLOCK
echo "$RED
-------------------------------------
|  Creating Nginx Server Block...!  |
-------------------------------------
$END";
echo "$YELLOW Removing /etc/nginx/sites-enabled/default $END"
echo "$BLUE Executing \$sudo rm -f /etc/nginx/sites-enabled/default $END"
sudo rm -f /etc/nginx/sites-enabled/default
echo "$GREEN Done! $END"
$s1
echo

#PHPMYADMIN AREA
echo "$YELLOW Do you want to install phpMyAdmin? Press Y or any key to install and N for skip. [Y/n] $END"
read -p "Will I install phpMyAdmin? : [Y/n]" ipma
case $ipma in
	Y|y) 
		if ! [ -d "/usr/share/phpmyadmin/" ]
		then
			echo "$RED
-------------------------------
|  Installing phpMyAdmin...!  |
-------------------------------
			$END";
			echo "$YELLOW Note: While installing phpMyAdmin, It will ask you to choose a web server.\nWe're executing Nginx as the webserver.\nAnd this option will not be appeared in the list of the webserver on the prompt.\nSo press TAB and Select 'OK' then Hit Enter.\nThe installation will continue after 7 seconds. Please be patient. $END"
			sleep 10s
			${pacm} ${yes} install phpmyadmin
			$s1
			echo
			echo "$YELLOW Creating server block for phpMyAdmin	$END"
			sudo ln -s /usr/share/phpmyadmin/ /var/www/
			sudo systemctl reload nginx
			echo "$GREEN Done! $END"
			$s1
			echo
			echo "$GREEN Try to access phpMyAdmin at localhost/phpmyadmin.\nIf you can't login to root DB user then please reset MariaDB root Password through Terminal.\nIf you don't know how to reset password, then please search on google with keyword: \"reset mariadb root password\".\nNext Step will be appeared after 7 seconds. Please be patient. $END"
			sleep 10s
		else
			echo "$YELLOW phpMyAdmin is already installed!	$END"
			echo
			$s2
		fi
	;;

	N|n)
		echo "$YELLOW Okay! No problem! Skipping phpMyAdmin and removing preconfigured phpMyAdmin files! $END"
		sudo rm -f /etc/nginx/conf.d/phpmyadmin.conf
		echo "$GREEN phpmyadmin.conf file removed $END"
		$s1
	;;

	*)
		echo "$RED Installting phpMyAdmin! $END";
		if ! [ -d "/usr/share/phpmyadmin/" ]
		then
			echo "$RED
-------------------------------
|  Installing phpMyAdmin...!  |
-------------------------------
			$END";
			echo "$YELLOW Note: While installing phpMyAdmin, It will ask you to choose a web server.\nWe're executing Nginx as the webserver.\nAnd this option will not be appeared in the list of the webserver on the prompt.\nSo press TAB and Select 'OK' then Hit Enter.\nThe installation will continue after 7 seconds. Please be patient. $END"
			sleep 10s
			${pacm} ${yes} install phpmyadmin
			$s1
			echo
			echo "$YELLOW Creating server block for phpMyAdmin	$END"
			sudo ln -s /usr/share/phpmyadmin/ /var/www/
			sudo systemctl reload nginx
			echo "$GREEN Done! $END"
			$s1
			echo
			echo "$GREEN Try to access phpMyAdmin at localhost/phpmyadmin.\nIf you can't login to root DB user then please reset MariaDB root Password through Terminal.\nIf you don't know how to reset password, then please search on google with keyword: \"reset mariadb root password\".\nNext Step will be appeared after 7 seconds. Please be patient. $END"
			sleep 10s
		else
			echo "$YELLOW phpMyAdmin is already installed!$END"
			echo
			$s2
		fi
	;;
esac


echo "$YELLOW Do you want to AutoStart Nginx, MariaDB, PHP-FPM on boot? $END"
read -p "Press Y to Enable and N or any key to skip. [Y/n]" sasab

case $sasab in
	Y|y)
		${enable_nginx}
		echo "$RED Asking System to enable Nginx autostart on boot! $END"
		$s2
		echo
		${enable_mariadb}
		echo "$RED Asking System to enable MariaDB autostart on boot! $END"
		$s2
		echo
		${enable_fpm7}
		${enable_fpm8}
		echo "$RED Asking System to enable PHP-FPM autostart on boot! $END"
		$s2
		echo
	;;
	N|n)
		echo "$RED No Problem! Skipping autostart module & We're going ahead. $END"
		$s2
	;;

	*)
		echo "$RED No Problem! Skipping autostart module & We're going ahead. $END"
		$s2
	;;
esac





echo "$RED
--------------------------------------------------
|  Additional Development Environment Setup...!  |
--------------------------------------------------
$END";

echo "$RED
Do you want to install git, build-essential, Node.js 14.x, Composer, Laravel, Vue?
Enter \"G\" to Install GIT Only
Enter \"GB\" to Install GIT & Build-Essential Only
Enter \"YN\" to Install Node.js 14.x Only
Enter \"NC\" to Install Node.js 14.x and Composer Only
Enter \"LV\" to Install Comoser, Laravel and Vue Only
Enter \"Y/y\" to Install all together.
Enter \"N/n\" or Press any key to exit without additional package.
(Default is N. Press any key to exit.)
$END"

read -p "Enter the shortcode to continue. Ex: YGB. Default is N/n:" ades
case $ades in

	G|g) 
		echo "$RED Installting Git Only! $END";
		if ! command -v git
		then
			${pacm} ${yes} install ${git}
			echo "$RED Git installation finished.\nThank you for executing LEMP Stack Gyro pilot. Feel Free to Contribute.\nRegards\nMd. Saifur Rahman$END"
		else
			echo "$RED Git is already installed!\nThank you for executing LEMP Stack Gyro pilot. Feel Free to Contribute.\nRegards\nMd. Saifur Rahman	$END"
		fi
	;;

	
	
	
	GB|gb) 
		echo "$RED Installting Git & Build-Essential Package $END"
		if ! command -v git
		then
			${pacm} ${yes} install ${git}
			echo "$RED Git installation finished.$END"
			$s1
		else
			echo "$RED Git is already installed!$END"
			$s1
		fi
		echo
		if ! [ -d "/usr/share/build-essential/" ]
		then
			${pacm} ${yes} install ${build_essential}
			echo "$RED ${build_essential} installation finished.\nThank you for executing LEMP Stack Gyro pilot. Feel Free to Contribute.\nRegards\nMd. Saifur Rahman	$END"
			$s1
		else
			echo "$RED Build Essential Package is already installed.\nThank you for executing LEMP Stack Gyro pilot. Feel Free to Contribute.\nRegards\nMd. Saifur Rahman $END"
			$s1
		fi
	;;

	
	
	
	YN|yn)
		echo "$RED Installting Node.js v14.x. $END"
		if ! command -v node
		then			
			if ! command -v curl
			then
                		echo "$RED CURL is not found. Installing CURL! $END"
				${pacm} ${yes} install curl
				echo
				echo "$RED Adding Node.js v14.x required repo. to souce. $END"
				$s1
curl -sL https://deb.nodesource.com/setup_14.x | sudo bash -
            		else
               			echo "$YELLOW curl found $END"
                		echo "$RED Adding Node.js v14.x required repo. to source. $END"
					$s1
curl -sL https://deb.nodesource.com/setup_14.x | sudo bash -
				echo
            		fi
			$s1
			echo "$RED Now Installing Node.js v14.x$END"
			${pacm} ${yes} install ${nodejs}
			echo
			echo "$RED ${nodejs} installation finished.$END"
		else
			echo "$RED ${nodejs} is already installed.\nThank you for executing LEMP Stack Gyro pilot. Feel Free to Contribute.\nRegards\nMd. Saifur Rahman $END"
		fi
	;;

	NC|nc) 
		echo "$RED Installing Node.js v14.x and Composer.$END"
		if ! command -v node
		then		
			if ! command -v curl
			then
                		echo "$RED CURL is not found. Installing CURL! $END"
				${pacm} ${yes} install curl
				echo "$RED Adding Node.js v14.x required repo. $END"
curl -sL https://deb.nodesource.com/setup_14.x | sudo bash -
            		else
				echo "$YELLOW curl found $END"
				echo "$RED Adding Node.js v14.x required repo. $END"
curl -sL https://deb.nodesource.com/setup_14.x | sudo bash -
            		fi
			$s1
			echo "$RED Now Installing Node.js v14.x$END"
			${pacm} ${yes} install ${nodejs}
			echo
			echo "$RED ${nodejs} installation finished. $END"
		else
			echo "$RED ${nodejs} is already installed. $END"
		fi
		
		#Composer
		if ! command -v composer
		then
			echo "$RED Installing Composer! $END"
			php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
			php -r "if (hash_file('sha384', 'composer-setup.php') === '756890a4488ce9024fc62c56153228907f1545c228516cbf63f885e036d37e9a59d27d63f46af1d4d07ee0f76181c7d3') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
			sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer
			php -r "unlink('composer-setup.php');"
			echo "$RED composer installation finished.$END"
		else
			echo "$RED composer is already installed.\nThank you for executing LEMP Stack Gyro pilot. Feel Free to Contribute.\nRegards\nMd. Saifur Rahman $END"
		fi
	;;

	LV|lv) 
		echo "$RED Installing Composer, Laravel and Vue.js.$END"
		if ! command -v composer
		then
			echo "$RED Installing Composer! $END"
 			php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
			php -r "if (hash_file('sha384', 'composer-setup.php') === '756890a4488ce9024fc62c56153228907f1545c228516cbf63f885e036d37e9a59d27d63f46af1d4d07ee0f76181c7d3') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
 			sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer
 			php -r "unlink('composer-setup.php');"
			echo "$RED composer installation finished.	$END"
		else
			echo "$RED composer is already installed.$END"
		fi
		
		
		if ! command -v laravel
		then
			echo "$RED Installing Laravel CLI! $END"
			composer global require laravel/installer
printf 'export PATH="~/.config/composer/vendor/bin:$PATH"' >> ~/.bashrc
			echo "$RED Laravel installation finished.$END"
		else
			echo "$RED Laravel is already installed. $END"
		fi
		
		
		#VUE
		if ! command -v vue
		then
			if command -v node
			then
				echo "$RED Installing Vue Cli! $END"
				sudo npm install -g @vue/cli
				$s1
				echo "$RED Vue Cli installation finished.$END"
				$s1
			else
				echo "$YELLOW Node.js not found. Installing Node.js first! $END"
				if command -v curl
					then
					echo "$RED Adding Node.js v14.x required repo. $END"
curl -sL https://deb.nodesource.com/setup_14.x | sudo bash -
				else
					echo "$RED CURL is not found. Installing CURL! $END"
					${pacm} ${yes} install curl
					echo "$RED Adding Node.js v14.x required repo. $END"
curl -sL https://deb.nodesource.com/setup_14.x | sudo bash -
				fi
				$s1
				echo "$RED Now Installing Node.js v14.x$END"
				$s1
				${pacm} ${yes} install ${nodejs}
				echo
				echo "$RED ${nodejs} installation finished.	$END"
				$s1
				echo "$RED Now Installing Vue Cli $END"
				$s1
				sudo npm install -g @vue/cli
				echo
				echo "$RED Vue Cli installation finished. $END"
			fi
		else
			echo "$YELLOW Operation Complete!\nThank you for executing LEMP Stack Gyro pilot. Feel Free to Contribute.\nRegards\nMd. Saifur Rahman$END"
		fi
	;;

	Y|y) 
		echo "$RED Copy That! I'm Installing All the packages right now! $END"
		#GIT
		if ! command -v git
		then
			${pacm} ${yes} install ${git}
		else
			echo "$YELLOW Git is already installed!	$END"
		fi

		#NODEJS
		echo "$RED Installting Node.js v14.x. $END"
		if ! command -v node
		then
			if command -v curl
			then
				echo "$RED Adding Node.js v14.x required repo. to source. $END"
curl -sL https://deb.nodesource.com/setup_14.x | sudo bash -
			else
				echo "$RED CURL is not found. Installing CURL! $END"
				${pacm} ${yes} install curl
				echo "$RED Adding Node.js v14.x required repo. to source. $END"
curl -sL https://deb.nodesource.com/setup_14.x | sudo bash -
			fi
			$s1
			echo "$RED Now Installing Node.js v14.x$END"
			$s1
			${pacm} ${yes} install ${nodejs}
			echo "$RED ${nodejs} installation finished.$END"
		else
			echo "$RED ${nodejs} is already installed.$END"
		fi


		#BUILED-ESSENTIAL
		if ! [ -d "/usr/share/doc/build-essential/" ]
		then
			${pacm} ${yes} install ${build_essential}
		else
			echo "$YELLOW Build Essential Package is already installed. $END"
		fi

		#COMPOSER
		if ! command -v composer
		then
			echo "$RED Installing Composer! $END"
			php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
			php -r "if (hash_file('sha384', 'composer-setup.php') === '756890a4488ce9024fc62c56153228907f1545c228516cbf63f885e036d37e9a59d27d63f46af1d4d07ee0f76181c7d3') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
			sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer
			php -r "unlink('composer-setup.php');"
		else
			echo "$YELLOW Composer is installed! $END"
		fi

		#LARAVEL
		if ! command -v laravel
		then
			echo "$RED Installing Laravel CLI! $END"
			composer global require laravel/installer
printf 'export PATH="~/.config/composer/vendor/bin:$PATH"' >> ~/.bashrc
		else
			echo "$YEELOW Laravel is already installed! $END"
		fi

		#VUE
		if ! command -v vue
		then
			if command -v node
			then
				echo "$RED Installing Vue Cli! $END"
				sudo npm install -g @vue/cli
			else
				echo "$YELLOW Node.js not found. Installing Node.js first! $END"
				if command -v curl
				then
				echo "$RED Adding Node.js v14.x required repo. $END"
curl -sL https://deb.nodesource.com/setup_14.x | sudo bash -
				else
					echo "$RED CURL is not found. Installing CURL! $END"
					${pacm} ${yes} install curl
					echo "$RED Adding Node.js v14.x required repo. $END"
curl -sL https://deb.nodesource.com/setup_14.x | sudo bash -
				fi
				$s1
				echo "$RED Now Installing Node.js v14.x$END"
				$s1
				${pacm} ${yes} install ${nodejs}
				echo
				echo "$RED Now Installing Node.js v14.x$END"
				$s1
				sudo npm install -g @vue/cli
				echo "$RED Vue Clie installation finished.\nThank you for executing LEMP Stack Gyro pilot. Feel Free to Contribute.\nRegards\nMd. Saifur Rahman	$END"
			fi
		else
			echo "$YELLOW Operation Completed!\nThank you for executing LEMP Stack Gyro pilot. Feel Free to Contribute.\nRegards\nMd. Saifur Rahman$END"
		fi
	;;

	N|n) 
		echo "$RED Okay! No Problem! Exiting Gyro pilot.\nThanks for Executing ME!\n Regards\nMd. Saifur Rahman $END" & exit
	;;

	*) 
		echo "$RED Okay! No Problem! Exiting Gyro pilot.\nThanks for Executing ME!\n Regards\nMd. Saifur Rahman $END" & exit
	;;
esac

echo "$GREEN Clearing additional Dependency packeges! $END"
sudo apt autoremove
sudo rm -f ~/gyropilot.sh
exit
