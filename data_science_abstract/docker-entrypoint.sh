#!/bin/bash

# Start SSH
echo "Open SSH server"
sudo /etc/init.d/ssh start
echo "SSH server opened"

# Start MySQL
echo "Starting MySQL"
sudo chown -R mysql:mysql /var/lib/mysql
sudo sed -i "/bind-address/c\bind-address = 0.0.0.0" /etc/mysql/mysql.conf.d/mysqld.cnf
sudo /etc/init.d/mysql restart
echo "MySQL started"

# Create MySQL database
#echo "Creating MySQL database"
#sudo mysql -u root "use mysql;
#CREATE USER 'core_user'@'localhost' IDENTIFIED BY '';
#GRANT ALL PRIVILEGES ON *.* TO 'core_user'@'localhost';
#UPDATE user set plugin='auth_socket' where user = 'core_user';
#FLUSH PRIVILEGES;
#exit;"
#sudo service mysql restart

# Setup Jupyter Notebook
echo "Setting up Jupyter notebook"
jupyter notebook --generate-config --ip 0.0.0.0 --no-browser --allow-root --port 8888 --NotebookApp.token=''
sed -i "/c.NotebookApp.ip/c\c.NotebookApp.ip = '*'" /home/core_user/.jupyter/jupyter_notebook_config.py
sed -i "/c.NotebookApp.open_browser/c\c.NotebookApp.open_browser = False" /home/core_user/.jupyter/jupyter_notebook_config.py
sed -i "/c.NotebookApp.token/c\c.NotebookApp.token = u''" /home/core_user/.jupyter/jupyter_notebook_config.py
sed -i "/c.NotebookApp.allow_remote_access/c\c.NotebookApp.allow_remote_access = True" /home/core_user/.jupyter/jupyter_notebook_config.py
echo "Set up Jupyter notebook"

# Final Logic
