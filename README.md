# Environnement Infra PHP FPM / Mariadb / Nginx / PhpMyAdmin avec Docker

1. 
    ## Bash / DL l'environnement
    ``` 
    git clone https://github.com/MickeySaltis/Environnement-Infra-PHP-FPM-Mariadb-Nginx-PhpMyAdmin-avec-Docker "nom du projet" 
    ```



2. 
    ## Bash / Préparer son projet
    ```
    cd "nom du projet"
    mkdir app
    touch app/index.php
    ```



3. 
    ## Bash / Démarrer le projet
    ```make start``` ou ```docker-compose up``` pour le premier démarrage



4. 
    ## Bash / Arrêter le projet
    ```make stop```



5. 
    # Bash / NPM
    ```
    sudo apt install curl -y # Installer curl

    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
    export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")" # Télécharger NVM

    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # Charge NVM 

    source .profile # Recharger le fichier .profile
    source .bashrc  # Recharger le fichier .bashrc

    nvm install --lts # Installer NodeJS/NPM sur la dernière version stable
    ```
    ```
    npm init                     # Créer un projet NPM
    npm install --save bootstrap # Installer Bootstrap
    npm install --save jquery    # Installer Jquery
    npm install --global gulp    # Installer Gulp
    ```
    A la création d'un projet NPM, le fichier `package.json` est créé avec les informations du projet comme ses dépendances.
    -> Indiquer `node_modules` dans `.gitignore`



    ## Installer les dépendances du projet après un `git clone`.
    ``` npm install ```   
  
  
  
    ## Mettre à jour les dépendances du projet.
    ``` npm update ``` ou ``` npm update "nom de la dépendance" ```  
    
    ### Soucis avec l'upload de fichier dans le projet ?
    Regarder du côté de SELinux
    3 niveaux de sécurités (Enforcing/Permissive/Disabled)
    #### Bash
        
        ``` getenforce # Mode actuelle sur l'ordinateur ```
        ``` setenforce 0 # Mode permissive jusqu'à redémarrage de l'ordinateur ```
        
        
     Modifier manuellement le fichier SELinux
        - le fichier se situe: `/etc/sysconfig/selinux`
        - modifier la ligne `SELINUX=enforcing` par `SELINUX=permissive`
        - redémarrer l'ordinateur
        
      ##### Attention 
      - Il est très déconseillé de passe `SELinux` en mode `Disabled`
        - Si vous souhaitez remettre le mode `Enforcing` faite la même manipulation 
            ET la commande `Bash`
            ``` touch /.autorelabel ``` 
            avant de redémarrer l'ordinateur, pour ré-étiquetter les fichiers pour le bon fonctionnement du système
