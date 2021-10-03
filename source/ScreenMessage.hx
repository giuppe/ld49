package;

import flixel.text.FlxText;

class ScreenMessage extends FlxText
{
    public var centered:Bool = true;

    public function new()
    {
        super();
        this.visible = false;
    }

    public function showMessage(message:String)
    {
        this.text = message;
        if(centered)
        {
            this.x = (480 - this.width)/2;
        }
        this.visible = true;
    }

    public function hideMessage()
    {
        this.visible = false;
    }
}