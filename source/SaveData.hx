package;

import flixel.FlxG;

@:structInit class SaveSetting
{
	public var defaultAntialiasing:Bool = true;
	public var reloadMods:Bool = false;
}

class SaveData
{
	public static var settings:SaveSetting = {};

	public static function init()
	{
		for (key in Reflect.fields(settings))
			if (Reflect.field(FlxG.save.data, key) != null)
				Reflect.setField(settings, key, Reflect.field(FlxG.save.data, key));
	}

	public static function saveSettings()
	{
		for (key in Reflect.fields(settings))
			Reflect.setField(FlxG.save.data, key, Reflect.field(settings, key));

		FlxG.save.flush();

		trace('settings saved!');
	}
}