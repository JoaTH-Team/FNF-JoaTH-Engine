package;

import Song.SwagSong;

class PlayState extends MusicBeatState 
{
	public static var SONG:SwagSong;
	public static var instance:PlayState = null;

	override public function create()
	{
		instance = this;
		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
