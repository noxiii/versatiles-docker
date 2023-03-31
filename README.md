# OSM Tile Server Docker Setup
This is a simple docker setup for a OSM Tile Server.

The main part of this docker setup is the versatiles Server. Big Thanks to the developer for this amazing application. Versatiles is a new very small, fast and independent Tail Server for osm.

The building of the Docker Image take currently more time but the Image for the Tile Server is only 8.25MB small. 

Additional you need a versatiles file and static files.
For the first you can use the pre build data from the versatiles Project.

## Setup

## Versatiles
### Parameter
```
Usage: versatiles <COMMAND> <PARAMETER>

Commands:
  convert  Convert between different tile containers
  serve    Serve tiles via http
  probe    Show information about a tile container
  compare  Compare two tile containers

Parameters:
serve
    --ip             -p <IP>
    --port           -p <PORT>
    --static_content -s <static_content dir>
```