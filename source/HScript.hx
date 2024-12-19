package;

import flixel.*;
import flixel.text.FlxText;
import hscript.*;
import sys.io.File;

using StringTools;

class HScript extends FlxBasic
{
	public var locals(get, set):Map<String, {r:Dynamic}>;

	function get_locals():Map<String, {r:Dynamic}>
	{
		@:privateAccess
		return interp.locals;
	}

	function set_locals(local:Map<String, {r:Dynamic}>)
	{
		@:privateAccess
		return interp.locals = local;
	}

	public static var Function_Stop:Dynamic = 1;
	public static var Function_Continue:Dynamic = 0;

	public var interp:Interp;
	public var parser:Parser;

	public function new(file:String)
	{
		super();
		parser.allowJSON = parser.allowMetadata = parser.allowTypes = true;
		// set some most using class
		setVar("FlxG", FlxG);
		setVar("FlxSprite", FlxSprite);
		setVar("FlxText", FlxText);
		setVar("FlxCamera", FlxCamera);
		execute(file);
	}

	public function setVar(nameVar:String, value:Dynamic):Void
		return interp.variables.set(nameVar, value);

	public function getVar(nameVar:String):Dynamic
		return interp.variables.get(nameVar);

	public function existsVar(nameVar:String):Bool
		return interp.variables.exists(nameVar);

	public function call(name:String, args:Array<Dynamic>)
	{
		if (existsVar(name))
		{
			try
			{
				return Reflect.callMethod(this, getVar(name), args == null ? [] : args);
			}
			catch (e:Dynamic)
			{
				haxe.Timer.delay(function()
				{
					trace('HScript Error: ' + Std.string(e));
				}, 0);
			}
		}

		return null;
	}

	/**
	 * To execute a script file
	 * @param script you don't need to add a `.hxs` since it will be added automatically
	 */
	public function execute(script:String):Void
	{
		var program = parser.parseString(File.getContent(Paths.file(script + ".hxs")));
		interp = new Interp();
		interp.execute(program);
	}

	public function getAll():Dynamic
	{
		var balls:Dynamic = {};

		for (i in locals.keys())
			Reflect.setField(balls, i, getVar(i));
		for (i in interp.variables.keys())
			Reflect.setField(balls, i, getVar(i));

		return balls;
	}

	override function destroy()
	{
		super.destroy();
		parser = null;
		interp = null;
	}
}