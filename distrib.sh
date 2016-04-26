#!/bin/sh

cd ~/src/ohr/games/wander/
rm wandering-hamster.zip
~/src/ohr/wip/ohrrpgce-custom -distrib zip wander.rpgdir
if [ ! -f "wandering-hamster.zip" ] ; then
  echo "Unable to export wandering-hamster.zip"
  exit 1
fi
scp -p wandering-hamster.zip james_paige@motherhamster.org:HamsterRepublic.com/dl/
rm setup-wandering-hamster.exe
~/src/ohr/wip/ohrrpgce-custom -distrib win wander.rpgdir
if [ ! -f "setup-wandering-hamster.exe" ] ; then
  echo "Unable to export setup-wandering-hamster.exe"
  exit 1
fi
scp -p setup-wandering-hamster.exe james_paige@motherhamster.org:HamsterRepublic.com/dl/wandering-hamster.exe
