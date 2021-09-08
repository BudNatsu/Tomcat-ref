#/bin/bash

echo "Lancement du script de création de docker-compose"
echo "Quel nom souhaitez vous utiliser ?"
read -e nom


read -e -p "Où souhaitez-vous créer ce répertoire ?" -i "à modifier" rep

echo "Création du répertoire $nom dans $rep"
if [[ -d "$nom" ]]
then
    echo "$nom existe déjà arrêt du programme"
    exit
else
    mkdir $rep/$nom 
fi
sudo chmod 774 $rep/$nom
echo $rep/$nom
dc="$rep/$nom"
cd $dc
#Une fois dans le nouveau répertoire, on créer le dossier log, car si on le laisse dans le docker-compose.yml, si on éteint et redemarre le container celui-ci ne se relancera pas à cause du dossier.
mkdir log
sudo chmod 774 log

#read -e -p "Chemin du docker compose à utiliser :" -i "à modifier" docker
#cp $docker/* $dc

git clone https://github.com/BudNatsu/Tomcat-ref.git
cd Tomcat-ref/
#cp $docker/docker-compose.yml $dc
#cp $docker/.env $dc
#cp $docker/sample.war $dc
echo "container_name=$nom" >> $dc/Tomcat-ref/.env

read -e -p "Adresse d'elasticsearch :" -i "à modifier" elasticsearch
echo "ELASTICSEARCH_HOSTS=$elasticsearch:9200" >> $dc/Tomcat-ref/.env

read -e -p "Adresse de kibana :" -i "à modifier" kibana 
echo "KIBANA_HOST=$kibana:5601" >> $dc/Tomcat-ref/.env

read -e -p "Adresse de logstash :" -i "à modifier" kibana 
echo "LOGSTASH_HOST=$kibana:5044" >> $dc/Tomcat-ref/.env

docker-compose up -d
