package;

import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxSprite;
import openfl.display.FPS;
import openfl.display.Sprite;

class Main extends Sprite
{
	public static var fps:FPS;

	public function new()
	{
		super();
		FlxG.save.bind('funkin', 'joathEngine');
		SaveData.init();
		SaveData.saveSettings();
		addChild(new FlxGame(0, 0, TitleState));
		fps = new FPS(10, 3, 0xffffff);
		if (SaveData.settings.showFPS)
			fps.visible = true;
		else
			fps.visible = false;
		addChild(fps);

		FlxSprite.defaultAntialiasing = SaveData.settings.defaultAntialiasing;
	}
}
