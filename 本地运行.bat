@echo off

start msedge http://localhost:1313/
hugo server  --buildDrafts
pause