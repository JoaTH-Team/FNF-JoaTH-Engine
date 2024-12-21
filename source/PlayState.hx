package;

import Song.SwagSong;

class PlayState extends MusicBeatState 
{
	public static var SONG:SwagSong;
	public static var instance:PlayState = null;

	override public function create()
	{
		instance = this;
		foldersToCheck.push(Paths.file("data/songs/" + SONG.song.toLowerCase() + "/"));
		for (mod in PolyHandler.getModIDs())
		{
			foldersToCheck.push('mods/$mod/data/songs/' + SONG.song.toLowerCase() + '/');
		}

		for (i in 0...scriptArray.length)
		{
			scriptArray[i].setVar("playState", instance);
		}

		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
