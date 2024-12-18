package;

import flixel.addons.ui.FlxUIState;

class MusicBeatState extends FlxUIState
{
	var controls:Controls;
	var curBeat:Int = 0;
	var curStep:Int = 0;

	override function create()
	{
		super.create();
	}

	override function update(elapsed:Float)
	{
		var oldStep:Int = curStep;

		updateCurStep();
		updateCurBeat();

		if (oldStep != curStep && curStep > 0)
			stepHit();

		super.update(elapsed);
	}

	private function updateCurBeat():Void
	{
		curBeat = Math.floor(curStep / 4);
	}

	private function updateCurStep():Void
	{
		curStep = Math.floor(Conductor.songPosition / Conductor.stepCrochet);
	}

	public function stepHit():Void
	{
		if (curStep % 4 == 0)
			beatHit();
	}

	public function beatHit():Void {}
}