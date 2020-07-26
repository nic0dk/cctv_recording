# CCTV Recording for low end hardware.

this project is based on @oddworld9 work for a simple and cheap NVR solutions, all credits goes to him.
link: https://www.reddit.com/r/homelab/comments/7vjb7h/linux_bash_nvr_howto_for_network_ip_cameras/

this is my version of it.
what we need on the linux distro to run these scripts.
  1. ffmpeg debian/ubuntu install via with <code>sudo apt-get install ffmpeg</code>
  2. A big harddrive, im using 2TB for 5 cameras.
  3. replace directory name to fit your setup!

first off, download the script to your <code>/opt/"dirname"</code> in my case, im pointing it to <code>/opt/cctv_recording/</code>
make them executeable - <code>sudo chmod +x /opt/"dirname"/*

figure out where you mounted your HDD or storages 
```
df -h
Filesystem      Size  Used Avail Use% Mounted on
udev            931M     0  931M   0% /dev
tmpfs           200M   30M  170M  16% /run
/dev/mmcblk1p2   15G  1,4G   13G  10% /
tmpfs           998M   16K  998M   1% /dev/shm
tmpfs           5,0M  4,0K  5,0M   1% /run/lock
tmpfs           998M     0  998M   0% /sys/fs/cgroup
/dev/sda        1,8T  1,7T   76G  96% /mnt/cctv
tmpfs          1023M   14M 1010M   2% /tmp
tmpfs            50M  196K   50M   1% /var/log
/dev/mmcblk1p1   71M   33M   38M  47% /boot
```
in my case its ```/mnt/cctv```

edit the 3 script files so it fits your need and when you are ready for recording, you apply 3 lines in crontab.

edit crontab with ```crontab -e```
apply this line in the bottom:
```
*/15 * * * * /opt/"dirname"/record_hq.sh
0 * * * * /opt/cctv_recording/record_lq.sh
45 */3 * * * /opt/"dirname"/record_delete.sh
```


that is it, you should be running, check via ```top```to see if the scrip are running

on top of this i have samba running to local access the video files, and nginx web server to access the files from mobile remote.
# cctv_recording
