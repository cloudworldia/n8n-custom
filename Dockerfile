
# Versión fijada (evita que Easypanel jale una versión distinta a la
# que probaste en tu máquina y cambie el comportamiento de Task Runners)
FROM n8nio/n8n:2.30.6
 
USER root
 
# Instalación GLOBAL: no depende de crear ni asegurar ninguna carpeta
# custom (WORKDIR). Los paquetes quedan en la carpeta global de npm que
# YA existe en la imagen base (normalmente /usr/local/lib/node_modules).
RUN npm install -g pdf-parse mammoth xlsx --no-audit --no-fund
 
# Nos aseguramos de que el usuario "node" (con el que corre n8n en runtime)
# pueda leer esos módulos, sin importar cómo maneje Easypanel los permisos.
RUN chown -R node:node "$(npm root -g)"
 
USER node
