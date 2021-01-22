FROM HEXO_IMAGE as builder
WORKDIR /blog
RUN hexo g

FROM nginx:stable
COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=builder /blog/public  /var/www/blog
