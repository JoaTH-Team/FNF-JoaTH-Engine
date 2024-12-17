package;

import flixel.FlxGame;
import flixel.FlxSprite;
import openfl.display.FPS;
import openfl.display.Sprite;

class Main extends Sprite
{
	public function new()
	{
		super();
		addChild(new FlxGame(0, 0, TitleState));
		addChild(new FPS(10, 3, 0xffffff));
		FlxSprite.defaultAntialiasing = false;
	}
}
