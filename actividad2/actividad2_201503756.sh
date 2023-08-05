#! /usr/bin/env bash
echo "Actividad2 - 201503756"

#Detiene el script si ocurre un error
set -o errexit

#Lee el id de la cuenta cuenta github.
GITHUB_USER='netuko13'
#Consulta el sitio web de github, luego con el comando jq extraemos el dato que nos interesa 
github_user=$(curl -s https://api.github.com/users/$GITHUB_USER | jq '.name')
github_id=$(curl -s https://api.github.com/users/$GITHUB_USER | jq '.id')
github_create_at=$(curl -s https://api.github.com/users/$GITHUB_USER | jq '.created_at')
#Remueve las comillas dobles de los campos de texto
github_user=$(sed -e 's/^"//' -e 's/"$//' <<<"$github_user") 
github_create_at=$(sed -e 's/^"//' -e 's/"$//' <<<"$github_create_at") 
#Crea la carpeta temporal con la fecha de hoy
if [[ ! -d "/tmp/$(date +'%d-%m-%Y')" ]]
then
mkdir /tmp/$(date +"%d-%m-%Y")
fi
echo "Hola $github_user, User ID: $github_id, Cuenta fue creada el: $github_create_at." 
echo "Hola $github_user, User ID: $github_id, Cuenta fue creada el: $github_create_at." \
>> /tmp/$(date +"%d-%m-%Y")/saludos.log
