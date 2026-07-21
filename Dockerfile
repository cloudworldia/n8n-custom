FROM n8nio/n8n:2.30.6

USER root

# IMPORTANTE: se fija pdf-parse@1.1.1 a propósito.
# Desde pdf-parse@2.x, el paquete usa pdfjs-dist internamente, que requiere
# @napi-rs/canvas (DOMMatrix/ImageData/Path2D). El binario nativo de canvas
# es para glibc y esta imagen corre en Alpine (musl) -> falla al cargar ->
# el Task Runner crashea en loop -> CPU al 100%+.
# La v1.1.1 solo extrae texto, no depende de canvas, y es más liviana.
RUN npm install -g pdf-parse@1.1.1 mammoth xlsx --no-audit --no-fund

RUN chown -R node:node "$(npm root -g)"

USER node
