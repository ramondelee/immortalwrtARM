#!/bin/sh /etc/rc.common

start() {
    	kick=$(grep -e "KickStaRssiLow=" /etc/wireless/mediatek/mt7986-ax6000.dbdc.b0.dat)
    	iwpriv ra0 set "$kick"
    	kick=$(grep -e "KickStaRssiLow=" /etc/wireless/mediatek/mt7986-ax6000.dbdc.b1.dat)
    	iwpriv rai0 set "$kick"
    	kick=$(grep -e "KickStaRssiHigh=" /etc/wireless/mediatek/mt7986-ax6000.dbdc.b0.dat)
    	iwpriv ra1 set "$kick"
    	ApCliBridge=$(grep -e "ApCliBridge=" /etc/wireless/mediatek/mt7986-ax6000.dbdc.b0.dat)
    	ApCliBridge=${ApCliBridge//ApCliBridge=/}
    	if [ $ApCliBridge -eq 1 ]; then
    	brctl addif br-lan apcli0
    	else
    	ifconfig apcli0 up
    	brctl delif br-lan apcli0
    	fi
    	
    	ApCliBridge=$(grep -e "ApCliBridge=" /etc/wireless/mediatek/mt7986-ax6000.dbdc.b0.dat)
    	ApCliBridge=${ApCliBridge//ApCliBridge=/}
    	if [ $ApCliBridge -eq 1 ]; then
    	brctl addif br-lan apclii0
    	else
    	ifconfig apclii0 up
    	brctl delif br-lan apclii0
    	fi
    	FtSupport=$(grep -e "FtSupport=" /etc/wireless/mediatek/mt7986-ax6000.dbdc.b1.dat)
    	FtSupport=${FtSupport//FtSupport=/}
    	if [ $FtSupport -eq 1 ]; then
    	/usr/sbin/mtkiappd -e br-lan -wi rai0 -wi ra0 &
    	else
    	killall mtkiappd
    	fi 
}
