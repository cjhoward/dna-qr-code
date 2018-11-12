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

# Converts binary data to an animated GIF of QR codes.
# Dependencies: qrencode, ImageMagick
# Optional: Gifsicle for GIF optimization
#
# usage: bin2gif.sh <input file> <output gif>

in_filename="$(basename $1)"

# Encode input file in Base32
base32 -w 0 $1 > /tmp/$in_filename.b32

# Split Base32 data into chunks of no more than 4,296 characters, to match the
# alphanumeric encoding mode limit of QR codes
split -a 8 -C 4296 -d /tmp/$1.b32 /tmp/$in_filename.b32.part

# Encode each Base32 chunk as a QR code
for i in /tmp/$in_filename.b32.part*; do
	qrencode -i -v 40 -m 1 -s 1 -l L -o $i.png < $i
done

# Construct an animated GIF using the QR codes as frames
convert -dispose 2 -delay 0 -loop 0 /tmp/$in_filename.b32.part*.png $2

# Optimize the compression of the resulting GIF using Gifsicle
if [ -x "$(command -v gifsicle)" ]; then
	gifsicle -O3 $2 -o $2
fi

# Remove temporary files
rm /tmp/$in_filename.b32 /tmp/$in_filename.b32.part*
