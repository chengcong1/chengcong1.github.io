@echo off
echo 【创建标签】
set /p input= 请输入标签名: 
hugo new tags/%input%/_index.md
pause
