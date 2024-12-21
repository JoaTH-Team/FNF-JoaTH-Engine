package;

import flixel.FlxSprite;

class CharacterEditorState extends MusicBeatState
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
			switchState(new MainMenuState());
	}
}