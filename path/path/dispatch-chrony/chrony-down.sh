#!/bin/sh

source $(dirname "$(readlink -f "$0")")/chrony-netctl.conf

chrony_cmd offline
