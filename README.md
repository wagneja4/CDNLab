# CDNLab
This is wagneja4's configuration of some popular services. The infrastructure is deployed with ansible. It is by no means perfect, I still have much to learn.

Files which should be modified before use:\
./inventory/hosts ~ modify the ips of hosts and ip variables.\
batch-playbook.bash ~ relevant env. variables\
./ansible/variables/ correct ips

Then there is script batch-playbook.sh provided for easy replication of all containers.
