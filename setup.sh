#!/bin/bash
dir=$(cd $(dirname $0); pwd)
os=$(uname | tr '[A-Z]' '[a-z]')

setup_script="$dir/setup_$os.sh"

if [ ! -e $setup_script ]; then
  echo "Aborted. Setup script for os '$os' doesn't exist!"
  exit 1
fi

echo "/bin/bash $setup_script"
