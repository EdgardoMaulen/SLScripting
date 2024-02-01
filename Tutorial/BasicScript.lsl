default
{

    touch_start(integer num_detected)
    {
        string toucherName = llGetDisplayName(llDetectedKey(0));
        if(toucherName == "Aeithe Thornbane")
        {
            llSay(0, "Hello " + toucherName);
            
        }
        else
        {
            llSay(0, "Sorry, " + toucherName + ", this nose is private use only")
            
        }
    }
}