FROM n8nio/n8n:2.30.6

USER root

RUN npm install -g \
    mammoth \
    pdf-parse \
    xlsx

USER node
