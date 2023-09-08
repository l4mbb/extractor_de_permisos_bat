@echo off
REM habilita la modificacion de variables en un archivo de bloques de codigo
setlocal enabledelayedexpansion

REM Pide al usuario que seleccione un directorio
set /p "dir=Por favor, ingresa la ruta del directorio: "

REM Comprueba si la ruta especificada es válida
if not exist "%dir%" (
    echo La ruta no es válida.
    pause
    exit /b
)

REM Pregunta al usuario si desea guardar las rutas en un archivo
set /p "save=¿Deseas guardar las rutas y permisos en un archivo? (S/N): "
if /i "%save%"=="S" (
    set /p "filename=Ingresa el nombre del archivo de salida (sin extensión): "
    
    REM Agrega automáticamente la extensión .log al nombre del archivo
    set "filename=!filename!.log"
    
    echo Guardando rutas y permisos en !filename!...
    (
        echo Rutas y permisos en %dir%:
        icacls "%dir%"
        
        echo Subdirectorios y archivos en %dir%:
        dir /b /s "%dir%"
        
        REM Muestra los permisos de cada archivo en el directorio principal y subdirectorios
        for /r "%dir%" %%f in (*) do (
            echo.
            echo Rutas de archivo: %%f
            icacls "%%f"
        )
    ) > "%userprofile%\Documents\!filename!"
    
    echo Rutas y permisos guardados en !filename!
) else (
    REM Muestra los permisos del directorio principal
    echo Permisos de %dir%:
    icacls "%dir%"
    
    REM Lista los subdirectorios y archivos en el directorio principal
    echo Subdirectorios y archivos en %dir%:
    dir /b /s "%dir%"
    
    REM Muestra los permisos de cada archivo en el directorio principal y subdirectorios
    for /r "%dir%" %%f in (*) do (
        echo.
        echo Rutas de archivo: %%f
        icacls "%%f"
    )
)

pause