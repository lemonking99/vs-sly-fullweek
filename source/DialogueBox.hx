package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxKeyManager;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

using StringTools;

class DialogueBox extends FlxSpriteGroup
{
	var box:FlxSprite;

	var curCharacter:String = '';

	var dialogue:Alphabet;
	var dialogueList:Array<String> = [];

	// SECOND DIALOGUE FOR THE PIXEL SHIT INSTEAD???
	var swagDialogue:FlxTypeText;

	var dropText:FlxText;

	public var finishThing:Void->Void;

	var portraitLeft:FlxSprite;
	var portraitLeftB:FlxSprite;
	var portraitLeftC:FlxSprite;
	var portraitRight:FlxSprite;

	var handSelect:FlxSprite;
	var bgFade:FlxSprite;

	public function new(talkingRight:Bool = true, ?dialogueList:Array<String>)
	{
		super();

		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				FlxG.sound.playMusic(Paths.music('Lunchbox'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'thorns':
				FlxG.sound.playMusic(Paths.music('LunchboxScary'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'wow':
				FlxG.sound.playMusic(Paths.music('sly1', 'shared'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'hoodie':
			FlxG.sound.playMusic(Paths.music('sly2', 'shared'), 0);
			FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'quake':
			// new FlxTimer().start(44, function(tmr:FlxTimer)
			// {
			// FlxG.sound.playMusic(Paths.music('sly3', 'shared'), 0);
			// FlxG.sound.music.fadeIn(1, 0, 0.8);
			// });
			case 'demise':
			// FlxG.sound.playMusic(Paths.music('sly4', 'shared'), 0);
			// FlxG.sound.music.fadeIn(1, 0, 0.8);
			// figure out where to place this music later
			// FlxG.sound.playMusic(Paths.music('sly3', 'shared'), 0);
			// FlxG.sound.music.fadeIn(1, 0, 0.8);
		}

		bgFade = new FlxSprite(-200, -200).makeGraphic(Std.int(FlxG.width * 1.3), Std.int(FlxG.height * 1.3), 0xFFB3DFd8);
		bgFade.scrollFactor.set();
		bgFade.alpha = 0;
		add(bgFade);

		new FlxTimer().start(0.83, function(tmr:FlxTimer)
		{
			bgFade.alpha += (1 / 5) * 0.7;
			if (bgFade.alpha > 0.7)
				bgFade.alpha = 0.7;
		}, 5);

		box = new FlxSprite(-20, 45);
		
		var hasDialog = false;
		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-pixel');
				box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false);
				box.animation.addByIndices('normal', 'Text Box Appear', [4], "", 24);
			case 'roses':
				hasDialog = true;
				FlxG.sound.play(Paths.sound('ANGRY_TEXT_BOX'));

				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-senpaiMad');
				box.animation.addByPrefix('normalOpen', 'SENPAI ANGRY IMPACT SPEECH', 24, false);
				box.animation.addByIndices('normal', 'SENPAI ANGRY IMPACT SPEECH', [4], "", 24);

			case 'thorns':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-evil');
				box.animation.addByPrefix('normalOpen', 'Spirit Textbox spawn', 24, false);
				box.animation.addByIndices('normal', 'Spirit Textbox spawn', [11], "", 24);

				var face:FlxSprite = new FlxSprite(320, 170).loadGraphic(Paths.image('weeb/spiritFaceForward'));
				face.setGraphicSize(Std.int(face.width * 6));
				add(face);

			case 'wow':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking', 'shared');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByIndices('normal', 'speech bubble normal', [11], "", 24);
				box.width = 200;
				box.height = 200;
				box.x = -100;
				box.y = 375;

				var face:FlxSprite = new FlxSprite(320, 170).loadGraphic(Paths.image('weeb/spiritFaceForward'));
				face.setGraphicSize(Std.int(face.width * 6));
				add(face);

			case 'hoodie':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking', 'shared');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByIndices('normal', 'speech bubble normal', [11], "", 24);
				box.width = 200;
				box.height = 200;
				box.x = -100;
				box.y = 375;

				var face:FlxSprite = new FlxSprite(320, 170).loadGraphic(Paths.image('weeb/spiritFaceForward'));
				face.setGraphicSize(Std.int(face.width * 6));
				add(face);

			case 'quake':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking', 'shared');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByIndices('normal', 'speech bubble normal', [11], "", 24);
				box.width = 200;
				box.height = 200;
				box.x = -100;
				box.y = 375;

				var face:FlxSprite = new FlxSprite(320, 170).loadGraphic(Paths.image('weeb/spiritFaceForward'));
				face.setGraphicSize(Std.int(face.width * 6));
				add(face);

			case 'demise':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking', 'shared');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByIndices('normal', 'speech bubble normal', [11], "", 24);
				box.width = 200;
				box.height = 200;
				box.x = -100;
				box.y = 375;

				var face:FlxSprite = new FlxSprite(320, 170).loadGraphic(Paths.image('weeb/spiritFaceForward'));
				face.setGraphicSize(Std.int(face.width * 6));
				add(face);
		}

		this.dialogueList = dialogueList;
		
		if (!hasDialog)
			return;
		
		if(PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'roses' || PlayState.SONG.song.toLowerCase() == 'thorns')
		{	
		portraitLeft = new FlxSprite(-20, 40);
		portraitLeft.frames = Paths.getSparrowAtlas('weeb/senpaiPortrait');
		portraitLeft.animation.addByPrefix('enter', 'Senpai Portrait Enter', 24, false);
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
		portraitLeft.updateHitbox();
		portraitLeft.scrollFactor.set();
		add(portraitLeft);
		portraitLeft.visible = false;

		portraitRight = new FlxSprite(0, 40);
		portraitRight.frames = Paths.getSparrowAtlas('weeb/bfPortrait');
		portraitRight.animation.addByPrefix('enter', 'Boyfriend portrait enter', 24, false);
		portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.9));
		portraitRight.updateHitbox();
		portraitRight.scrollFactor.set();
		add(portraitRight);
		portraitRight.visible = false;
		
		box.animation.play('normalOpen');
		box.setGraphicSize(Std.int(box.width * PlayState.daPixelZoom * 0.9));
		box.updateHitbox();
		add(box);

		box.screenCenter(X);
		portraitLeft.screenCenter(X);

		handSelect = new FlxSprite(FlxG.width * 0.9, FlxG.height * 0.9).loadGraphic(Paths.image('weeb/pixelUI/hand_textbox'));
		add(handSelect);
		}
		else if (PlayState.SONG.song.toLowerCase() == 'wow' || PlayState.SONG.song.toLowerCase() == 'hoodie')
		{
		portraitLeft = new FlxSprite(50, 40);
		portraitLeft.frames = Paths.getSparrowAtlas('portraits/dialogue_sly', 'shared');
		portraitLeft.animation.addByPrefix('enter', 'dialogue_sky_A', 24, false);
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.15));
		portraitLeft.updateHitbox();
		portraitLeft.scrollFactor.set();
		add(portraitLeft);
		portraitLeft.visible = false;

		portraitLeftB = new FlxSprite(50, 40);
		portraitLeftB.frames = Paths.getSparrowAtlas('portraits/dialogue_sly', 'shared');
		portraitLeftB.animation.addByPrefix('enter', 'dialogue_sky_B', 24, false);
		portraitLeftB.setGraphicSize(Std.int(portraitLeftB.width * PlayState.daPixelZoom * 0.15));
		portraitLeftB.updateHitbox();
		portraitLeftB.scrollFactor.set();
		add(portraitLeftB);
		portraitLeftB.visible = false;

		portraitLeftC = new FlxSprite(50, 40);
		portraitLeftC.frames = Paths.getSparrowAtlas('portraits/dialogue_sly', 'shared');
		portraitLeftC.animation.addByPrefix('enter', 'dialogue_sky_C', 24, false);
		portraitLeftC.setGraphicSize(Std.int(portraitLeftC.width * PlayState.daPixelZoom * 0.15));
		portraitLeftC.updateHitbox();
		portraitLeftC.scrollFactor.set();
		add(portraitLeftC);
		portraitLeftC.visible = false;

		portraitRight = new FlxSprite(700, 200);
		portraitRight.frames = Paths.getSparrowAtlas('portraits/BF_Dialogue', 'shared');
		portraitRight.animation.addByPrefix('enter', 'BF_Dialogue_A', 24, false);
		portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.15));
		portraitRight.updateHitbox();
		portraitRight.scrollFactor.set();
		add(portraitRight);
		portraitRight.visible = false;
		
		box.animation.play('normalOpen');
		box.setGraphicSize(Std.int(box.width * PlayState.daPixelZoom * 0.9));
		box.updateHitbox();
		add(box);

		box.screenCenter(X);

		handSelect = new FlxSprite(FlxG.width * 0.9, FlxG.height * 0.9).loadGraphic(Paths.image('weeb/pixelUI/hand_textbox'));
		add(handSelect);
		}
		else if (PlayState.SONG.song.toLowerCase() == 'quake' || PlayState.SONG.song.toLowerCase() == 'demise')
		{
		portraitLeft = new FlxSprite(50, 40);
		portraitLeft.frames = Paths.getSparrowAtlas('portraits/dialogue_angrysly', 'shared');
		portraitLeft.animation.addByPrefix('enter', 'dialogue_skyangry_A', 24, false);
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.15));
		portraitLeft.updateHitbox();
		portraitLeft.scrollFactor.set();
		add(portraitLeft);
		portraitLeft.visible = false;

		portraitLeftB = new FlxSprite(50, 40);
		portraitLeftB.frames = Paths.getSparrowAtlas('portraits/dialogue_angrysly', 'shared');
		portraitLeftB.animation.addByPrefix('enter', 'dialogue_skyangry_B', 24, false);
		portraitLeftB.setGraphicSize(Std.int(portraitLeftB.width * PlayState.daPixelZoom * 0.15));
		portraitLeftB.updateHitbox();
		portraitLeftB.scrollFactor.set();
		add(portraitLeftB);
		portraitLeftB.visible = false;

		portraitLeftC = new FlxSprite(50, 38);
		portraitLeftC.frames = Paths.getSparrowAtlas('portraits/dialogue_angrysly', 'shared');
		portraitLeftC.animation.addByPrefix('enter', 'dialogue_skyangry_C', 24, false);
		portraitLeftC.setGraphicSize(Std.int(portraitLeftC.width * PlayState.daPixelZoom * 0.15));
		portraitLeftC.updateHitbox();
		portraitLeftC.scrollFactor.set();
		add(portraitLeftC);
		portraitLeftC.visible = false;

		portraitRight = new FlxSprite(700, 200);
		portraitRight.frames = Paths.getSparrowAtlas('portraits/BF_Dialogue', 'shared');
		portraitRight.animation.addByPrefix('enter', 'BF_Dialogue_A', 24, false);
		portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.15));
		portraitRight.updateHitbox();
		portraitRight.scrollFactor.set();
		add(portraitRight);
		portraitRight.visible = false;
		
		box.animation.play('normalOpen');
		box.setGraphicSize(Std.int(box.width * PlayState.daPixelZoom * 0.9));
		box.updateHitbox();
		add(box);

		box.screenCenter(X);

		handSelect = new FlxSprite(FlxG.width * 0.9, FlxG.height * 0.9).loadGraphic(Paths.image('weeb/pixelUI/hand_textbox'));
		add(handSelect);
		}


		if (!talkingRight)
		{
			// box.flipX = true;
		}

		dropText = new FlxText(242, 502, Std.int(FlxG.width * 0.6), "", 40);
		dropText.font = 'Bubblegum Sans';
		dropText.color = 0x000000;
		add(dropText);

		swagDialogue = new FlxTypeText(240, 500, Std.int(FlxG.width * 0.6), "", 40);
		swagDialogue.font = 'Bubblegum Sans';
		swagDialogue.color = 0xffffff;
		swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
		add(swagDialogue);

		dialogue = new Alphabet(0, 80, "", false, true);
		// dialogue.x = 90;
		// add(dialogue);
	}

	var dialogueOpened:Bool = false;
	var dialogueStarted:Bool = false;

	override function update(elapsed:Float)
	{
		// HARD CODING CUZ IM STUPDI
		if (PlayState.SONG.song.toLowerCase() == 'roses')
			portraitLeft.visible = false;
		if (PlayState.SONG.song.toLowerCase() == 'thorns')
		{
			portraitLeft.color = FlxColor.BLACK;
			swagDialogue.color = FlxColor.WHITE;
			dropText.color = FlxColor.BLACK;
		}

		dropText.text = swagDialogue.text;

		if (box.animation.curAnim != null)
		{
			if (box.animation.curAnim.name == 'normalOpen' && box.animation.curAnim.finished)
			{
				box.animation.play('normal');
				dialogueOpened = true;
			}
		}

		if (dialogueOpened && !dialogueStarted)
		{
			startDialogue();
			dialogueStarted = true;
		}

		if (FlxG.keys.justPressed.ANY  && dialogueStarted == true)
		{
			remove(dialogue);
				
			FlxG.sound.play(Paths.sound('clickText'), 0.8);

			if (dialogueList[1] == null && dialogueList[0] != null)
			{
				if (!isEnding)
				{
					isEnding = true;

					if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'thorns' || PlayState.SONG.song.toLowerCase() == 'wow' || PlayState.SONG.song.toLowerCase() == 'hoodie' || PlayState.SONG.song.toLowerCase() == 'quake' || PlayState.SONG.song.toLowerCase() == 'demise')
						FlxG.sound.music.fadeOut(2.2, 0);

					new FlxTimer().start(0.2, function(tmr:FlxTimer)
					{
						box.alpha -= 1 / 5;
						bgFade.alpha -= 1 / 5 * 0.7;
						portraitLeft.visible = false;
						portraitLeftB.visible = false;
						portraitLeftC.visible = false;
						portraitRight.visible = false;
						swagDialogue.alpha -= 1 / 5;
						dropText.alpha = swagDialogue.alpha;
					}, 5);

					new FlxTimer().start(1.2, function(tmr:FlxTimer)
					{
						finishThing();
						kill();
					});
				}
			}
			else
			{
				dialogueList.remove(dialogueList[0]);
				startDialogue();
			}
		}
		
		super.update(elapsed);
	}

	var isEnding:Bool = false;

	function startDialogue():Void
	{
		cleanDialog();
		// var theDialog:Alphabet = new Alphabet(0, 70, dialogueList[0], false, true);
		// dialogue = theDialog;
		// add(theDialog);

		// swagDialogue.text = ;
		swagDialogue.resetText(dialogueList[0]);
		swagDialogue.start(0.04, true);

		switch (curCharacter)
		{
			case 'dad':
				portraitRight.visible = false;
				portraitLeftB.visible = false;
				portraitLeftC.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}

			case 'dadB':
				portraitRight.visible = false;
				portraitLeft.visible = false;
				portraitLeftC.visible = false;
				if (!portraitLeftB.visible)
				{
					portraitLeftB.visible = true;
					portraitLeftB.animation.play('enter');
				}

			case 'dadC':
				portraitRight.visible = false;
				portraitLeft.visible = false;
				portraitLeftB.visible = false;
				if (!portraitLeftC.visible)
				{
					portraitLeftC.visible = true;
					portraitLeftC.animation.play('enter');
				}

			case 'bf':
				portraitLeft.visible = false;
				portraitLeftB.visible = false;
				portraitLeftC.visible = false;
				if (!portraitRight.visible)
				{
					portraitRight.visible = true;
					portraitRight.animation.play('enter');
				}
		}
	}

	function cleanDialog():Void
	{
		var splitName:Array<String> = dialogueList[0].split(":");
		curCharacter = splitName[1];
		dialogueList[0] = dialogueList[0].substr(splitName[1].length + 2).trim();
	}
}
