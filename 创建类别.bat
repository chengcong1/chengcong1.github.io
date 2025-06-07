@echo off
echo 【创建类别】
set /p input= 请输入类别名: 
hugo new categories/%input%/_index.md
pause
