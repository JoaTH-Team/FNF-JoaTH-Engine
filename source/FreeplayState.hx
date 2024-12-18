package;

import flixel.FlxG;
import flixel.FlxSprite;

class FreeplayState extends MusicBeatState
{
	var bg:FlxSprite;

	override function create()
	{
		super.create();
		bg = new FlxSprite(0, 0, Paths.image("menuDesat"));
		add(bg);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
		if (controls.justPress(ESCAPE))
			FlxG.switchState(new MainMenuState());
	}
}