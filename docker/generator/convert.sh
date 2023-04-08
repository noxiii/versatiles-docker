#!/bin/bash
set -e
source_dir="/data/source"
tile_dir="/data/tiles"
prepared_dir="/data/prepared"
ls -lah /data
mkdir -p ${source_dir} ${tile_dir} ${prepared_dir}

if [ -z "${TILE_NAME}" ]
then
    TILE_NAME="osm"
fi

file_name=${SOURCE_URL##*/}
file_path="${source_dir}/${file_name}"

if [ ! -f "${file_path}" ] 
then
    echo "Download source: ${SOURCE_URL}"
    curl "${SOURCE_URL}" --output "${file_path}"
fi

prepared_file="${prepared_dir}/${TILE_NAME}.pbf"
osmium renumber --progress --overwrite -o "${prepared_file}" "${file_path}"

time tilemaker --input "${prepared_file}" --config /opt/shortbread-tilemaker/config.json --process /opt/shortbread-tilemaker/process.lua --output "${tile_dir}/${TILE_NAME}.mbtiles" --compact
