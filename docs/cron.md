# The Cron Job

```bash
#!/bin/bash
mkdir nginx_backup

# Specify the backup location
backup_location="/home/vagrant/nginx_backup"

# Create the backup directory if it doesn't exist
mkdir -p "$backup_location"

# Add the cron job to perform the backup
(crontab -l 2>/dev/null; echo "0 0 * * * sudo cp -R /etc/nginx /var/log /var/www/html $backup_location") | crontab -

echo "Cron job for nginx backup has been successfully set up."
```

```0 0 * * *```: This is the cron job schedule expression. It specifies the timing for the job to run. In this case, it means the job will run at minute 0 and hour 0 (midnight) every day.

```cp -R  /etc/nginx /var/log/nginx /var/www/home /home/<your_username>/nginx_backup```: This is the command that will be executed by the cron job. It uses the ```cp``` command to copy directories and their contents recursively (-R flag). It will copy the directories ```/www/var/nginx```, ```/etc/nginx```, ```/var/log/nginx```, and ```/var/www``` to the destination directory ```/home/<your_username>/nginx_backup```.

<img width="567" alt="image" src="https://github.com/Mbaoma/loadbalancing-local-vms/assets/49791498/5b1f4c82-a4f0-4297-9b01-cb246812ec92">

This script creates the cron job will perform the backup at midnight every day.

## Timing In Cron Jobs
- ```Minute (0-59)```: Specifies the minute when the job should run.
- ```Hour (0-23)```: Specifies the hour when the job should run.
- ```Day of the month (1-31)```: Specifies the day of the month when the job should run.
- ```Month (1-12 or abbreviations like JAN, FEB)```: Specifies the month when the job should run.
Day of the week (0-6 or abbreviations like SUN, MON): Specifies the day of the week when the job should run (0 or 7 represents Sunday).

Each field can have a specific value or a range of values separated by commas. Asterisks () can be used as wildcards to indicate any value. For example, "" in the minute field means "every minute."

Additionally, you can use other special characters to define the timing:

- Forward slash (/): Specifies a step value. For example, ```*/5``` in the minute field means every 5 minutes.
- Hyphen (-): Specifies a range of values. For example, ```10-15``` in the hour field means the job should run between the 10th and 15th hour.
- Comma (,): Specifies multiple specific values. For example, ```1,15``` in the day of the month field means the job should run on the 1st and 15th day of the month.
