## 1. commands of linux advacned

1. find files changed in the last 10 minutes in a linux server
f ind /path/to/search -type f -mmin -10 (use find command path -type=files and mmin=10m)
2. telnet is used to test connectivity to a remote host and port.
3. netstat is used to display network connections, listening ports, and routing information.
4. server is running slow 
 check top -> check cpu usage
5. high cpu usage 
  top -> find which process
6. memory isuue 
    free-h -> chexk ram usage
7. the load is high but the cpu is normal
    iostat -> check disk isuue
8. disk slow
  iostat -> check disk performance
9. disk full
  df-h -> check space
10. which is large folder 
   du-sh -> find filr
11. which process are running  
   ps-ef -> list process
12. app not working 
 ss -tunlp -> check port/service
13. netwwork issue 
  ping ->check connectivity
14. app showing error
  tail -f logfile check live logs

15.find /var/log -type f -size +100M (files laeger tham 100mb)
16.find /var/log -type f -name "*.log" -mtime +30 -delete (files older than 30d)

17.#!/bin/bash
usage=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')
if [ "$usage" -gt 80 ]
then
    echo "Disk usage crossed 80%"
else
    echo "Disk usage is normal"
fi

18.#!/bin/bash

if pgrep nginx > /dev/null
then
    echo "Nginx is running"
else
    echo "Nginx is not running"  (process running)
fi

19.#!/bin/bash
tar -czf backup.tar.gz /home/app  (dir backup)

20.find / -type f -exec du -h {} + | sort -rh | head -10 (lrge 10 files)

21. #!/bin/bash
SOURCE="file1.txt"
DESTINATION="file2.txt"
cp "$SOURCE" "$DESTINATION"  # or (cat file1.txt > file2.txt)
echo "File copied successfully."
--
 Question | Key Command |
CPU High    | `top`, `htop`, `ps`, `uptime`
Memory High | `free -h`, `vmstat`, `ps`, `top`
Disk Full   | `df -h`, `du -sh`, `find`, `lsof`
Network     | `ss`, `netstat`
Historical CPU   | `sar` 
Disk Performance | `iostat`
Open Files       | `lsof` 
Logs             | `journalctl`, `dmesg` 
----
1.A federated cluster is a group of multiple Kubernetes clusters that are managed together from a single control plane or federation layer and Instead of managing each cluster separately, you can deploy and manage applications across multiple clusters from one place.


"There are two types. In a Kubernetes Deployment, maxSurge controls how many extra pods can be created during a rolling update. In AKS node pool upgrades, maxSurge controls how many extra nodes Azure temporarily adds during the upgrade to safely drain and upgrade existing nodes with minimal downtime."
--
#!/bin/bash

pods=$(kubectl get pods -n eeh-platform-dev | grep -i CrashLoopBackOff)

if [ -n "$pods" ]; then
    echo "List of crashed pods:"
    echo "$pods"
else
    echo "No pods are in CrashLoopBackOff state."
fi
----
#!/bin/bash
GROUP="ansibleuser"
USER="ansibleuser"

# Create group if it doesn't exist
if ! getent group $GROUP > /dev/null; then
    groupadd $GROUP
    echo "Group $GROUP created."
else
    echo "Group $GROUP already exists."
fi

# Create user if it doesn't exist
if ! id $USER &>/dev/null; then
    useradd -m -g $GROUP $USER
    echo "User $USER created and added to $GROUP."
else
    echo "User $USER already exists."
fi
echo $user ALL=(ALL) NOPASSWD:ALL





 

