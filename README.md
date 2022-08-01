# CDNLab
This is wagneja4's configuration of some popular services. The infrastructure is deployed with ansible.

Files which needs to be modified before use:
- ./inventory/hosts ~ Modify the IPs of hosts and IP variables.
- batch-playbook.bash ~ Set relevant env. variables
- ./ansible/variables/ ~ Enter correct IPs

Then there is script batch-playbook.sh provided for easy replication of all containers.

### Wireguard
All containers are connected with central node, which then forwards traffic to other nodes on the network (by allowed ip range). Other connections (outside VPN ip range) goes via default route. WG keys are staticaly pregenerated (room for improvement, it probably should be generated anew with each deploy)

### Prometheus
The Prometheus nodes scrapes other nodes (Wireguard node, Nginx-proxy node and Zookeeper nodes). The web interface is on \<PrometheusIP\>:9090. **This node also has local logging** of some metrics of other containers via Ansible, which retreaves JSON with data and logs it in journalctl. The current implementation is with ansible.builtin.script. The logging to journalctl should be changed to logging to local append only file for easier parsing...

### Nginx
There two nodes. Web and a caching proxy. Web is an upstream node for proxy, which only serves the proxy. This is a design choice because it provides better for horizontal scaling. The origin serves static files (with some example files) in a local directory which is accesible at 'http://\<NginxProxyIP\>/' 

### Zookeeper
The zookeeper distributed system (with 5 nodes) should be resistant to 2 node failuire (if I understand the zab consensus protocol correctly). For zab to reach a consensus it needs to be able to form a quorum. Size of quorum is $ \lfloor{n \over 2}\rfloor + 1$. So in case of 2 node failuire, it the number of nodes must satisfy $ n -( \lfloor{n \over 2}\rfloor + 1) \geq 2 $. The smallest number satysfying it is $n=5$.

### Firewall
There are some aproaches to firewall policies. The two mains ones are permisive and restrictive. The permisive allows everything, except the forbiden. The restrictive forbids everything except the allowed. My opinion is, that having restrictive firewall is a basic security practise. 

#### Example configurations for restrictive firewalls
- Default policy DROP
- Allow basic ports DNS-53, 80-http/443-https, ntp-123
- Allow incoming ssh from public IP or VPN, remember them in statefull firewall
- Allow outgoing ssh only for answer packets RELATED,ESTABLISHED connections, not NEW.
- For Prometheus node open different ssh port, allow inside VPN only
- Allow internal service ports (prometheus metrics, nginx stub, nginx upstream, ...), only for communication inside vpn. DROP all connections from outside vpn for those ports

#### Other security practises...
- Only needed packages installed
- Use sudo or alternatives on Debians (dont use su)
- Users and groups for services with nologin
- Fail2ban or alternative for discouraging ssh bruteforce
- no ssh root login, using nondefault ssh port, key-only auth, ...

### Network configuration
I added a container with DNS node. It is VPN only node, but it could have been split DNS to save some configuration struggles. Ideal configuration would be 2-way split DNS with DHCP 'A' entry update. So nodes could have dynamic IPs that would be bounded to domain name instead of static IPs.

This configuration takes inital IP and configures it static. This is so services dont have outdated IPs in their conf files. The best solution (as I meantioned) would be to have everything on domain names. But some of the services dont support that (Wireguard, free version of Nginx...), So I decided to do it this way in the demo.

### Daemontools vs. systemd
In this implementation I decided to use systemd for all services. I didnt feel like I understood daemontools well enough (or at all) to write the services in them.


### Ansible playbooks
The Ansible playbooks are not of highest quality, I can tell by myself. But this is my first Ansible project and I have not yet grasped the best practies and workflows. There are unnecesary complications, that I dislike (like the variables in ansible hosts...)