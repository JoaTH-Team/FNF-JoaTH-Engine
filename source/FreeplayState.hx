package;

import WeekData;
import WeekData.Week;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;

typedef SongMetaData = 
{
	var name:String;
	var week:Int;
}

class FreeplayState extends MusicBeatState
{
	var bg:FlxSprite;
	var songs:Array<SongMetaData> = [];
	private var grpSongs:FlxTypedGroup<Alphabet>;
	var curSelected:Int = 0;

	override function create()
	{
		super.create();

		WeekData.loadJsons(false);

		for (i in 0...WeekData.weeksList.length)
		{
			if (!weekIsLocked(WeekData.weeksList[i]))
			{
				for (song in WeekData.currentLoadedWeeks.get(Week.weeksList[i]).songs)
				{
					songs.push({
						name: song.name,
						week: i
					});
				}
			}
		}
		
		bg = new FlxSprite(0, 0, Paths.image("menuDesat"));
		add(bg);
		grpSongs = new FlxTypedGroup<Alphabet>();
		add(grpSongs);

		for (i in 0...songs.length)
		{
			var songText:Alphabet = new Alphabet(90, 320, songs[i].name, true);
			songText.isMenuItem = true;
			songText.targetY = i - curSelected;
			grpSongs.add(songText);
		}
	}

	private function weekIsLocked(name:String):Bool
	{
		var daWeek:Week = WeekData.currentLoadedWeeks.get(name);
		return (daWeek.locked
			&& daWeek.unlockAfter.length > 0); // there was also story code but i had to take it out because no story mode yet lol
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
		if (controls.justPress(ESCAPE))
			switchState(new MainMenuState());
	}
}