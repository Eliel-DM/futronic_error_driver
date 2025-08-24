@echo off
:: Apaga o registro do driver.
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\FutronicDrv" /f
