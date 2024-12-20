package;

import WeekData.Week;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;

class FreeplayState extends MusicBeatState
{
	var bg:FlxSprite;
	var songs:Array<Week> = [];
	private var grpSongs:FlxTypedGroup<Alphabet>;
	var curSelected:Int = 0;

	override function create()
	{
		super.create();

		WeekData.loadJsons(false);
		for (i in WeekData.weeksList)
		{
			songs.push(WeekData.currentLoadedWeeks.get(i));
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

	override function update(elapsed:Float)
	{
		super.update(elapsed);
		if (controls.justPress(ESCAPE))
			switchState(new MainMenuState());
	}
}