FROM n8nio/n8n:2.30.6

USER root

# pdf-parse@1.1.1 para usar en nodos Function/Code propios.
# No toca ni depende del pdf-parse@2.4.5 interno de n8n (ese es el que
# está roto por el bug de @napi-rs/canvas + musl, ver Task Runners abajo).
RUN npm install -g pdf-parse@1.1.1 mammoth xlsx --no-audit --no-fund
RUN chown -R node:node "$(npm root -g)"

USER node
