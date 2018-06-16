package scripts;

import com.stencyl.graphics.G;
import com.stencyl.graphics.BitmapWrapper;

import com.stencyl.behavior.Script;
import com.stencyl.behavior.Script.*;
import com.stencyl.behavior.ActorScript;
import com.stencyl.behavior.SceneScript;
import com.stencyl.behavior.TimedTask;

import com.stencyl.models.Actor;
import com.stencyl.models.GameModel;
import com.stencyl.models.actor.Animation;
import com.stencyl.models.actor.ActorType;
import com.stencyl.models.actor.Collision;
import com.stencyl.models.actor.Group;
import com.stencyl.models.Scene;
import com.stencyl.models.Sound;
import com.stencyl.models.Region;
import com.stencyl.models.Font;
import com.stencyl.models.Joystick;

import com.stencyl.Engine;
import com.stencyl.Input;
import com.stencyl.Key;
import com.stencyl.utils.Utils;

import openfl.ui.Mouse;
import openfl.display.Graphics;
import openfl.display.BlendMode;
import openfl.display.BitmapData;
import openfl.display.Bitmap;
import openfl.events.Event;
import openfl.events.KeyboardEvent;
import openfl.events.TouchEvent;
import openfl.net.URLLoader;

import box2D.common.math.B2Vec2;
import box2D.dynamics.B2Body;
import box2D.dynamics.B2Fixture;
import box2D.dynamics.joints.B2Joint;

import motion.Actuate;
import motion.easing.Back;
import motion.easing.Cubic;
import motion.easing.Elastic;
import motion.easing.Expo;
import motion.easing.Linear;
import motion.easing.Quad;
import motion.easing.Quart;
import motion.easing.Quint;
import motion.easing.Sine;

import com.stencyl.graphics.shaders.BasicShader;
import com.stencyl.graphics.shaders.GrayscaleShader;
import com.stencyl.graphics.shaders.SepiaShader;
import com.stencyl.graphics.shaders.InvertShader;
import com.stencyl.graphics.shaders.GrainShader;
import com.stencyl.graphics.shaders.ExternalShader;
import com.stencyl.graphics.shaders.InlineShader;
import com.stencyl.graphics.shaders.BlurShader;
import com.stencyl.graphics.shaders.SharpenShader;
import com.stencyl.graphics.shaders.ScanlineShader;
import com.stencyl.graphics.shaders.CSBShader;
import com.stencyl.graphics.shaders.HueShader;
import com.stencyl.graphics.shaders.TintShader;
import com.stencyl.graphics.shaders.BloomShader;



class Design_25_25_Label extends ActorScript
{
	public var _HideSprite:Bool;
	public var _Font:Font;
	public var _LineWidth:Float;
	public var _LineHeight:Float;
	public var _Text:String;
	public var _WrappedLines:Array<Dynamic>;
	public var _WrapLongLines:Bool;
	public var _CurrentLine:Float;
	public var _Update:Bool;
	public var _MouseOver:Bool;
	public var _X:Float;
	public var _AnchortoScreen:Bool;
	public var _HorizontalAlignment:String;
	public var _LabelWidth:Float;
	public var _TextWidth:Float;
	public var _VerticalAlignment:String;
	public var _LabelHeight:Float;
	public var _Y:Float;
	public var _TextHeight:Float;
	public var _Lines:Array<Dynamic>;
	public var _Line:String;
	public var _UseNewlineCharacters:Bool;
	public var _Visible:Bool;
	
	/* ========================= Custom Block ========================= */
	public function _customBlock_SetLabelText(__text:String):Void
	{
		var __Self:Actor = actor;
		_Text = __text;
		propertyChanged("_Text", _Text);
		_Update = true;
		propertyChanged("_Update", _Update);
	}
	
	/* ========================= Custom Block ========================= */
	public function _customBlock_SetLabelFont(__font:Font):Void
	{
		var __Self:Actor = actor;
		_Font = __font;
		propertyChanged("_Font", _Font);
		_Update = true;
		propertyChanged("_Update", _Update);
	}
	
	/* ========================= Custom Block ========================= */
	public function _customBlock_SetLabelAlignmentLeft():Void
	{
		var __Self:Actor = actor;
		_HorizontalAlignment = "Left";
		propertyChanged("_HorizontalAlignment", _HorizontalAlignment);
	}
	
	/* ========================= Custom Block ========================= */
	public function _customBlock_SetLabelAlignmentCenter():Void
	{
		var __Self:Actor = actor;
		_HorizontalAlignment = "Center";
		propertyChanged("_HorizontalAlignment", _HorizontalAlignment);
	}
	
	/* ========================= Custom Block ========================= */
	public function _customBlock_SetLabelAlignmentRight():Void
	{
		var __Self:Actor = actor;
		_HorizontalAlignment = "Right";
		propertyChanged("_HorizontalAlignment", _HorizontalAlignment);
	}
	
	/* ========================= Custom Block ========================= */
	public function _customBlock_SetLabelAlignmentTop():Void
	{
		var __Self:Actor = actor;
		_VerticalAlignment = "Top";
		propertyChanged("_VerticalAlignment", _VerticalAlignment);
	}
	
