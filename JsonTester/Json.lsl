default
{
    touch_start(integer total_number)
    {

        /*
            JsonFile
            {
                "control": "controlValue",
                "items": {
                    "itemValue",
                    "anotherItemvalue"
                }
            }
        */

        //1FAIpQLSfQ5DY3SKX8Rg7w3ZO13LSsA4a0H4QmtLc0IrJTunLgjW_m4Q

        string json;
        json = llJsonSetValue(json, ["control"], "controlValue");
        json = llJsonSetValue(json, ["items", JSON_APPEND], "itemValue");
        json = llJsonSetValue(json, ["items", JSON_APPEND], "anotherItemValue");
        // This is the JSON you'd transmit.
        llOwnerSay("This is Json");
        llOwnerSay(json);
        
        // Now let's parse.
        string ctrl = llJsonGetValue(json, ["control"]);
        list items = llJson2List(llJsonGetValue(json, ["items"]));
        llOwnerSay("This is the list");
        llOwnerSay(ctrl);
        llOwnerSay(llDumpList2String(items, ", "));
    }
}