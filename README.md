# System monitoring

This repository contains my simple system information exporter for Unix and multi-container environment (Nginx, Prometheus, Grafana) to run monitoring on any machine.  

## Prequisites

You will need to have the following installed locally to start:

- [Docker](https://docs.docker.com/install/)
- [Docker Compose](https://docs.docker.com/compose/install/)

## Exporter
System information exporter is the bash script that collects information on basic linux system metrics (CPU, RAM, hard disk).   

Exporter make a html page in __Prometheus__ format, which will be served by __Nginx__.  

| Metric | Description|
| ------ | ------ |
| mem_total_bytes |  Total RAM memory in bytes |
| mem_used_bytes |  Used RAM memory in bytes |
| mem_free_bytes |  Free RAM memory in bytes |
| mem_shared_bytes |  Shared RAM memory in bytes |
| mem_buffcache_bytes |  Buff/Cache RAM memory in bytes |
| mem_available_bytes |  Available RAM memory in bytes |
| disk_total_bytes |  Total disk space in bytes |
| disk_used_bytes |  Used disk space in bytes |
| disk_available_bytes |  Available disk space in bytes |
| cpu_idle | CPU usage for idle proccess in percentage |
| cpu_usage | CPU usage in percentage |

## Run exporter as system daemon service

Use _install.sh_ script to configure, install and run exporter on your linux system (required sudo permissions).

## Run docker containers 

Start Grafana for and the supporting services:

```
docker-compose up -d
```

## Log in to Grafana

Grafana is an open-source platform for monitoring and observability that lets you visualize and explore the state of your systems.

 - Open a new tab.
 - Browse to localhost:3000.
 - In email or username, enter admin.
 - In password, enter admin.
 - Click Log In.

The information about system are stored in Prometheus.

To be able to visualize the metrics, you first need to add Prometheus as a data source in Grafana.

 - In the side bar, hover your cursor over the Configuration (gear) icon, and then click Data Sources.
 - Click Add data source.
 - In the list of data sources, click Prometheus.
 - In the URL box, enter http://prometheus:9090.
 - Click Save & Test.
 - Prometheus is now available as a data source in Grafana.

## Import dashboard

To import a dashboard click Import under the Dashboards icon in the side menu.

From here you need to upload a dashboard JSON file (grafana/system_monitoring.json in this reporitory)

