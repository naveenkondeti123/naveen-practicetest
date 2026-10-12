1 Install helm chart using the downloading the helmcart binary from curl https:// git io/get_helm.sh
2.when u crate a chart ( helm crate helloward )by defult u get all the templets.yamls like hpa.yml service yml depolymnt.yml  in tree format
3.helm unistall helloword (unistal helm chart)
4.helm crate ( crates a chart heloworld)
5.helm install (helm install myhellowirldrelease helloworld)
It will crate a relaease from chart with versioning
6.upgrade helm chart ( helm upgrade myhellowirldrelease helloworld) if we have to incrase the replica a modifictaion and using upgrade will have a version upgrade 
7.helm list -a ( gives the chart and version info)
8.helm rollback ( helm rollback myhellowirldrelease 1 ) rolling back to previos version 
8.helm lint (helm lint hellowrold) any misconfiguration we can use lint and chek chart
9.helmfile sync usied to have single file and write commands
___
Release:
 -Name: helloworld
 Chart: ./helloword
   Installedl: true
