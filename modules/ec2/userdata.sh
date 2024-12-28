#!/bin/bash
# hvac 2>&1 | tee -a /opt/userdata.log

pip3.11 install ansible
ansible-pull -i localhost, -U https://github.com/Shefali-DevOps/roboshop-ansible main.yml -e env=${env} -e role_name=${role_name} -e vault_token=${vault_token} 2>&1 | tee -a /opt/userdata.log