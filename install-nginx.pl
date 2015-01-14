#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: install-nginx.pl
#
#        USAGE: ./install-nginx.pl  
#
#  DESCRIPTION: Installs nginx for NWEA coding test
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: Alan Olsen, 
# ORGANIZATION: 
#      VERSION: 1.0
#      CREATED: 01/12/2015 09:27:12 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use utf8;

# Make sure this is run with superuser privilages or else it will fail.
if ($> != 0){
 die "You must be root or suid to run this program.\n";
} 

# Make sure nginx is installed

if (-f '/usr/sbin/nginx'){
 print "nginx is already installed.\n";
} else {
`yum install nginx -y`;
 # test if errored out
 if ($!){
  die "Yum was unable to install nginx.\n";
 }
}

# Copy config file 
if (-f './nginx.conf'){
 `mkdir -p /etc/nginx`;
 `cp ./nginx.conf /etc/nginx/nginx.conf`;
} else {
 die "nginx.conf is missing\n";
}

# Check if systemd or init.d
if (-f '/usr/bin/systemctl'){
 # Assume systemd
 `systemctl start nginx.service`;
 # Did it start?
 if ($!){
  `systemctl status nginx.service`;
  die "\nCannot start nginx.\n";
 }
 `systemctl enable nginx.service`;
 # Make sure it enabled the service
 if ($!){
  die "nginx did not enable.\n"
 }
} else {
 `service nginx start`;
 # See if it started
 if ($!){
  die "Could not start nginx\n";
 }
 `chkconfig nginx on`;
}

# Check log rotation
if (-f '/etc/logrotate.d/nginx'){
 print "Log rotation configured.\n";
} else {
 `cp nginx.logrotate /etc/logrotate.d/nginx`;
}

# I would detect the firewall and open the port myself, but this varies far too much to detect 
# reliably between distributions. 
print "If you have a firewall enabled, remember to open port 8888.\n";




