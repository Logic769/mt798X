@echo off
title=MT798X串口TTL救砖
rem 设置fip文件夹路径变量
set "folderPath=fip"

setlocal enabledelayedexpansion
echo 可选机型fip列表：
set count=0
for /f "tokens=*" %%a in ('dir /b /a-d "%folderPath%" ^| findstr /i "fip"') do (
	set /a count+=1
	echo !count!. %%a
	set "model[!count!]=%%a"
)
if %count% equ 0 (
    echo 请检查fip文件夹是否有fip文件！
    goto :end
)
:modelSTART
set /p modelNumber=输入机型fip序号：

if not defined model[%modelNumber%] (
	echo 无效的机型fip序号，请重新输入。。。
	goto modelSTART
)
set "selectedModel=!model[%modelNumber%]!"
echo ^>^>^>已选择 %selectedModel%

rem 根据fip文件名获取SOC和DDR，以便匹配ram boot bl2
rem 截取文明名前面的mt7981或者mt7986
for /f "tokens=1 delims=_" %%a in ("%selectedModel%") do (
    set "modelSOC=%%a"
)
rem 根据文件名匹配是否是DDR4，不是则默认DDR3
if "%selectedModel:mt7981_cmcc_rax3000m=%" neq "%selectedModel%" (
	set "modelDDR=ddr4"
) else if "%selectedModel:mt7981_cmcc_xr30=%" neq "%selectedModel%" (
	set "modelDDR=ddr4"
) else if "%selectedModel:mt7986_jdcloud_re-cp-03=%" neq "%selectedModel%" (
	set "modelDDR=ddr4"
) else if "%selectedModel:mt7986_glinet_gl-mt6000=%" neq "%selectedModel%" (
	set "modelDDR=ddr4"
) else if "%selectedModel:mt7986_redmi_ax6000=%" neq "%selectedModel%" (
	set "modelDDR=ddr4"
) else (
	set "modelDDR=ddr3"
)
echo SoC type: %modelSOC%
echo DDR type: %modelDDR%


echo RAM Boot BL2路径: mtk_uartboot\%modelSOC%\%modelSOC%-%modelDDR%-bl2.bin
echo 选择机型的FIP路径: %folderPath%\%selectedModel%
echo ==================================

echo 选择串口波特率：
echo 1. 正常波特率（--brom 921600 --bl2 1500000）
echo 2. 低波特率  （--brom 115200 --bl2 115200）
echo 默认正常波特率即可，如果你的串口承受不了再尝试低波特率。
set /p baudRate=选择波特率（输入序号）：
if "%baudRate%"=="2" (
	set "BromBaudRate=115200"
	set "Bl2BaudRate=115200"
	echo ^>^>^>已选择 低波特率  （--brom 115200 --bl2 115200）
) else (
	set "BromBaudRate=921600"
	set "Bl2BaudRate=1500000"
	echo ^>^>^>已选择 正常波特率（--brom 921600 --bl2 1500000）
)
echo ==================================

:comSTART
set /p comPort=请输入COM端口号：
if "%comPort%"=="" (
	echo 请重新输入COM端口号。。。
	goto comSTART
)
echo ^>^>^>已输入 COM端口号 %comPort%
echo ==================================

echo .\mtk_uartboot\mtk_uartboot.exe -s COM%comPort% -p .\mtk_uartboot\%modelSOC%\%modelSOC%-%modelDDR%-bl2.bin -a -f .\%folderPath%\%selectedModel% --brom-load-baudrate %BromBaudRate% --bl2-load-baudrate %Bl2BaudRate%
echo 命令执行中，出现Handshake...信息后就可上电路由器
echo ==================================
.\mtk_uartboot\mtk_uartboot.exe -s COM%comPort% -p .\mtk_uartboot\%modelSOC%\%modelSOC%-%modelDDR%-bl2.bin -a -f .\%folderPath%\%selectedModel% --brom-load-baudrate %BromBaudRate% --bl2-load-baudrate %Bl2BaudRate%

:end
endlocal
echo ==================================
echo 按任意键退出
pause >nul