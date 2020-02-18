#!/bin/bash

# Start SSH
echo "Open SSH server"
sudo /etc/init.d/ssh start
echo "SSH server opened"

# Start MySQL
echo "Starting MySQL"
sudo chown -R mysql:mysql /var/lib/mysql
sudo sed -i "/bind-address/c\bind-address = 0.0.0.0" /etc/mysql/mysql.conf.d/mysqld.cnf
sudo /etc/init.d/mysql start
echo "MySQL started"

# Create core_user for MySQL database
echo "Creating core_user in MySQL Database"
CREATE USER 'core_user'@'localhost';
GRANT ALL PRIVILEGES ON *.* TO 'core_user'@'localhost' WITH GRANT OPTION;
CREATE USER 'core_user'@'%';
GRANT ALL PRIVILEGES ON *.* TO 'core_user'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;"

# Srtup Jupyter Notebook
jupyter notebook --generate-config
sed -i "/c.NotebookApp.ip/c\c.NotebookApp.ip = '*'" /home/ubuntu/.jupyter/jupyter_notebook_config.py
sed -i "/c.NotebookApp.open_browser/c\c.NotebookApp.open_browser = False" /home/ubuntu/.jupyter/jupyter_notebook_config.py
sed -i "/c.NotebookApp.token/c\c.NotebookApp.token = u''" /home/ubuntu/.jupyter/jupyter_notebook_config.py
sed -i "/c.NotebookApp.allow_remote_access/c\c.NotebookApp.allow_remote_access = True" /home/ubuntu/.jupyter/jupyter_notebook_config.py

# Welcome screen
echo python3 --version 
echo mysql --version