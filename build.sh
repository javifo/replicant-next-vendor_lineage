#!/bin/bash
# Copyright (C) 2020 Denis 'GNUtoo' Carikli' <GNUtoo@cyberdimension.org>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
set -e

supported_machines=" \
    i9300 \
    i9305 \
"

usage()
{
	printf "%s [" "$0"
	for machine in ${supported_machines} ; do
		printf "${machine}|"
	done
	printf "\b]\n"
	printf "%s all # build all machines\n" "$0"
	exit 1
}

build()
{
    machine="$1"
    parallel_tasks=$(echo "$(grep 'processor' /proc/cpuinfo | wc -l ) + 1" | bc)
    mkdir -p logs
    log="logs/build_${machine}_$(date '+%s').log"

    echo "starting to building for ${machine}: ${log}"
    source build/envsetup.sh
    lunch "lineage_${machine}-userdebug"
    time make -j$parallel_tasks 2>&1 | tee "${log}"
    # vendor/replicant/sign-build "${machine}" | tee -a "${log}"
    echo "${machine} DONE: ${log}"
}

if [ $# -ne 1 ] ; then
	usage
fi

if [ "$1" = "all" ] ; then
    for machine in ${supported_machines} ; do
	build "${machine}"
    done
else
    found=0
    for machine in ${supported_machines} ; do
	if [ "${machine}" = "$1" ] ; then
	    found=1
	fi
    done

    if [ ${found} -eq 0 ] ; then
	printf "machine %s not supported\n" "$1"
	usage
    fi

    build "$1"
fi
