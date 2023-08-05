## Datos del estudiante
- **Estudiante:** Carlos Ernesto Fuentes Rasique
- **Carnet:** 201503756
- **Fecha:** 04/08/2023

## Contenido
- [Descripción de script](#script)
- [Pasos de cronjob](#cronjob)
---
<a name="script"></a>
### Descripción de script
Primero definimos nuestro shebang 

```bash
#! /usr/bin/env bash
```
Establecemos los criterios cuando se debe detener el script, si ocurre un error
```bash
set -o errexit
```

Lee el id de la cuenta cuenta github. en este caso ```netuko13```

```bash
GITHUB_USER='netuko13'
```

Consulta el sitio web de github, luego con el comando ```jq``` extraemos el dato que nos interesa y almacenamos los valores en las variables ```github_user```, ```github_id``` y ```github_create_at```:

```bash
github_user=$(curl -s https://api.github.com/users/$GITHUB_USER | jq '.name')
github_id=$(curl -s https://api.github.com/users/$GITHUB_USER | jq '.id')
github_create_at=$(curl -s https://api.github.com/users/$GITHUB_USER | jq '.created_at')
```

Remueve las comillas dobles de los campos de texto en las variables ```github_user``` y ```github_create_at```

```bash
github_user=$(sed -e 's/^"//' -e 's/"$//' <<<"$github_user") 
github_create_at=$(sed -e 's/^"//' -e 's/"$//' <<<"$github_create_at")
```

Crea la carpeta temporal con la fecha de hoy. Para ello utilizamos una sentencia ```if``` para validar si la carpeta existe:
```bash
if [[ ! -d "/tmp/$(date +'%d-%m-%Y')" ]]
then
mkdir /tmp/$(date +"%d-%m-%Y")
fi
```

Realiza el echo de salida:
```bash
echo "Hola $github_user, User ID: $github_id, Cuenta fue creada el: $github_create_at." 
```
Por último hace la concatenación de la cadena anterior en el archivo ```saludo.log```.

``` bash
echo "Hola $github_user, User ID: $github_id, Cuenta fue creada el: $github_create_at." \
>> /tmp/$(date +"%d-%m-%Y")/saludos.log
```
---

<a name="cronjob"></a>
### Pasos de cronjob

Dado a que mi sistema es ```ArchLinux``` primero instalamos los paquetes necesarios para ejecutar nuestro cronjob desde la terminal:

```bash
sudo pacman -S cronie vi
```
Luego hay que editar los cron jobs del usuario actual utilizando el comando:

```bash
crontab -e
```

Después hay que añadir la siguiente línea al archivo de cron jobs desde nuestro editor ```vi```:

```bash
*/5 * * * * /home/tukito/FIUSAC2023/sopes1_2S2023/so_actividades_201503756/actividad2/actividad2_201503756.sh
```

En esta línea, utilizamos el patrón ```*/5 * * * *``` para especificar que el script se ejecute cada 5 minutos. Los campos representan (de izquierda a derecha):

- Minutos (0-59)
- Horas (0-23)
- Día del mes (1-31)
- Mes (1-12)
- Día de la semana (0-7) (0 y 7 representan el domingo)

El asterisco (*) en cada campo significa "cualquier valor". Por lo tanto, */5 en el campo de los minutos indica que el script se ejecutará cada 5 minutos.

Por último gardamos los cambios y cerramos el editor de texto ```vi```. presionando la tecla ```Esc``` y luego escribiendo ```:qw``` y por último presionamos Enter.

Con estos pasos, el cron job se creará y el script ```actividad2_201503756.sh``` se ejecutará automáticamente cada 5 minutos.