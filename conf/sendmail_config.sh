#!/bin/bash

######################################
# sendmail config
#
# This file is for configuring the Labrador
# email using the software sendmail.
#
# Edit the lines of below code needing ATTENTION
# as described.  You need to provide your:
# 1) admin email address (currently topdog@labrador.ac.uk)
# 2) webserver name (currently mail.labrador.internal)
# 3) admin username (currently topdog)
# 
# When the configuration takes place, reply Yes [Y] to
# any on-screen prompts.
######################################

apt-get update
apt-get install -y sendmail
apt-get install -y sendmail-cf
apt-get install -q -y ssmtp mailutils
#apt-get install -y net-tools #Appears not to installed already

echo "include(\`/etc/mail/tls/starttls.m4')dnl" >> /etc/mail/sendmail.mc
myhostname=$(hostname)
echo "127.0.0.1 localhost.localdomain localhost $myhostname" >> /etc/hosts


# Root is the person who gets all mail for userids < 1000
################################################################
# ATTENTION: Change to your admin email address here
echo "root=swingett@mrc-lmb.cam.ac.uk" >> /etc/ssmtp/ssmtp.conf      
################################################################

################################################################
# ATTENTION: Change to your mail server name here (remember to keep ':587')
echo "mailhub=mail.lmb.internal:587" >> /etc/ssmtp/ssmtp.conf   
################################################################

# Alternatively use address/password
#RUN echo "AuthUser=your@gmail.com" >> /etc/ssmtp/ssmtp.conf
#RUN echo "AuthPass=yourGmailPass" >> /etc/ssmtp/ssmtp.conf

echo "UseTLS=YES" >> /etc/ssmtp/ssmtp.conf
echo "UseSTARTTLS=YES" >> /etc/ssmtp/ssmtp.conf

# Set up php sendmail config
mkdir /usr/local/etc/php
mkdir /usr/local/etc/php/conf.d
echo "sendmail_path=sendmail -i -t" >> /usr/local/etc/php/conf.d/php-sendmail.ini
echo "FromLineOverride=YES" >> /etc/ssmtp/ssmtp.conf

################################################################
# ATTENTION: Change to your username:admin_email:mailserver
echo "swingett:swingett@mrc-lmb.cam.ac.uk:mail.lmb.internal" >> /etc/ssmtp/revaliases 
################################################################

################################################################
# ATTENTION: Change to your username
useradd -ms /bin/bash swingett
################################################################

sendmailconfig

################################################################
# ATTENTION: Change to the admin email address
echo "Subject:Labrador test email" | sendmail swingett@mrc-lmb.cam.ac.uk
################################################################
