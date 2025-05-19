FROM nginx:1.27.4-alpine
ARG ReverseProxyPort
EXPOSE ${ReverseProxyPort}
COPY nginx.conf /etc/nginx/conf.d/default.conf