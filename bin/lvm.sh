#!/bin/bash

# LV 작업 한 번에 수행하기

TMP1=/tmp/tmp1
TMP2=/tmp/tmp2
TMP3=/tmp/tmp3
TMP4=/tmp/tmp4

# 1. PV
# 2. VG
# 3. LV

echo -n "########### PV 생성 ##############"
#---------------------------
# 1. PV
#---------------------------
# (1) View
fdisk -l | grep LVM | awk '{print $1}' > $TMP1
pvs | tail -n +2 | awk '{print $1}' > $TMP2

cat << EOF
############### PV VIEW ###############
$(cat $TMP1 $TMP2 | sort | uniq -u )
#######################################

EOF

# (2) Works
echo "=> 위의 목록에서 PV로 생성하고 싶은 볼륨을 선택합니다. <="
echo -n "볼륨 선택? (ex: /dev/sdb1 /dev/sdc1 ...) : "
read VOLUME

pvcreate $VOLUME >/dev/null 2>&1
if [ $? -eq 0 ] ; then
    echo "[ OK ] Physical volume "/dev/sdb1" successfully created."
    pvs
else
    echo "[ FAIL ] Physical volume not created."
    exit 1
fi
echo -n "########### VG 생성 ##############"
#---------------------------
# 2. VG
#---------------------------
# (1) View
vgs | tail -n +2 | awk '{print $1}' > $TMP3
pvs > $TMP4
for i in $(cat $TMP3)
do
    sed -i "/$i/d" $TMP4
done

cat << EOF
############### PV List #####################
$(cat $TMP4)
#############################################

EOF

# (2) Works
# vgcreate vg1 /dev/sdb1 /dev/sdc1
echo -n " VG 이름은? (ex: vg1) : "
read VGNAME

echo -n "선택 가능한 PV 목록을 적어 주세요? (ex: /dev/sdb1 /dev/sdc1 ...) : "
read PVLIST

vgcreate $VGNAME $PVLIST > /dev/null 2>&1
if [ $? -eq 0 ] ; then
    ehco "[  OK  ] Volume group $VGNAME successfully created"
    echo "======================================="
    vgs
    echo "======================================="
else 
    echo "[ FAIL ] Volume group not created."
    exit 2
fi
echo -n "########### LV 생성 ##############"
############################
# 3. LV
############################
# (1) View
cat << EOF
############### PV List #####################
$(vgs | awk '$7 != '0' {print $0}')
#############################################
EOF

# (2) Works

echo -n "LV를 생성할 VG 이름은? (ex: vg1) :"
read VGLV

echo -n "생성할 LV이름은? (ex: lv1) : "
read LVNAME

echo -n "LV 용랑은? (ex:500m) : "
read LVSIZE

lvcreate $VGLV -n $LVNAME -L $LVSIZE 
if [ $? -eq 0 ] ; then
    echo "[ OK ] Logical Volume $LVNAME successfully created"
    echo "============================================"
    lvs
    echo "============================================"
else
    echo "[ FAIL ] Logical Volume not created."
    exit3
fi