@echo off
echo 【创建文章】
set /p input= 请输入Slug: 
hugo new post/%Date:~0,4%/%Date:~5,2%%Date:~8,2%-%input%/index.md
pause