	/* ========================= Custom Block ========================= */
	public function _customBlock_SetLabelAlignmentMiddle():Void
	{
		var __Self:Actor = actor;
		_VerticalAlignment = "Middle";
		propertyChanged("_VerticalAlignment", _VerticalAlignment);
	}
	
	/* ========================= Custom Block ========================= */
	public function _customBlock_SetLabelAlignmentBottom():Void
	{
		var __Self:Actor = actor;
		_VerticalAlignment = "Bottom";
		propertyChanged("_VerticalAlignment", _VerticalAlignment);
	}
	
	/* ========================= Custom Block ========================= */
	public function _customBlock_SetLabelWidth(__width:Float):Void
	{
		var __Self:Actor = actor;
		_LabelWidth = asNumber(__width);
		propertyChanged("_LabelWidth", _LabelWidth);
		_Update = true;
		propertyChanged("_Update", _Update);
	}
	
	/* ========================= Custom Block ========================= */
	public function _customBlock_SetLabelHeight(__height:Float):Void
	{
		var __Self:Actor = actor;
		_LabelHeight = asNumber(__height);
		propertyChanged("_LabelHeight", _LabelHeight);
		_Update = true;
		propertyChanged("_Update", _Update);
	}
	
	/* ========================= Custom Block ========================= */
	public function _customBlock_HideLabel():Void
	{
		var __Self:Actor = actor;
		_Visible = false;
		propertyChanged("_Visible", _Visible);
	}
	
	/* ========================= Custom Block ========================= */
	public function _customBlock_ShowLabel():Void
	{
		var __Self:Actor = actor;
		_Visible = true;
		propertyChanged("_Visible", _Visible);
	}
	
	/* ========================= Custom Block ========================= */
	public function _customBlock_MouseOverText():Bool
	{
		var __Self:Actor = actor;
		return _MouseOver;
	}
	
	/* ========================= Custom Block ========================= */
	public function _customBlock_MouseOverLabel():Bool
	{
		var __Self:Actor = actor;
		return (((getMouseX() >= actor.getScreenX()) && (getMouseX() < (actor.getScreenX() + _LabelWidth))) && ((getMouseY() >= actor.getScreenY()) && (getMouseY() < (actor.getScreenY() + _LabelHeight))));
	}
	
	
	public function new(dummy:Int, actor:Actor, dummy2:Engine)
	{
		super(actor);
		nameMap.set("Hide Sprite", "_HideSprite");
		_HideSprite = true;
		nameMap.set("Actor", "actor");
		nameMap.set("Font", "_Font");
		nameMap.set("Line Width", "_LineWidth");
		_LineWidth = 0.0;
		nameMap.set("Line Height", "_LineHeight");
		_LineHeight = 0.0;
		nameMap.set("Text", "_Text");
		_Text = "Replace Me";
		nameMap.set("Wrapped Lines", "_WrappedLines");
		nameMap.set("Wrap Long Lines", "_WrapLongLines");
		_WrapLongLines = true;
		nameMap.set("Current Line", "_CurrentLine");
		_CurrentLine = 0.0;
		nameMap.set("Update", "_Update");
		_Update = false;
		nameMap.set("Mouse Over", "_MouseOver");
		_MouseOver = false;
		nameMap.set("X", "_X");
		_X = 0.0;
		nameMap.set("Anchor to Screen", "_AnchortoScreen");
		_AnchortoScreen = true;
		nameMap.set("Horizontal Alignment", "_HorizontalAlignment");
		_HorizontalAlignment = "";
		nameMap.set("Label Width", "_LabelWidth");
		_LabelWidth = 128.0;
		nameMap.set("Text Width", "_TextWidth");
		_TextWidth = 0.0;
		nameMap.set("Vertical Alignment", "_VerticalAlignment");
		_VerticalAlignment = "";
		nameMap.set("Label Height", "_LabelHeight");
		_LabelHeight = 32.0;
		nameMap.set("Y", "_Y");
		_Y = 0.0;
		nameMap.set("Text Height", "_TextHeight");
		_TextHeight = 0.0;
		nameMap.set("Lines", "_Lines");
		nameMap.set("Line", "_Line");
		_Line = "";
		nameMap.set("Use Newline Characters", "_UseNewlineCharacters");
		_UseNewlineCharacters = true;
		nameMap.set("Visible", "_Visible");
		_Visible = false;
		
	}
	
