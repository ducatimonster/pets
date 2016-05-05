#Setting Up PETS (Pet Entry Tracking System)#
These notes will guide the user through the download and installation process of PETS. This application has been developed and tested with the following versions. Using versions earlier than the ones specified below could potentially cause errors within the application. Future versions should typically not cause problems and should be compatible with these versions. The instructions below should allow the user to install the latest stable release of each of the required applications.
The instructions specified below will allow the user to install and use the application locally for Windows, and both locally and a server for Linux.
##Minimum requirements for PETS##
###Operating Systems###
* Windows – Windows 7
* Linux – Ubuntu 14.04.1
###Frameworks and Languages:
* Ruby – 1.9.3
* Rails – 4.2.5.1
* Nokogiri – 1.6.7.2
* Node JS – 4.2.6
###Databases###
* Sqlite3 - 3.8.9
##Pre-Installation Steps##
Below are the application requirements needed in order to download and run PETS. 
##Windows##
####Ruby####
Navigate to http://rubyinstaller.org/ and install one of the versions identified above.
Add Ruby to the environment variables path. (http://johnatten.com/2014/12/07/adding-and-editing-path-environment-variables-in-windows/ )
####Rails####
Open command prompt type the following:
```
gem install rails --no-rdoc --no-ri
rbenv rehash
rails –v
```
####Nokogiri####
```
gem install nokogiri
```
####NodeJS####
Install from: https://nodejs.org/en/download/
####SQLite####
Create a directory on the C drive
Download the binary from http://www.sqlite.org/2015/sqlite-shell-win32-x86-3081101.zip and the DLL from https://www.sqlite.org/2015/sqlite-dll-win32-x86-3081101.zip and unzip both into the sqlite3 directory you created.

Add the directory to your path. If you do not know how to modify the path, see http://typecastexception.com/post/2014/12/07/Adding-and-Editing-PATH-Environment-Variables-in-Windows.aspx.
Open a command prompt and type 
```
sqlite3
``` 
You should see the sqlite prompt if everything worked correctly. Type Control-C to exit.
##Linux ##
Note: You will need “Sudo” privileges in order to install on the Linux server
Ruby
Update the apt-get call. Open a terminal and type:
```
sudo apt-get update
```
####Ruby####
```
sudo apt-get install ruby-full
```
####Node JS####
```
sudo apt-get install nodejs
```
####Nokogiri####
```
gem install nokogiri
```
####Rails####
```
gem install rails
```
*The steps up to this point will allow the user to run PETS locally. Please continue these instructions if you wish to install PETS as a server configuration. These instructions assume the path for the installation will be “/var/www/pets” but this can be changed at any time*
###Server Installation###
####Unicorn####
``` 
gem install unicorn 
```
Open the Unicorn configuration file
```
nano config/unicorn.rb
```
Copy this configuration and paste over the current configuration:
```
# Set the working application directory
# working_directory "/path/to/your/app"
working_directory "/var/www/pets"

# Unicorn PID file location
# pid "/path/to/pids/unicorn.pid"
pid "/var/www/pets/pids/unicorn.pid"

# Path to logs
# stderr_path "/path/to/log/unicorn.log"
# stdout_path "/path/to/log/unicorn.log"
stderr_path "/var/www/pets/log/unicorn.log"
stdout_path "/var/www/pets/log/unicorn.log"

# Unicorn socket
listen "/tmp/unicorn.[pets].sock"
listen "/tmp/unicorn.pets.sock"

# Number of processes
# worker_processes 4
worker_processes 2

# Time-out
timeout 30
```
Save and exit by pressing CTRL+X and confirming with Y.
####Nginx####
```
Sudo apt-get install -y nginx
```
Open the Nginx configuration file
```
nano /etc/nginx/conf.d/default.conf
```
Copy this configuration and paste over the current configuration:
```
upstream app {
    # Path to Unicorn SOCK file, as defined previously
    server unix:/tmp/unicorn.pets.sock fail_timeout=0;
}

server {


    listen 80;
    server_name localhost;

    # Application root, as defined previously
    root /root/pets/public;

    try_files $uri/index.html $uri @app;

    location @app {
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header Host $http_host;
        proxy_redirect off;
        proxy_pass http://app;
    }

    error_page 500 502 503 504 /500.html;
    client_max_body_size 4G;
    keepalive_timeout 10;
}  
```
Save and exit by pressing CTRL+X and confirming with Y
Restart Nginix:
```
service nginx restart
```
##Deploy PETS##
Determine where you would like the files to be placed. For Linux Server option, the default instructions are “/var/www/pets” *
Download and unzip the latest stable version of PETS into the specified folder : https://bitbucket.org/twoconsulting/hotdog/get/767734e41217.zip
For both Windows and Linux, open command prompt or the terminal and type:
```
CD “my/file/path”
```
where “my/file/path” is the root folder of the PETS directory
###To run locally###
Start Rails 
```
rails s
``` 
This starts the application process.
In any web browser, navigate to “http://localhost:3000/” and the application should appear.
###To run as a server###
Start Unicorn server 
```
unicorn_rails
```
In any web browser and on any computer on the same network as the server, navigate to http://MyComputerName, where MyComputerName is the name of the computer. 
To stop rails go back to the terminal or command prompt and type “CTRL + C” to stop the application.