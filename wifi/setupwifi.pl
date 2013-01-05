#!/usr/bin/perl

print "What is the SSID of the wifi network? ";
chomp($ssid = <>);
print "What is the password? ";
chomp($password = <>);
print "Setting up configuration for $ssid\...";

#writing /etc/network/interfaces

$interfaces = <<END;
auto wlan0
iface wlan inet dhcp
wpa-conf /etc/wpa.conf
END

#writing /etc/wpa.conf
$wpaconf = <<END;
network={
	ssid="$ssid"
	proto=RSN
	key_MGMT=WPA-PSK
	pairwise=CCMP TKIP
	group=CCMP TKIP
	psk="$password"
}
END

#saving files
open (INTERFACES_FILE, '>/home/pi/interfaces');#/etc/network/interfaces');
print INTERFACES_FILE $interfaces;
close (INTERFACES_FILE); 

open (WPACONFFILE, '>/home/pi/wpa.conf'); #/etc/wpa.conf');
print WPACONFFILE $wpaconf;
close (WPACONFFILE); 

print "done\nWIFI should be set up now. Enjoy.\n"


