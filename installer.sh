#!/bin/sh
# ###########################################
# SCRIPT : DOWNLOAD AND INSTALL Quran Karim
# ###########################################
#
# Command: wget https://raw.githubusercontent.com/emil237/quran/main/installer.sh -qO - | /bin/sh
#
# ###########################################

###########################################
# Configure where we can find things here #
TMPDIR='/tmp'
PACKAGE='enigma2-plugin-extensions-quran-karim'
MY_URL='https://raw.githubusercontent.com/emil237/quran/main'

#################
# Check Version #
VERSION=$(wget $MY_URL/version -qO- | cut -d "=" -f2-)

####################
#  Image Checking  #

if [ -f /etc/opkg/opkg.conf ]; then
    OSTYPE='Opensource'
    OPKG='opkg update'
    OPKGINSTAL='opkg install'
    OPKGLIST='opkg list-installed'
    OPKGREMOV='opkg remove --force-depends'
fi

##################################
# Remove previous files (if any) #
rm -rf $TMPDIR/"${PACKAGE:?}"* >/dev/null 2>&1

if [ "$($OPKGLIST $PACKAGE | awk '{ print $3 }')" = "$VERSION" ]; then
    echo " You are use the laste Version: $VERSION"
    exit 1
elif [ -z "$($OPKGLIST $PACKAGE | awk '{ print $3 }')" ]; then
    echo
    clear
else
    $OPKGREMOV $PACKAGE
fi
$OPKG >/dev/null 2>&1
###################
#  Install Plugin #
echo "Insallling Quran Karim plugin Please Wait ......"
wget $MY_URL/${PACKAGE}_"${VERSION}"_all.ipk -qP $TMPDIR
$OPKGINSTAL $TMPDIR/${PACKAGE}_"${VERSION}"_all.ipk

#########################
# Remove files (if any) #
rm -rf $TMPDIR/"${PACKAGE:?}"* >/dev/null 2>&1

sleep 2
clear
echo ""
echo "***********************************************************************"
echo "**                                                                    *"
echo "**                       Quran      : $VERSION                             *"
echo "**     >>>>>>>>>>  Uploaded by: EMIL_NABIL                    *"
sleep 4;
echo "**                     Develop by : opesboy                         *"
echo "**                                                                    *"
echo "***********************************************************************"
echo ""
killall -9 enigma2
exit 0
