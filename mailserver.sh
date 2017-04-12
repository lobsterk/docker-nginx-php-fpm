#!/usr/bin/env bash

debconf-set-selections <<< "postfix postfix/mailname string 'localhost'"
debconf-set-selections <<< "postfix postfix/main_mailer_type string 'Internet Site'"
apt-get -qq update
apt-get install -y postfix