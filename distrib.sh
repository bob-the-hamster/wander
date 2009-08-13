#!/bin/sh

RELUMP=~/src/ohr/wip/relump

rm -Rf distrib
mkdir distrib
cd distrib

wget http://hamsterrepublic.com/ohrrpgce/nightly/ohrrpgce-wip-default.zip
unzip ohrrpgce-wip-default.zip game.exe *.dll svninfo.txt
rm ohrrpgce-wip-default.zip

SVN=`grep "^Last Changed Rev:" svninfo.txt | cut -d " " -f 4`
DATE=`grep "^Last Changed Date:" svninfo.txt | cut -d " " -f 4 | tr "-" "."`

mv game.exe wander.exe
"${RELUMP}" ../wander.rpgdir ./wander.rpg
cp ../LICENSE.txt .
cp ../README.txt .
cp ../wander.hss .
cp ../wander.ico .

# Create the zip file
rm ../wandering-hamster.zip
zip ../wandering-hamster.zip wander.exe wander.rpg LICENSE.txt README.txt *.dll wander.hss

# Create the Windows installer
cat << EOF > wander.iss
[Setup]
AppName=Wandering Hamster
AppVerName=Wandering Hamster ${DATE}.${SVN}
VersionInfoVersion=${DATE}.${SVN}
AppPublisher=Hamster Republic Productions
AppPublisherURL=http://HamsterRepublic.com/ohrrpgce/
AppSupportURL=http://HamsterRepublic.com/ohrrpgce/index.php/Game_Wandering_Hamster.html
AppUpdatesURL=http://HamsterRepublic.com/ohrrpgce/index.php/Game_Wandering_Hamster.html
AppReadmeFile={app}\README.txt
DefaultDirName={pf}\Hamster Republic\Wandering Hamster
DefaultGroupName=Wandering Hamster
DisableProgramGroupPage=yes
AllowNoIcons=yes
AllowUNCPath=no
LicenseFile=LICENSE.txt
InfoAfterFile=README.txt
OutputBaseFilename=wandering-hamster
Compression=bzip
SolidCompression=yes
ChangesAssociations=no
UninstallDisplayIcon={app}\wander.ico

[Languages]
Name: "eng"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"

[Files]
Source: "wander.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "SDL.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "SDL_mixer.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "wander.rpg"; DestDir: "{app}"; Flags: ignoreversion
Source: "wander.hss"; DestDir: "{app}"; Flags: ignoreversion
Source: "wander.ico"; DestDir: "{app}"; Flags: ignoreversion
Source: "README.txt"; DestDir: "{app}"; Flags: ignoreversion
Source: "LICENSE.txt"; DestDir: "{app}"; Flags: ignoreversion
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{group}\Wandering Hamster"; Filename: "{app}\wander.exe"; Flags: closeonexit
Name: "{group}\Wandering Hamster (fullscreen)"; Filename: "{app}\wander.exe"; Parameters: "-f"; Flags: closeonexit
Name: "{userdesktop}\Wandering Hamster"; Filename: "{app}\wander.exe"; Flags: closeonexit; Tasks: desktopicon
EOF

wine "C:\Program Files\Inno Setup 5\iscc" wander.iss
mv Output/wandering-hamster.exe ../
rmdir Output
