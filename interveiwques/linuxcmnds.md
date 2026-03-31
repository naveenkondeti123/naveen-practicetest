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