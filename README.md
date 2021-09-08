# Tomcat-ref

Le but de ce script est de générer un container Tomcat de réference avec la possibilité d'envoyer les logs vers un serveur logstash.

Le script est à utiliser en dehors du répertoire git.

Le fichier server.xml est une version modifiée, avec une redirection des logs vers le std afin que docker puisse lire les logs d'accès.

Une application sample provenant du site de tomcat, est mise à disposition pour vérifier que le container est fonctionnel.
