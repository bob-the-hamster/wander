#!/bin/sh

WANDERDIR=~/src/ohr/games/wander/
OHRDIR=~/src/ohrrpgce/

cd "${WANDERDIR}"

FILES="\
 wandering-hamster.zip \
 wandering-hamster.exe \
 wandering-hamster-mac.zip \
 wandering-hamster-linux-x86.tar.gz \
 wandering-hamster-linux-x86_64.tar.gz \
 wandering-hamster_amd64.deb \
 wandering-hamster_i386.deb \
 "

for FILE in ${FILES} ; do
 rm -f "{$FILE}"
done

rm -f wandering-hamster_*.deb
rm -f setup-wandering-hamster.exe

"${OHRDIR}"/ohrrpgce-custom -distrib all wander.rpgdir
mv setup-wandering-hamster.exe wandering-hamster.exe
mv wandering-hamster_????.??.??_amd64.deb wandering-hamster_amd64.deb
mv wandering-hamster_????.??.??_i386.deb wandering-hamster_i386.deb

for FILE in ${FILES} ; do
  if [ ! -f "${FILE}" ] ; then
    echo "Unable to export ${FILE}"
    exit 1
  fi
done

for FILE in ${FILES} ; do
  scp -p "${FILE}" james_paige@motherhamster.org:HamsterRepublic.com/dl/
done

