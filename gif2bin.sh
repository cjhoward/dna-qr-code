#!/bin/bash

# Copyright (C) 2018  Christopher J. Howard
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

# Converts an animated GIF of QR codes to a binary file.
# Dependencies: imagemagick, zbar-tools
#
# usage: gif2bin.sh <input gif> <output file>

in_filename="$(basename $1)"
out_filename="$(basename $2)"

# Extract QR code frames from animated GIF
convert -coalesce $1 /tmp/$in_filename.part%08d.png

# For each QR code
for i in /tmp/$in_filename.part*.png; do
	
	# Resize QR code so zbarimg can better scan it
	convert $i -interpolate Nearest -filter point -resize 200% $i

	# Scan QR code and store the resulting Base32 data
	zbarimg --raw -Sdisable -Sqr.enable $i >> /tmp/$out_filename.b32
done

# Decode Base32 data to get the original data
base32 -d -w 0 -i /tmp/$out_filename.b32 > $2

# Remove temporary files
rm /tmp/$in_filename.part*.png /tmp/$out_filename.b32
