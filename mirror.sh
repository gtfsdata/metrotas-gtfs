#!/bin/bash
# GTFS mirroring tool.  This allows us to keep the GTFS data from Translink and
# qConnect into a revision control system (so we could look up historical data).
#
# Copyright 2011, 2015 Michael Farrell <http://micolous.id.au>
#
# This program is free software. It comes without any warranty, to
# the extent permitted by applicable law. You can redistribute it
# and/or modify it under the terms of the Do What The Fuck You Want
# To Public License, Version 2, as published by Sam Hocevar. See
# http://sam.zoy.org/wtfpl/COPYING for more details.

DATA_ZIP="http://www.metrotas.com.au/transit"

# Create the target folder
mkdir -p "gtfs"

# Tasmanian data is in several parts, need to grab each...
for region in Burnie Hobart Launceston
do
	mkdir -p "gtfs/${region}"
	pushd "gtfs/${region}"
	wget -N "${DATA_ZIP}/${region}/google_transit.zip"

	unzip -ouL "google_transit.zip"
	git add *.txt
	popd
done

# Commit
DATE="`date`"
MSG="New data from upstream source on ${DATE}"

git commit -am "${MSG}"

# Push downstream to github
git push origin master

