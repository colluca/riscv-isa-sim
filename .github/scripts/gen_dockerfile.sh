#!/usr/bin/env bash

export filename="Dockerfile"
rm -f $filename
touch $filename

echo "FROM $full_tgtname" >> $filename
echo >> $filename
if [ $(echo $full_tgtname | cut -d ':' -f 1) = "ubuntu" ]; then
  echo 'RUN apt update && apt -y install build-essential curl device-tree-compiler' >> $filename
fi
if [ $(echo $full_tgtname | cut -d ':' -f 1) = "almalinux" ]; then
  if [ $(echo $full_tgtname | cut -d ':' -f 2 | cut -d '.' -f 1) = '8' ]; then
    echo 'RUN rpm --import https://repo.almalinux.org/almalinux/RPM-GPG-KEY-AlmaLinux' >> $filename
  fi
  echo 'RUN dnf -y update && dnf -y group install "Development Tools"' >> $filename
  echo 'RUN dnf config-manager --add-repo /etc/yum.repos.d/almalinux-powertools.repo' >> $filename
  echo 'RUN dnf config-manager --set-enabled powertools' >> $filename
  echo 'RUN dnf -y install dtc' >> $filename
fi
echo >> $filename
echo 'WORKDIR /source' >> $filename
