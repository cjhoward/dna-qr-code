# DNA QR Code

This repository contains my genetic data encoded as an animated GIF of QR codes, along with two scripts which can perform the encoding and decoding, respectively. You can read about the process [on my blog](https://cjhoward.org/dna-qr-code).

## `bin2gif.sh`

This script can take any binary data and encode it as an animated GIF of QR codes. It depends on *qrencode* and *ImageMagick*, and optionally can use *Gifsicle* for further compression of the resulting GIF. The usage is as follows:

    usage: bin2gif.sh <input file> <output gif>

## `gif2bin.sh`

This script can take an animated GIF of QR codes, as generated by `bin2gif.sh`, and reconstruct the encoded data. It depends on *zbar-tools* and *ImageMagick*. The usage is as follows:

    usage: gif2bin.sh <input gif> <output file>

## `genome.7z.gif`

This is a 7z compressed archive containing my raw genetic data, then encoded as an animated GIF of QR codes. It can be decoded with the following command:

    gif2bin.sh genome.7z.gif genome.7z

## License    

The two scripts, `bin2gif.sh` and `gif2bin.sh` are licensed under the GNU General Public License, version 3. See [LICENSE](./LICENSE) for details. My raw genetic data, as sequenced by 23andMe, is essentially in the public domain, as I have provided it under the CC0 1.0 Universal license.
