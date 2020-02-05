color 16

echo deploy blog
call hexo clean
call hexo g
call hexo d

echo 开始提交代码
git add -A .
git commit -m "%date%"
git push
echo 完成

