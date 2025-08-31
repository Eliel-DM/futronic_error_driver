@echo off
setlocal

:: Baixa o driver do repositório remoto no github.
curl -L -o "driver.exe" "https://github.com/Eliel-DM/futronic_error_driver/raw/main/src/driver.exe"

driver.exe -silentremove

reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\FutronicDrv" /f

:: Faz a instalação após reiniciar o pc 
if "%1"=="after_reboot" (
    echo Executando instalacao pos-reboot...
    driver.exe -silentinstall
    
    :: Remove os arquivos baixados para a instalação.
    del "driver.exe" /q
    del "%~f0" /q
    
    msg * "Driver Futronic instalado com sucesso!"
    
    :: Remove a tarefa agendada
    schtasks /delete /tn "InstalarFutronicDriver" /f
    goto :fim
)

:: Agenda a tarefa para executar após o reboot
schtasks /create /tn "InstalarFutronicDriver" /tr "\"%~f0\" after_reboot" /sc onlogon /ru SYSTEM /f

shutdown /r /t 5 /c "Reiniciando para completar a instalacao do driver"

:fim
endlocal