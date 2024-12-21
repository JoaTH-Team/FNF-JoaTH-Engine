package;

import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;

class EditorState extends MusicBeatState
{
    var editorArray:Array<String> = [
        "Chart Editors",
        "Characters Editors",
    ];
    var grpControls:FlxTypedGroup<Alphabet>;
	var curSelected(default, null):Int = 0;
    var bg:FlxSprite;

    override function create() {
        super.create();

		bg = new FlxSprite(0, 0, Paths.image("menuDesat"));
        bg.color = 0xff807377;
		add(bg);

        grpControls = new FlxTypedGroup<Alphabet>();
        add(grpControls);

        for (i in 0...editorArray.length) {
            var editorText:Alphabet = new Alphabet(0, (70 * i) + 30, editorArray[i], true, false);
            editorText.isMenuItem = true;
            editorText.targetY = i;
            grpControls.add(editorText);
        }

        changeSelection();
    }    

    override function update(elapsed:Float) {
        super.update(elapsed);
    
		if (controls.justPress(ESCAPE))
			switchState(new MainMenuState());
		if (controls.justPress(UP) || controls.justPress(DOWN))
			changeSelection(controls.justPress(UP) ? -1 : 1);
        if (controls.justPress(ENTER))
		{
			switch (editorArray[curSelected])
			{
                case "Chart Editors":
                    switchState(new ChartingState());
			}
		}
    }

	function changeSelection(change:Int = 0)
	{
		curSelected += change;

		if (curSelected < 0)
			curSelected = editorArray.length - 1;
		if (curSelected >= editorArray.length)
			curSelected = 0;

		var bullShit:Int = 0;

		for (item in grpControls.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;

			if (item.targetY == 0)
				item.alpha = 1;
		}
	}
}
