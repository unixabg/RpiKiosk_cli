#!/bin/bash

###########################################

# Simple Script to undo all changes made to pi to
# Create pi Kiosk

############################################

# Logo Call

echo "###################################################"
echo "###################################################"
echo -e "\n"
cat jhart_shell_logo.txt
echo -e "\n"

echo "###################################################"
echo "###################################################"

#############################################


echo -e "\n"
echo "##################################################"
echo "##################################################"
while true; do
	echo "This script will remove the configuration changes made by running the KioskInstall script.  This will return your pi back to its natural state after a reboot.  Are you sure you want to continue? (If so answer with 'Yes please.' If not please answer with 'No')"
	read _Undo
	if [ "$_Undo" == "Yes please!" ];
	then
		_Boot_Config=$(ls /boot/ | grep "config.txt.DSbackup")
		echo "Now going to revert changes made to the pi during KioskInstall : '$_Boot_Config'"
		if [ "" == "$_Boot_Config" ];
		then
			echo "Nothing to be changed in /boot/config.txt"
		else
			echo "Changing /boot/config.txt back to original state."
			sudo rm -rf /boot/config.txt
			sudo mv /boot/config.txt.DSbackup /boot/config.txt
		fi
		_Autostart_Check=$(ls /etc/xdg/lxsession/LXDE-pi/ | grep "autostart.backup")
		echo -e "\nLooking to see if autostart has been changed.  If so reverting it back to original : '$_Autostart_Check'"
		if [ "" == "$_Autostart_Check" ];
		then
			echo "Nothing to be changed in autostart config."
		else
			echo "Changing autostart config back to original state."
			sudo rm -rf /etc/xdg/lxsession/LXDE-pi/autostart
			sudo mv /etc/xdg/lxsession/LXDE-pi/autostart.DSbackup /etc/xdg/lxsession/LXDE-pi/autostart
		fi
		_Kiosk_Ran=$(ls /etc/lightdm/ | grep "lightdm.conf.backup")
		echo -e "\nChecking to see if mouse cursor has been disabled : '$_Kiosk_Ran'"
		if [ "" == "$_Kiosk_Ran" ];
		then
			echo "No configuration changes need to be made."
			sleep 3
		else
			echo "Reverting the /etc/lightdm/lightdm.conf file back to original state.  This will allow your mouse cursor to return after rebooting your pi."
			sleep 5
			sudo rm -rf /etc/lightdm/lightdm.conf
			sudo mv /etc/lightdm/lightdm.conf.DSbackup /etc/lightdm/lightdm.conf
			fi
			break
	else
		if [ "$_Undo" == "No" ];
		then
			echo "No changes will be made."
		break
		fi
	fi
done

########################################################################

echo -e "\nAll done!! Please reboot your pi for changes to take effect. Thank you -Jhart"
sleep 3
exit

