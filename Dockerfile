FROM n8nio/n8n:2.30.6

USER root

# Librerías de compilación necesarias para reconstruir el binding nativo
# de @napi-rs/canvas contra musl (Alpine). Sin esto, el Task Runner
# interno de n8n (que usa pdf-parse@2.4.5 en su nodo "Extract from File")
# no puede cargar canvas y entra en loop de crash/reinicio -> CPU al 100%+.
RUN apk add --no-cache build-base cairo-dev pango-dev jpeg-dev giflib-dev

# Reconstruye el binding nativo de @napi-rs/canvas DENTRO del propio n8n
# (no es nuestro paquete, es una dependencia interna de n8n).
RUN find /usr/local/lib/node_modules/n8n/node_modules/.pnpm -maxdepth 1 -name "@napi-rs+canvas*" -exec sh -c 'npm rebuild --prefix "$1"' _ {} \;

# pdf-parse@1.1.1 para usar en nodos Function/Code propios (liviano,
# no depende de canvas). Independiente del pdf-parse interno de n8n.
RUN npm install -g pdf-parse@1.1.1 mammoth xlsx --no-audit --no-fund
RUN chown -R node:node "$(npm root -g)"

USER node
