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
"C:\Program Files\Inno Setup 5\iscc" wander.iss

zip Output\wandering-hamster.zip wander.rpg LICENSE-*.txt readme-wander.txt readme-how-do-I-play.txt wanderp.hss

rm wander.rpg wander.exe SDL*.dll
pause