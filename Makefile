#### PROVISIONING ####
provision-development:
	ansible-playbook -i devops/provisioning/development devops/provisioning/site.yml --private-key ~/side/streambacker-server/.vagrant/machines/streambacker-server/virtualbox/private_key

provision-development-no-packages:
	ansible-playbook -i devops/provisioning/development devops/provisioning/site.yml --private-key ~/side/streambacker-server/.vagrant/machines/streambacker-server/virtualbox/private_key --skip-tags=packages

# provision-staging:
# 	ansible-playbook -i devops/provisioning/staging devops/provisioning/site.yml --private-key ../pepiniere-mothership/pepiniere.pem
