# CCTV Recording for low end hardware.

no need for big NVR or cpu hungry surveillance system for storage camera feed over time.
be simply using ffmpeg with some basic shell scripts you can run it all on a low end ARM cpu like raspberry pi with a mounted USB harddrive!


# background info for this project.

this project is based on @oddworld9 work for a simple and cheap NVR solutions, all credits goes to him.
link: https://www.reddit.com/r/homelab/comments/7vjb7h/linux_bash_nvr_howto_for_network_ip_cameras/

this is my version of it.
what do we need on the linux distro to run these scripts?
  1. ffmpeg debian/ubuntu install via with <code>sudo apt-get install ffmpeg</code> same goes for Rasberry Pi
  2. A big harddrive, im using 2TB for 5 cameras.
  3. replace directory name to fit your setup!

first off, download the script to your <code>/opt/"dirname"</code> in my case, im pointing it to <code>/opt/cctv_recording/</code>
make them executeable - <code>sudo chmod +x /opt/"dirname"/*

there is 2 different records in this setup, that means each camera will be join 2 times on 2 different rtsp streams, the reason for this is that i have a low quality feed for long term archiving and high quality feed for 10 days recording.

thats why i have ```record_hq.sh``` and  ```record_lq.sh```  i could transcode from HQ to LQ, but that eat alot of cpu and instead i just join my sub stream on the camera with really low settings.


#Prepare your storage

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

make sure the drive is ext3 or ext4 formatted, start ved find the path to the device.

```
df -h | grep mnt
/dev/sda        1,8T  1,7T   76G  96% /mnt/cctv
```
look for the /dev/sdXX that is the device path, so make sure that you dont have anything on the drive you want to save before formating it.

to unmount the drive, so you can format it type:

``` unmount /path/to/mount ```

no the drive is unmount and ready to get formatted.

ext4 or ext3 format is up to you, im running ext4

ext4:
```sudo mkfs.ext4 /dev/sdXX```
or
ext3
```sudo mkfs.ext3 /dev/sdXX```

afterwards we can mount it to the path we want. remember to make a folder where you want it mounted to - in my case it would be

```sudo mount /dev/sda /mnt/cctv```

no you should be ready for script recording your cameras!


# Crontab final step!

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

