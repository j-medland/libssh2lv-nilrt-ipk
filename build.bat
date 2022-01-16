set SCRIPT_DIR=%~dp0.
set IMAGE_NAME=libssh2lv-nirt-ipk
set BUILD_DIR="%SCRIPT_DIR%\..\.build-nilrt"

docker build -t %IMAGE_NAME% "%SCRIPT_DIR%" ^
 && docker run -v "%SCRIPT_DIR%":"//libssh2lv" -it --rm %IMAGE_NAME%