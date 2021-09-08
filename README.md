# Tomcat-ref

Le but de ce script est de générer un container Tomcat de réference avec la possibilité d'envoyer les logs vers un serveur logstash.

Le script est à utiliser en dehors du répertoire git. Le script est à modifier pour les répertoires et adresse des serveurs.

Le fichier server.xml est une version modifiée, avec une redirection des logs vers le std afin que docker puisse lire les logs d'accès.

Une application sample provenant du site de tomcat, est mise à disposition pour vérifier que le container est fonctionnel.

Pour Filebeat et Logstash des répertoires sont disponibles : 

Filebeat :
git clone https://github.com/BudNatsu/Filebeats.git

Logstash :
git clone https://github.com/BudNatsu/logstash.git

Si aucun Kibana et elasticsearch n'a été mis en place vous pouvez les mettre en place :
Attention essayez d'harmoniser les différentes version des produits.

docker network create elastic
Il est conseillé de créer et d'utiliser un réseau dédié, avec l'option "--net elastic" et de définir ce même réseau dans filebeat et logstash

Kibana :
docker run --name kib01-test --net elastic -p 5601:5601 -e "ELASTICSEARCH_HOSTS=elasticsearch:9200" docker.elastic.co/kibana/kibana:7.13.4

Elasticsearch : 
docker run --net elastic -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" docker.elastic.co/elasticsearch/elasticsearch:7.13.4

Note si durant le docker-compose, ce message apparaît : networks.elastic value Additional properties are not allowed ('name' was unexpected)
Pensez à mettre à jour votre docker-compose.
