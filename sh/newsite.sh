#!/bin/bash

if [ -n "$1" ]; then
    echo "Create website public directory...";
    sudo mkdir -p /var/www/$1/log
    sudo mkdir -p ~/projects/php/$1/{backup,design}
    echo "...done.";
    echo "";
    echo "Set website public directory permissions...";
    sudo chown -R www-data:www-data /var/www/$1
    sudo chmod -R g+rw /var/www
    echo "...done.";
    echo "";
    echo "Add apache available website...";
    echo "Write config:";
    (
        echo "<VirtualHost *:80>";
        echo "    ServerAdmin webmaster@$1.lo";
        echo "    ServerName $1.lo";
        echo "    ServerAlias www.$1.lo";
        echo "    DocumentRoot /var/www/$1";
        echo "    <Directory /var/www/$1/>";
        echo "        Options Indexes FollowSymLinks MultiViews";
        echo "        AllowOverride All";
        echo "        Order allow,deny";
        echo "        allow from all";
        echo "    </Directory>";
        echo "    #LogLevel info ssl:warn";
        echo "    ErrorLog /var/www/$1/log/error.log";
        echo "    CustomLog /var/www/$1/log/access.log combined";
        echo "    #Include conf-available/serve-cgi-bin.conf";
        echo "</VirtualHost>";
    ) | sudo tee /etc/apache2/sites-available/$1.conf
    echo "...done.";
    echo "";
    echo "Enable website...";
    sudo a2ensite $1.conf
    echo "...done.";
    echo "";
    echo "Append available hosts...";
    echo "127.0.0.1        $1.lo" | sudo tee -a /etc/hosts;
    echo "...done.";
    echo "";
    echo "Restart apache service...";
    sudo service apache2 restart
    echo "...done.";
    echo "";
    read -p "Would you like to create a same MYSQL database (y/n)? " choice
    case "$choice" in
        y|Y )
            read -s -p "Enter your MySQL password (ENTER for none): " sqlpasswd;
            if [ -n "$sqlpasswd" ]; then
                mysql -uroot -p$sqlpasswd -e "create database $1"
            else
                mysql -uroot -e "create database $1"
            fi;;
        * );;
    esac
    echo "...done.";
    echo "";
    echo "Now you can view your new website at http://$1.lo/";
    echo "All done.";
    echo "Have a nice day :)";
    echo "";
else
    echo "Site name cann't be empty.";
fi;
