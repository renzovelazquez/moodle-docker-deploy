#!/bin/bash
# WHEN: 
# - new-install
# - update (just to fix a bug!)
# - upgrade (remove moodle-code, previous export should be made!)


# Load sensitive data or configurable data from a .env file
# export $(grep -E -v '^#' /init-scripts/.env | xargs)


# Config theme snap, already imported via plugins.sh
echo >&2 "Configuring theme..."

moosh config-set theme moove
# import theme settings:
# script needs to be in /var/www/html and name like theme_xxxx
# it can't have info about directories: ./  so next line is not valid and I have to "hack it"
# tar -zcf snap_settings.tar.gz -C /init-scripts/snap_settings .

# find /init-scripts/snap_settings -type f -printf "%f\n" | xargs tar -zcf snap_settings.tar.gz -C /init-scripts/snap_settings
# moosh theme-settings-import --targettheme snap snap_settings.tar.gz


if [[ "${SCHOOL_TYPE}" = "FPD" ]];
    then
        cp /init-scripts/themes/fpdist/moove*tar.gz /var/www/html/
        moosh theme-settings-import --targettheme moove moove*tar.gz
        cp -R /init-scripts/themes/fpdist/style /var/www/html/theme/moove
        cp /init-scripts/themes/fpdist/inc_start.mustache /var/www/html/theme/moove/templates
        cp /init-scripts/themes/fpdist/header.mustache /var/www/html/theme/moove/templates
        cp /init-scripts/themes/fpdist/footer.mustache /var/www/html/theme/moove/templates
        cp /init-scripts/themes/fpdist/politica-privacidad.php /var/www/html/politica-privacidad.php
        moosh config-set frontpage none
    else
        cp /init-scripts/themes/*tar.gz /var/www/html/        
        moosh theme-settings-import --targettheme moove moove*tar.gz
        cp /init-scripts/themes/footer.mustache /var/www/html/theme/moove/templates
fi
echo >&2 "Theme configured."