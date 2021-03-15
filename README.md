**main.tf** :
      - Creates instance and Private Key pair. Executes shell script in the instance
      
**provider.tf** :
      - Add Secret and Access key in providers.tf
      
**script.sh** :
      - The shell script installs elasticsearch on EC2, enables user authentication and TLS
      
**tfvars.tf** :
      - All the variables used in terraform files
      
**vpc.tf** :
      - Created VPC, Subnet, Internet Gateway, Route Table, Security Group
      
1. Used remote-exec to do the bootstrapping, Remote-exec executes shell script into the instance by remotely taking ssh and runs the script.
2. ELasticsearch is secured by two ways, a. It is configured using username and password to login and b. Used TLS to ensure that communication between HTTP clients and the cluster is encrypted
3. The Elastic Stack monitoring features consist of two components: an agent that you install on each Elasticsearch node and a Monitoring UI in Kibana
4. Will need to generate Node certificate for each node and enable TLS on the transport layer.
5. Yes.
6. Yes its easy to read and understand and anyone can easily make changes into the code.
7. Haven't worked on Elasticsearch earlier so explored it from scratch. And managed to work on the assignement parallely for 2 days.
