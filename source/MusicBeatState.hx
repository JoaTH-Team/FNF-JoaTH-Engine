package;

import flixel.FlxG;
import flixel.addons.ui.FlxUIState;
import sys.FileSystem;

using StringTools;

class MusicBeatState extends FlxUIState
{
	var controls:Controls;
	var curBeat:Int = 0;
	var curStep:Int = 0;
	var classNameString:String = "MusicBeatState"; // in case
	var scriptArray:Array<HScript> = []; // be sure to clear every time switch state

	override function create()
	{
		super.create();
		classNameString = Type.getClassName(Type.getClass(this));
		// trace(classNameString);

		// script loading handler
		var foldersToCheck:Array<String> = [Paths.data('scripts/$classNameString/'), Paths.data("scripts/")];
		for (mod in PolyHandler.getModIDs())
		{
			foldersToCheck.push('mods/$mod/data/scripts/$classNameString/');
			foldersToCheck.push('mods/$mod/data/scripts/');
		}
		for (folder in foldersToCheck)
		{
			if (FileSystem.exists(folder) && FileSystem.isDirectory(folder))
			{
				for (file in FileSystem.readDirectory(folder))
				{
					if (file.endsWith(".hxs"))
					{
						scriptArray.push(new HScript(folder + file));
					}
				}
			}
		}

		callOnScripts("onCreate", []);
	}

	override function update(elapsed:Float)
	{
		var oldStep:Int = curStep;

		updateCurStep();
		updateCurBeat();

		if (oldStep != curStep && curStep > 0)
			stepHit();

		super.update(elapsed);
		callOnScripts("onUpdate", [elapsed]);
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
		callOnScripts("onStepHit", [curStep]);
	}

	public function beatHit():Void
	{
		callOnScripts("onBeatHit", [curBeat]);
	}

	public function switchState(nextState:MusicBeatState)
	{
		// gonna clear all script array first then switch state
		for (script in scriptArray)
		{
			script.interp = null;
		}
		scriptArray = [];
		FlxG.switchState(nextState);
	}

	function callOnScripts(funcName:String, funcArgs:Array<Dynamic>)
	{
		for (i in 0...scriptArray.length)
		{
			final script:HScript = scriptArray[i];
			script.call(funcName, funcArgs);
		}
	}
}