package;

import WeekData.Week;
import WeekData;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

typedef SongMetaData = 
{
	var name:String;
	var week:Int;
	var color:String;
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
				for (song in WeekData.currentLoadedWeeks.get(WeekData.weeksList[i]).songs)
				{
					songs.push({
						name: song.name,
						week: i,
						color: song.color
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
			var songText:Alphabet = new Alphabet(0, (70 * i) + 30, songs[i].name, true, false);
			songText.isMenuItem = true;
			songText.targetY = i;
			grpSongs.add(songText);
		}
		changeSelection();
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
		bg.color = FlxColor.interpolate(bg.color, FlxColor.fromString("#" + songs[curSelected].color.toUpperCase()), 0.145);

		if (controls.justPress(ESCAPE))
			switchState(new MainMenuState());
		if (controls.justPress(UP) || controls.justPress(DOWN))
			changeSelection(controls.justPress(UP) ? -1 : 1);
		if (controls.justPress(ENTER))
		{
			trace("not done yet!");
		}
	}

	function changeSelection(change:Int = 0)
	{
		curSelected += change;

		if (curSelected < 0)
			curSelected = songs.length - 1;
		if (curSelected >= songs.length)
			curSelected = 0;

		var bullShit:Int = 0;

		for (item in grpSongs.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;

			if (item.targetY == 0)
				item.alpha = 1;
		}
	}
}