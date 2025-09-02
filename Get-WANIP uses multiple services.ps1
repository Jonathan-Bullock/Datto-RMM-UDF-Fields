(Invoke-RestMethod -Uri "https://ipinfo.io/").ip
(Invoke-WebRequest -Uri "https://api.ipify.org/" -UseBasicParsing).Content
(Invoke-WebRequest -Uri "https://ifconfig.me/ip" -UseBasicParsing).Content
nslookup myip.dnsfilter.com