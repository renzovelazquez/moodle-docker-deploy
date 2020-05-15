version: "3"

services:
  moodle:
    image: cateduac/moodle:3.7-apache
    environment:
      VIRTUAL_HOST: "${VIRTUAL_HOST}"
      LETSENCRYPT_HOST: "${VIRTUAL_HOST}"
      LETSENCRYPT_EMAIL: "${SSL_EMAIL}"
      MOODLE_DB_HOST: "${MOODLE_DB_HOST}"
      MOODLE_DB_NAME: "${MOODLE_DB_NAME}"
      MOODLE_DB_USER: "${MOODLE_MYSQL_USER}"
      MOODLE_DB_PASSWORD: "${MOODLE_MYSQL_PASSWORD}"
      MOODLE_URL: "${MOODLE_URL}"
      MOODLE_ADMIN_USER: "${MOODLE_ADMIN_USER}"
      MOODLE_ADMIN_PASSWORD: "${MOODLE_ADMIN_PASSWORD}"
      MOODLE_ADMIN_EMAIL: "${MOODLE_ADMIN_EMAIL}"
      MOODLE_LANG: "${MOODLE_LANG}"
      MOODLE_SITE_NAME: "${MOODLE_SITE_NAME}"
      MOODLE_SITE_FULLNAME: "${MOODLE_SITE_FULLNAME}"
      DEFAULT_THEME: "${DEFAULT_THEME}"
      BBB_SERVER_URL: "${BBB_SERVER_URL}"
      BBB_SECRET: "${BBB_SECRET}"
      SSL_PROXY: "${SSL_PROXY}"
      EXTERNAL_DB: "${EXTERNAL_DB}"
    networks:
      - nginx-proxy_frontend
      - backend
    volumes:
      - ./moodle-data:/var/www/moodledata
      - ./moodle-code:/var/www/html

networks:
  nginx-proxy_frontend:
    external: true
  backend:
    external:
      driver: bridge
      name: "dontknow"