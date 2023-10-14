public function exactSetGraphicSize(obj:Dynamic, width:Float, height:Float)
	obj.scale.set(Math.abs(((obj.width - width) / obj.width) - 1), Math.abs(((obj.height - height) / obj.height) - 1));