#!/bin/bash
echo "/home/${USER}/data"
echo ~/data
if [ ! -d "~/data" ]; then
        mkdir -p ~/data
        mkdir -p ~/data/mariadb
        mkdir -p ~/data/wordpress
fi