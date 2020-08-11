#!/bin/sh
# Copyright (C) 2020 Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

usage()
{
	echo "$0 clean"
	exit 1
}

# Guard against accidental usage without arguments
# people are used to do ./script.sh to get the help
if [ $# -ne 1 ] ; then
	usage
elif [ "$1" != "clean" ] ; then
	usage
fi

if [ -z "${OUT}" ] ; then
  echo "Error: cannot find \$OUT"
  echo "You might need to run the following commands in the current shell:"
  echo "    source build/envsetup.sh"
  echo "    lunch <target>"
  exit 1
fi

rm -rf "${OUT}/obj/STATIC_LIBRARIES/libmesa_*"
rm -rf "${OUT}/gen/STATIC_LIBRARIES/libmesa_*"
rm -rf "${OUT}/symbols/system/vendor/lib/egl/libGLES_mesa.so"
rm -rf "${OUT}/system/vendor/lib/egl/libGLES_mesa.so"
