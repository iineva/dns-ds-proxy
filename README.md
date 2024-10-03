# dns-sd-proxy

Proxy Bonjour cross network.

# Example for proxy SMB service

```shell
export SERVICE_NAME=NevaNAS
export SERVICE_IP=192.168.1.3
export SERVICE_PORT=445
go run github.como/iineva/dns-sd-proxy -name $SERVICE_NAME -service _smb._tcp -ip $SERVICE_IP -wait 0 -port $SERVICE_PORT
```

# Run on Docker

```shell
docker run --rm --network host -e SD_PROXY_NAME=NevaNAS -e SD_PROXY_SERVICE=_smb._tcp -e SD_PROXY_IP=192.168.1.3 -e SD_PROXY_PORT=445 ineva/dns-sd-proxy:1.0
```
