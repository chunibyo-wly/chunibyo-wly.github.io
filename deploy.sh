#!/bin/bash

hexo clean
hexo g
hexo d

git add .
git commit -m "$(date)"
git push
