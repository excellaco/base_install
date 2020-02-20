#!/bin/bash

# Check Variables
echo "Checking Variables"
echo "$1"
echo "$2"
echo "$3"
echo "$4"
echo "Checked Variables"

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

# Setup Jupyter Notebook
echo "Setting up Jupyter notebook"
jupyter notebook --generate-config --ip 0.0.0.0 --no-browser --allow-root --port 8888 --NotebookApp.token=''
sed -i "/c.NotebookApp.ip/c\c.NotebookApp.ip = '*'" /home/core_user/.jupyter/jupyter_notebook_config.py
sed -i "/c.NotebookApp.open_browser/c\c.NotebookApp.open_browser = False" /home/core_user/.jupyter/jupyter_notebook_config.py
sed -i "/c.NotebookApp.token/c\c.NotebookApp.token = u''" /home/core_user/.jupyter/jupyter_notebook_config.py
sed -i "/c.NotebookApp.allow_remote_access/c\c.NotebookApp.allow_remote_access = True" /home/core_user/.jupyter/jupyter_notebook_config.py
echo "Set up Jupyter notebook"

# Final Logic

if [ "$1" = "DEBUG" ];
	then
		echo "DEBUG MODE"
		bash
	else
		echo "PRODUCTION MODE"
		cd $2
		$3 $4
fi;