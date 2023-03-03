#!/bin/bash
remove -f /dev/vg1/lv1
vgremove /dev/vg1
pvremove /dev/sdb1 /dev/sdc1