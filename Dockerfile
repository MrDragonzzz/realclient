FROM centos:7 AS node
LABEL ljy="571646321@qq.com"
ADD node-v16.17.0-linux-x64.tar.gz /usr/local
RUN yum -y update; yum clean all

RUN yum -y install epel-release; yum clean all

RUN yum -y install nodejs npm; yum clean all

COPY react-redux-realworld-example-app /usr/local/react

ENV NODE_HOME /usr/local/node-v16.17.0-linux-x64

ENV PATH=$PATH:NODE_HOME/bin

ENV NODE_PATH $NODE_HOME/lib/node_modules

ENV EACT_APP_BACKEND_URL="http://localhost:3311/api"

WORKDIR /usr/local/react/
RUN npm install && npm run build

FROM nginx
COPY --from=node /usr/local/react/build /usr/share/nginx/html/build
COPY nginx.conf /etc/nginx/nginx.conf
EXPOSE 81