	override public function init()
	{
		
		/* ======================== When Creating ========================= */
		if(_AnchortoScreen)
		{
			actor.anchorToScreen();
		}
		if(_HideSprite)
		{
			actor.disableActorDrawing();
		}
		_Visible = true;
		propertyChanged("_Visible", _Visible);
		_Update = true;
		propertyChanged("_Update", _Update);
		
		/* ========================= When Drawing ========================= */
		addWhenDrawingListener(null, function(g:G, x:Float, y:Float, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				if(_Visible)
				{
					g.setFont(_Font);
					if(_Update)
					{
						_Update = false;
						propertyChanged("_Update", _Update);
						if(_UseNewlineCharacters)
						{
							_Lines = ("" + _Text).split("\\n");
							propertyChanged("_Lines", _Lines);
						}
						else
						{
							_Lines = new Array<Dynamic>();
							propertyChanged("_Lines", _Lines);
							_Lines.push(_Text);
						}
						if(_WrapLongLines)
						{
							_WrappedLines = new Array<Dynamic>();
							propertyChanged("_WrappedLines", _WrappedLines);
							for(index0 in 0...Std.int(_Lines.length))
							{
								_WrappedLines.push("");
								_CurrentLine = asNumber((_WrappedLines.length - 1));
								propertyChanged("_CurrentLine", _CurrentLine);
								for(item in cast(("" + _Lines[Std.int(index0)]).split(" "), Array<Dynamic>))
								{
									if((_WrappedLines[Std.int(_CurrentLine)] == ""))
									{
										_WrappedLines[Std.int(_CurrentLine)] = item;
									}
									else if((g.font.font.getTextWidth((("" + _WrappedLines[Std.int(_CurrentLine)]) + ("" + (("" + " ") + ("" + item)))))/Engine.SCALE <= _LabelWidth))
									{
										_WrappedLines[Std.int(_CurrentLine)] = (("" + _WrappedLines[Std.int(_CurrentLine)]) + ("" + (("" + " ") + ("" + item))));
									}
									else
									{
										_WrappedLines.push(item);
										_CurrentLine = asNumber((_CurrentLine + 1));
										propertyChanged("_CurrentLine", _CurrentLine);
									}
								}
							}
							_Lines = _WrappedLines;
							propertyChanged("_Lines", _Lines);
						}
					}
					_TextHeight = asNumber((_Lines.length * g.font.getHeight()/Engine.SCALE));
					propertyChanged("_TextHeight", _TextHeight);
					_TextWidth = asNumber(0);
					propertyChanged("_TextWidth", _TextWidth);
					_MouseOver = false;
					propertyChanged("_MouseOver", _MouseOver);
					for(index0 in 0...Std.int(_Lines.length))
					{
						_Line = _Lines[Std.int(index0)];
						propertyChanged("_Line", _Line);
						_LineWidth = asNumber(g.font.font.getTextWidth(_Line)/Engine.SCALE);
						propertyChanged("_LineWidth", _LineWidth);
						_LineHeight = asNumber(g.font.getHeight()/Engine.SCALE);
						propertyChanged("_LineHeight", _LineHeight);
						if((_LineWidth > _TextWidth))
						{
							_TextWidth = asNumber(_LineWidth);
							propertyChanged("_TextWidth", _TextWidth);
						}
						if((_HorizontalAlignment == "Left"))
						{
							_X = asNumber(0);
							propertyChanged("_X", _X);
						}
						else if((_HorizontalAlignment == "Center"))
						{
							_X = asNumber(((_LabelWidth - _LineWidth) / 2));
							propertyChanged("_X", _X);
						}
						else if((_HorizontalAlignment == "Right"))
						{
							_X = asNumber((_LabelWidth - _LineWidth));
							propertyChanged("_X", _X);
						}
						if((_VerticalAlignment == "Top"))
						{
							_Y = asNumber(0);
							propertyChanged("_Y", _Y);
						}
						else if((_VerticalAlignment == "Middle"))
						{
							_Y = asNumber(((_LabelHeight - _TextHeight) / 2));
							propertyChanged("_Y", _Y);
						}
						else if((_VerticalAlignment == "Bottom"))
						{
							_Y = asNumber((_LabelHeight - _TextHeight));
							propertyChanged("_Y", _Y);
						}
						_Y = asNumber((_Y + (_LineHeight * index0)));
						propertyChanged("_Y", _Y);
						g.drawString("" + _Line, _X, _Y);
						if((((getMouseX() >= (actor.getScreenX() + _X)) && (getMouseX() < (actor.getScreenX() + (_X + _LineWidth)))) && ((getMouseY() >= (actor.getScreenY() + _Y)) && (getMouseY() < (actor.getScreenY() + (_Y + _LineHeight))))))
						{
							_MouseOver = true;
							propertyChanged("_MouseOver", _MouseOver);
						}
						if((sceneHasBehavior("Game Debugger") && asBoolean(getValueForScene("Game Debugger", "_Enabled"))))
						{
							g.strokeSize = Std.int(1);
							g.drawRect(_X, _Y, _LineWidth, _LineHeight);
						}
					}
					if((sceneHasBehavior("Game Debugger") && asBoolean(getValueForScene("Game Debugger", "_Enabled"))))
					{
						g.strokeColor = getValueForScene("Game Debugger", "_CustomColor");
						g.strokeSize = Std.int(getValueForScene("Game Debugger", "_StrokeThickness"));
						g.moveTo(0, 0);
						g.drawRect(0, 0, _LabelWidth, _LabelHeight);
					}
				}
			}
		});
		
	}
	
	override public function forwardMessage(msg:String)
	{
		
	}
}