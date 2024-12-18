package;

import flixel.FlxG;
import flixel.input.keyboard.FlxKey;

class Controls
{
	public function press(key:FlxKey)
	{
		return FlxG.keys.anyPressed([key]);
	}
	public function justPress(key:FlxKey)
	{
		return FlxG.keys.anyJustPressed([key]);
	}

	public function justRelease(key:FlxKey)
	{
		return FlxG.keys.anyJustReleased([key]);
	}
}