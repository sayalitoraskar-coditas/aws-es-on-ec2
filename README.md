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
      
1. What did you choose to automate the provisioning and bootstrapping of the instance? Why? 
- Used remote-exec to do the bootstrapping, Remote-exec executes shell script into the instance by remotely taking ssh and runs the script.
2. How did you choose to secure ElasticSearch? Why?
- ELasticsearch is secured by two ways, a. It is configured using username and password to login and b. Used TLS to ensure that communication between HTTP clients and the cluster is encrypted
3. How would you monitor this instance? What metrics would you monitor?
- The Elastic Stack monitoring features consist of two components: an agent that you install on each Elasticsearch node and a Monitoring UI in Kibana (Havent configured Kibana and monitoring but can be further modify terraform as such)
4. Could you extend your solution to launch a secure cluster of ElasticSearch nodes? What
would need to change to support this use case?
- Will need to generate Node certificate for each node and enable TLS on the transport layer.
5. Could you extend your solution to replace a running ElasticSearch instance with little or no
downtime? How?
- Yes.
6. Was it a priority to make your code well structured, extensible, and reusable?
- Yes its easy to read and understand and anyone can easily make changes into the code.
7. What sacrifices did you make due to time?
- Haven't worked on Elasticsearch earlier so explored it from scratch. And managed to work on the assignement parallely with other work for 2 days.
