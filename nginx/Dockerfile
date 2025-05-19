FROM nginx:1.28.0-alpine
ARG ReverseProxyPort
EXPOSE ${ReverseProxyPort}
COPY nginx.conf /etc/nginx/conf.d/default.conf