#!/bin/sh

WANDERDIR=~/Dropbox/src/wander/
OHRDIR=~/src/ohrrpgce/

cd "${WANDERDIR}"

# The list of files to upload
FILES="\
 wandering-hamster.zip \
 wandering-hamster.exe \
 wandering-hamster-mac.zip \
 wandering-hamster-linux-x86_64.tar.gz \
 wandering-hamster_amd64.deb \
 "

# Remove old files that might still be present
for FILE in ${FILES} ; do
 rm -f "{$FILE}"
done
rm -f wandering-hamster_*.deb
rm -f wandering-hamster-setup.exe

# Perform the export
"${OHRDIR}"/ohrrpgce-custom -distrib all wander.rpgdir

# Rename some files
mv wandering-hamster-setup.exe wandering-hamster.exe
mv wandering-hamster_????.??.??_amd64.deb wandering-hamster_amd64.deb

# Remove some currently unused files
rm wandering-hamster_????.??.??_i386.deb
rm wandering-hamster-mac-32bit.zip
rm wandering-hamster-linux-x86.tar.gz
rm wandering-hamster-web.zip

# Verify that all the required files are present
for FILE in ${FILES} ; do
  if [ ! -f "${FILE}" ] ; then
    echo "Unable to export ${FILE}"
    exit 1
  fi
done

# Perform the upload
for FILE in ${FILES} ; do
  scp -p "${FILE}" james_paige@motherhamster.org:HamsterRepublic.com/dl/
done

