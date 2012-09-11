package
{
	public class Toolbox
	{
		
		//Unused currently, but damn, it's just so nice...
		protected function string2Array(mapDef:String):Array
		{
			var tmpArr:Array = new Array();
			var widthInTiles:int = 0;
			var heightInTiles:int = 0;
			var c:uint;
			var r:uint;
			var cols:Array;
			var rows:Array = mapDef.split("\n");
			heightInTiles = rows.length;
			for (r = 0; r < heightInTiles; r++)
			{
				cols = rows[r].split(",");
				if(cols.length <= 1)
				{
					heightInTiles--;
					continue;
				}
				tmpArr.push(new Array());
				if(widthInTiles == 0)
					widthInTiles = cols.length;
				for(c = 0; c < widthInTiles; c++)
				{
					tmpArr[r].push(uint(cols[c]));
				}
			}
			return tmpArr;	
		}

	}
}