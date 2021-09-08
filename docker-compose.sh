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
sudo chmod 644 $rep/$nom
echo $rep/$nom
dc="$rep/$nom"
cd $dc
#Une fois dans le nouveau répertoire, on créer le dossier log, car si on le laisse dans le docker-compose.yml, si on éteint et redemarre le container celui-ci ne se relancera pas à cause du dossier.
mkdir -p /opt/pod/$nom/log
sudo chmod 644 /opt/pod/$nom/log

#read -e -p "Chemin du docker compose à utiliser :" -i "à modifier" docker
#cp $docker/* $dc

git clone https://github.com/BudNatsu/Tomcat-ref.git
cd Tomcat-ref/

mv * ../
cd ..
rm -rf Tomcat-ref/

echo "container_name=$nom" >> $dc/.env

read -e -p "Adresse d'elasticsearch :" -i "à modifier" elasticsearch
echo "ELASTICSEARCH_HOSTS=$elasticsearch:9200" >> $dc/.env

read -e -p "Adresse de kibana :" -i "à modifier" kibana 
echo "KIBANA_HOST=$kibana:5601" >> $dc/.env

read -e -p "Adresse de logstash :" -i "à modifier" logstash 
echo "LOGSTASH_HOST=$logstash:5044" >> $dc/.env

docker-compose up -d
