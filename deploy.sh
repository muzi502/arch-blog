#!/bin/bash
# by: muzi
# use: build and deploy pubic to github and vps
# date: 2019-11-21

set -xue
date=$(date +"%Y-%m-%d-%H:%M")
hexo_dir=$(pwd)
post_dir=${hexo_dir}/source/_posts
public_dir=${hexo_dir}/public
cd ${hexo_dir}
cd ${post_dir}
rename 's/([12]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01])-)//' *.md

cd ${hexo_dir}
rm -rf db.json public/*
hexo g
rm -rf  ${post_dir}
git checkout ${post_dir}
find ${public_dir} -name '*.html' -type f -print0 | xargs -0 sed -i '/^[[:space:]]*$/d'
sed -i '/muzi.disqus.com/d' ${public_dir}/index.html
cd ${hexo_dir}
rsync -avzru  --delete --force public/ -e ssh gce:/var/www/hexo/public/

ssh oracle "~/deploy.sh"
