IF EXIST ..\..\wip%1 GOTO usewip
IF NOT EXIST ..\..\rel\%1 GOTO usewip
set USEVER=..\..\rel\%1
GOTO begin

:usewip
set USEVER=..\..\wip

:begin
cp %USEVER%\SDL.dll .
cp %USEVER%\SDL_mixer.dll .
cp %USEVER%\game.exe wander.exe
..\..\wip\relump wander.rpgdir
rm Output\wandering-hamster.exe
"C:\Program Files\Inno Setup 5\iscc" wander.iss
rm Output\wandering-hamster.zip
zip Output\wandering-hamster.zip wander.exe SDL.dll SDL_mixer.dll wander.rpg LICENSE-*.txt readme-wander.txt wander.hss

rm wander.rpg wander.exe SDL*.dll
pause
