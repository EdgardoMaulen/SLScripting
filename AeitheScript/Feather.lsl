key OwnerId;
key RegisteredOwner;

spawn_particles()
{
    llSay(0, "POOF! MAGIC!");
}

default
{

    changed(integer change)
    {
        //resets the registered owner of the item
        if (change & CHANGED_OWNER)
            llResetScript();
    }

    touch_start(integer toucher)
    {
        /*check for owner
        if feather owner and toucher are the same then call particles
        if feather owner and toucher are not the same check for group
        */
        OwnerId = llDetectedKey(toucher); //gets current owner key
        RegisteredOwner = llGetOwner() //gets key of object's registered owner
        
        if(OwnerId == RegisteredOwner)
        {
            spawn_particles();
        }
        else
        {
            list toucherDetails = llGetObjectDetails(OwnerId, [OBJECT_GROUP]);
            key toucherGroup = llList2Key(objectDetails, 0)     

            if((string)toucherGroup == "9b0f0aa1-5f11-5c88-8c34-dbaadbf9f171")
            {
                spawn_particles();
            }
            else
            {
                llSay(0, "nope. Not right");
            }
        }
    }
    
    
    /*check for group
        if toucher and feather belong to same group then call particles
        if toucher and feather do not belong to the same group then return.
    */
    
    //TODO
    //SpawnParticles()
 

}