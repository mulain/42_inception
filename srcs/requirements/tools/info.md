I ran this on the local machine and copied the files, could also add this to the Docker File and have the container run it (adapt the file locations ofc).


openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
        -out /etc/nginx/ssl/wmardin.crt \
        -keyout /etc/nginx/ssl/wmardin.key \
        -subj "/C=DE/ST=NS/L=Hannover/O=42/OU=42WOB/CN=wmardin/"


### And of course never publish the private key in a real system.