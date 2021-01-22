FROM node:lts-buster
WORKDIR /blog
RUN git clone -b blog https://github.com/muzi502/blog /blog
RUN yarn global add hexo-cli && yarn install
