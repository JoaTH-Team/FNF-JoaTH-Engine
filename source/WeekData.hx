package;

import haxe.Json;
import openfl.Assets;
import sys.io.File;

using StringTools;

typedef Week = 
{
    var songs:Array<WeekSong>;
    var chars:Array<String>;
    var name:String;
    var locked:Bool;
    var unlockAfter:String;
    var hideStory:Bool;
    var hideFree:Bool;
    var hideUntilUnlock:Bool;
}

typedef WeekSong = 
{
    var name:String;
    var char:String;
	var color:String;
}

class WeekData
{
	public static var currentLoadedWeeks:Map<String, Week> = [];
	public static var weeksList:Array<String> = [];

	public static function loadJsons(isStoryMode:Bool = false)
	{
		currentLoadedWeeks.clear();
		weeksList = [];

		final list:Array<String> = Paths.getTextArray(Paths.txt('week/weekList'));
		for (i in 0...list.length)
		{
			if (!currentLoadedWeeks.exists(list[i]))
			{
				var week:Week = parseJson(Paths.json('week/' + list[i]));
				if (week != null)
				{
					if (week != null && (isStoryMode && !week.hideStory) || (!isStoryMode && !week.hideFree))
					{
						currentLoadedWeeks.set(list[i], week);
						weeksList.push(list[i]);
					}
				}
			}
		}
	}

	public static function parseJson(path:String):Week
    {
        var rawJson:String = null;

        if (Assets.exists(path))
            rawJson = Assets.getText(path);

        return rawJson != null ? Json.parse(rawJson) : null;
    }
}
