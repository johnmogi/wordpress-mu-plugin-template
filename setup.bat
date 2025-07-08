@echo off
setlocal enabledelayedexpansion

echo 🚀 Starting MU Plugin Setup...

:: Get plugin name from directory name if not provided
set "PLUGIN_NAME=%~1"
if "!PLUGIN_NAME!"=="" (
    for %%a in ("%~dp0.") do set "FOLDER_NAME=%%~nxa"
    set "PLUGIN_NAME=!FOLDER_NAME!"
)

set "VENDOR_NAME=%~2"
if "!VENDOR_NAME!"=="" set "VENDOR_NAME=ModernMU"

set "NAMESPACE=!VENDOR_NAME!\\Core"

:: Convert plugin name to title case for class names
set "PLUGIN_TITLE=%PLUGIN_NAME:-= %"
set "PLUGIN_TITLE=%PLUGIN_TITLE:_= %"
for %%a in (%PLUGIN_TITLE%) do (
    set "FIRST=%%a"
    set "FIRST=!FIRST:~0,1!!FIRST:~1!"
    set "PLUGIN_TITLE=!PLUGIN_TITLE:%%a=! !FIRST!"
)
set "PLUGIN_TITLE=%PLUGIN_TITLE: =%"

echo ✓ Setting up plugin: %PLUGIN_NAME%
echo ✓ Using namespace: %NAMESPACE%

:: Update composer.json
echo Updating composer.json...
powershell -Command "(Get-Content composer.json) -replace '\"your-vendor/wordpress-mu-plugin\"', '\"' + '%VENDOR_NAME: =%'.ToLower() + '/' + '%PLUGIN_NAME: =%'.ToLower().Replace(' ', '-') + '\"' | Set-Content composer.json"

:: Update namespaces in PHP files
echo Updating namespaces in PHP files...
powershell -Command "Get-ChildItem -Path . -Filter *.php -Recurse | ForEach-Object { (Get-Content $_.FullName) -replace 'YourVendor\\\\YourPluginName', '%NAMESPACE:\=\\%' | Set-Content $_.FullName }"
powershell -Command "(Get-Content composer.json) -replace 'YourVendor\\\\', '%VENDOR_NAME%\\' | Set-Content composer.json"

:: Update plugin header
echo Updating plugin header...
powershell -Command "(Get-Content mu-plugin.php) -replace 'Plugin Name: Modern MU Plugin', 'Plugin Name: %PLUGIN_TITLE%' | Set-Content mu-plugin.php"
powershell -Command "(Get-Content mu-plugin.php) -replace 'Description: A modern WordPress must-use plugin with Composer and PSR-4 autoloading', 'Description: %PLUGIN_TITLE% - A modern WordPress must-use plugin' | Set-Content mu-plugin.php"

:: Update class names
echo Updating class names...
powershell -Command "Get-ChildItem -Path . -Filter *.php -Recurse | ForEach-Object { (Get-Content $_.FullName) -replace 'class Plugin', 'class %PLUGIN_TITLE%_Plugin' | Set-Content $_.FullName }"
powershell -Command "Get-ChildItem -Path . -Filter *.php -Recurse | ForEach-Object { (Get-Content $_.FullName) -replace 'Plugin::get_instance()', '%PLUGIN_TITLE%_Plugin::get_instance()' | Set-Content $_.FullName }"

:: Install dependencies
echo Installing dependencies...
composer install

echo ✓ Setup complete! Your plugin is ready to use.
echo Don't forget to update the README.md with your plugin's specific information.

endlocal
