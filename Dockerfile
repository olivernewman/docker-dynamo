FROM frolvlad/alpine-java:jre8-slim
MAINTAINER Oliver Newman

ENV DYNAMO_ENDPOINT http://localhost:8002/

RUN apk update && \
    apk add --no-cache -fq \ 
    	supervisor \
    	nginx \
    	curl \
    	nodejs-npm && \

    cd /usr/lib && \
    curl -L https://s3-us-west-2.amazonaws.com/dynamodb-local/dynamodb_local_latest.tar.gz | tar xz && \
    npm install -g dynamodb-admin && \

    mkdir -p /var/lib/dynamodb && \
    mkdir -p /var/log/supervisord

COPY supervisord.conf /etc/supervisord.conf
COPY nginx-proxy.conf /etc/nginx-proxy.conf

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]