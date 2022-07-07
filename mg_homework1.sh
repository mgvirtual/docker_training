sudo sysctl -w vm.max_map_count=262144
sudo systemctl restart docker

docker volume create --name sonarqube_data
docker volume create --name sonarqube_logs
docker volume create --name sonarqube_extensions

docker volume create --name postgres_data

docker network create sonarqube_network

docker run --name postgres -e POSTGRES_USER=mg-postgres -e POSTGRES_PASSWORD=p@$$ -e POSTGRES_DB=mg_db --network sonarqube_network -v postgres_data:/var/lib/postgresql/data -d postgres:latest

docker run --name mg-sonarqube -p 9000:9000 -e sonar.jdbc.url=jdbc:postgresql://postgres:5432/postgres -e sonar.jdbc.username=mg-postgres -e sonar.jdbc.password=p@$$ -v sonarqube_data:/opt/sonarqube/data -v sonarqube_extensions:/opt/sonarqube/extensions -v sonarqube_logs:/opt/sonarqube/logs --network sonarqube_network -d sonarqube:latest

docker run --name mg-jenkins -d -v jenkins_home:/var/jenkins_home -p 8080:8080 -p 50000:50000 --restart=on-failure jenkins/jenkins:lts-jdk11

docker run -d -p 8081:8081 --name mg-nexus -v nexus_data:/nexus-data sonatype/nexus3

docker run --name mg-portainer -d -p 8000:8000 -p 9443:9443 --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:2.9.3