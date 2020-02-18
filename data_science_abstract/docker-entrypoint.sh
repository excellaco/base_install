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

# Create MySQL database
echo "Creating MySQL database"
mysql -uroot -e "CREATE DATABASE core;
CREATE USER 'core_user'@'localhost';
GRANT ALL PRIVILEGES ON *.* TO 'core_user'@'localhost' WITH GRANT OPTION;
CREATE USER 'core_user'@'%';
GRANT ALL PRIVILEGES ON *.* TO 'core_user'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;"

# Setup Jupyter Notebook
echo "Setting up Jupyter notebook"
jupyter notebook --generate-config
jupyter notebook --ip 0.0.0.0 --no-browser
sed -i "/c.NotebookApp.ip/c\c.NotebookApp.ip = '*'" /home/core_user/.jupyter/jupyter_notebook_config.py
sed -i "/c.NotebookApp.open_browser/c\c.NotebookApp.open_browser = False" /home/core_user/.jupyter/jupyter_notebook_config.py
sed -i "/c.NotebookApp.token/c\c.NotebookApp.token = u''" /home/core_user/.jupyter/jupyter_notebook_config.py
sed -i "/c.NotebookApp.allow_remote_access/c\c.NotebookApp.allow_remote_access = True" /home/core_user/.jupyter/jupyter_notebook_config.py
echo "Set up Jupyter notebook"