#!/bin/bash

sed --in-place "s|%directory%|$PWD|" exporter_sysinfo.service
sed --in-place "s|%user%|$USER|" exporter_sysinfo.service
mv exporter_sysinfo.service /etc/systemd/system/
systemctl start exporter_sysinfo.service
systemctl enable exporter_sysinfo.service
