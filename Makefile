.PHONY: lamp_stack venv init app

help:
	@echo ""
	@echo "lamp_stack: Update Linux packages and modify Linux files."
	@echo "init: Create directories and import packages."
	@echo "flask_app: run Flask app"

lamp_stack:
	sudo apt-get update
	sudo apt-get upgrade
	sudo apt-get -y install apache2
	sudo apt-get -y install libapache2-mod-wsgi python-dev
	sudo apt-get -y install mysql-client mysql-server
	sudo mysql_secure_installation
	sudo apt -y install php libapache2-mod-php
	sudo systemctl restart apache2
	sudo apt-get -y install python3-pip

	@echo "***************************************"
	@echo "FILE MODIFICATIONS"
	@echo "***************************************"
	@echo ""
	@echo "File: /etc/apache2/mods-enabled/dir.conf: "
	@echo "		add index.php to the beginning of index files. It'll be in there twice."
	@echo ""
	@echo "File: /etc/ssh/sshd_config "
	@echo "		Modify param ClientAliveInterval to 3600, "
	@echo "		then execute the following from command line: "
	@echo ""
	@echo "			sudo systemctl restart ssh"

venv:
	pip3 install virtualenv
	export PATH="/home/ubuntu/.local/bin:$PATH"
	virtualenv venv
	source venv/bin/activate

init:
	pip install -r requirements.txt

app:
	python3 app/hello.py