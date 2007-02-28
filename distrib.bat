cp ..\..\wip\SDL.dll .
cp ..\..\wip\SDL_mixer.dll .
cp ..\..\wip\game.exe wander.exe
..\..\wip\relump wander.rpgdir
"C:\Program Files\Inno Setup 5\iscc" wander.iss
rm wander.rpg wander.exe SDL*.dll
pause