#!/usr/bin/env bash
source <(curl -s https://raw.githubusercontent.com/tteck/Proxmox/main/misc/build.func)
# Copyright (c) 2021-2023 tteck
# Author: tteck (tteckster)
# License: MIT
# https://github.com/tteck/Proxmox/raw/main/LICENSE

function header_info {
clear
cat <<"EOF"
   __  __          __              __
  / / / /___ ___  / /_  ________  / /
 / / / / __ `__ \/ __ \/ ___/ _ \/ / 
/ /_/ / / / / / / /_/ / /  /  __/ /  
\____/_/ /_/ /_/_.___/_/   \___/_/   
                                     
EOF
}
header_info
echo -e "Loading..."
APP="Umbrel"
var_disk="8"
var_cpu="2"
var_ram="2048"
var_os="debian"
var_version="11"
variables
color
catch_errors

function default_settings() {
  CT_TYPE="1"
  PW=""
  CT_ID=$NEXTID
  HN=$NSAPP
  DISK_SIZE="$var_disk"
  CORE_COUNT="$var_cpu"
  RAM_SIZE="$var_ram"
  BRG="vmbr0"
  NET="dhcp"
  GATE=""
  DISABLEIP6="no"
  MTU=""
  SD=""
  NS=""
  MAC=""
  VLAN=""
  SSH="no"
  FUSE="no"
  VERB="no"
  echo_default
}

function update_script() {
header_info
msg_info "Updating ${APP} LXC"
apt-get update &>/dev/null
apt-get -y upgrade &>/dev/null
msg_ok "Updated ${APP} LXC"
exit
}

start
build_container
description

msg_ok "Completed Successfully!\n"
echo -e "${APP} should be reachable by going to the following URL (reboot is required before apps install).
    ${BL}http://${IP} ${CL} \n"