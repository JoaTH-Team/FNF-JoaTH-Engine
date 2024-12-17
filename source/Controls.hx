package;

import flixel.FlxG;
import flixel.input.keyboard.FlxKey;

class Controls
{
	public function press(key:FlxKey)
	{
		return FlxG.keys.anyPressed([key]);
	}
}