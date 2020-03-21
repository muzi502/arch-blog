#!/bin/bash
# by: muzi
# use: build and deploy pubic to github and vps
# date: 2019-11-21

set -xue
date=$(date +"%Y-%m-%d-%H:%M")
hugo_dir=$(pwd)
post_dir=${hugo_dir}/content
public_dir=${hugo_dir}/public
cd ${hugo_dir}
cd ${post_dir}
rename 's/([12]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01])-)//' *.md

cd ${hugo_dir}
rm -rf  public/*
hugo
rm -rf  ${post_dir}
git checkout ${post_dir}
find ${public_dir} -name '*.html' -type f -print0 | xargs -0 sed -i '/^[[:space:]]*$/d'
sed -i '/muzi.disqus.com/d' ${public_dir}/index.html
