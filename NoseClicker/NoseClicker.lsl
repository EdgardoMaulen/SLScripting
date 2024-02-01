                   // menu item, RP text, UUID of sound to play - leave blank if none
list touchEvents = ["Boop", "[toucher] boops [owner][s] nose!", "584185f7-554c-3441-af1f-1ab637085d73",
                    "Blep", "[toucher] touches [owner][s] li'l nose, making it blep?!", "fa12f284-be65-7748-dcd7-533a6333d24a",
                    "Bite", "[toucher] bites [owner][s] poor nose! D:", "",
                    "Slurp", "[toucher] slurps along [owner][s] face wetly, making them blush!", "9c888232-5047-8ffe-2da8-7e9ccf8d2785",
                    "Kiss", "[toucher] kisses [owner] gently on the lips.", "8fb6fd22-19a3-4fb6-c694-0c006c2afaa2",
                    "Deep Kiss", "[toucher] reaches over and kisses [owner] deeply, holding it for a few moments.", "",
                    "Tease", "[toucher] teases [owner] by running their tail gently under his chin!", "",
                    "Pam!", "[owner] says Pam! :D", "7d020abb-eddf-080e-81f7-d165b8133d59",
                    "MINE", "[toucher] hugs [owner][s] head and holds it to their chest...", "",
                    "Fluff", "[toucher] hugs [owner][s] fluffy head close to them. Carressingly rubbing it gently against themselves.", "",

                    "French", "[toucher] kisses [owner][s] deeply, pushing their tongue in and exploring!", "",
                    "Slap", "[toucher] slaps [owner] upside the head for being silly.", "a0e3518b-bd8c-2407-122d-2739ed3b93b4",
                    "Smack", "[toucher] Gib smacks [owner][s] head.", "",
                    "Brush", "[toucher] brushes [owner][s] face gently, making it all fluffy and cute.", "",

                    "Nuzzle", "[toucher] nuzzles [owner] affectionately.", "",
                    "Hump", "[toucher] starts to hump [owner][s] face rapidly!", "",
                    "Squeeze Cheeks", "[toucher] squeezes [owner][s] adorable cheeks!", "",
                    "Rub Face", "[toucher] rubs [owner][s] face all over.", "",
                    "Lick Mouth", "[toucher] licks [owner] around their mouth.", "",
                    "Kisshead", "[toucher] kisses [owner] on their head.", "",
                    "Peck Lips", "[toucher] pecks [owner] gently on the lips.", "",
                    "Mouthplay", "[toucher] gently open [owner][s] mouth, carring the lips, teeth, gums and tongue.", "",
                    "Silly Tongue Kiss", "[toucher] grabs [owner][s] face, forcefully opens it and snatch the tongue out, makes it stretched out. [toucher] stuff the tongue in their mouth.", ""
                    ];
integer comChannel;
integer aListen;
if (llGetOwner() == llDetectedKey(0)){
string phrase( string s, key id ) {
  string t = llGetDisplayName(id) ;
  string o = llGetDisplayName( llGetOwner() ) ;
  list iList = llParseString2List(s, [ " " ], []) ;
  integer i ;
  integer j ;
    for (i = 0; i < llGetListLength(iList) ; ++i ) {
        if ( -1 !=  llSubStringIndex(llList2String(iList,i), "[toucher]") ) {
          j = llSubStringIndex(llList2String(iList,i), "[toucher]") ;
            iList = llListReplaceList(iList,[llInsertString(llDeleteSubString(llList2String(iList,i), j, j + 8), j, t )],i,i );
        }
        if ( -1 !=  llSubStringIndex(llList2String(iList,i), "[owner]") ) {
          j = llSubStringIndex(llList2String(iList,i), "[owner]") ;
            iList = llListReplaceList(iList,[llInsertString(llDeleteSubString(llList2String(iList,i), j, j + 6), j, o )],i,i );
        }
        if ( -1 !=  llSubStringIndex(llList2String(iList,i), "[s]") ) {
          j = llSubStringIndex(llList2String(iList,i), "[s]") ;
            if ( llGetSubString(llList2String(iList,i),j - 1 , j - 1) == "s"  ) {
                iList = llListReplaceList(iList,[llInsertString(llDeleteSubString(llList2String(iList,i), j, j + 2), j, "'" )],i,i );
            }
            else {
                iList = llListReplaceList(iList,[llInsertString(llDeleteSubString(llList2String(iList,i), j, j + 2), j, "'s" )],i,i );
            }
        }
    }
    return  llDumpList2String( iList, " " ) ;
}




integer paginationCount = 1;
integer menuPageCount ;
pagination(list pageList, key id) {

pageList = llList2ListStrided(pageList,0,-1,3); //returns ever 3rd item becasue the others are the actionables.


  list paginationNavigation = ["<<","Main",">>"];
  integer pageListLength = llGetListLength(pageList);
    if ( pageListLength > 12 ){
      menuPageCount = llCeil( (float)pageListLength / 9.0 );
        if ( paginationCount == menuPageCount ) {
            pageList = llList2List(pageList, ( ( (menuPageCount - 1) * 9 ) - 1 ) , pageListLength ) ;
            llDialog(id, "Menu", paginationNavigation + llListSort(pageList,1, TRUE ), comChannel);
        }
        else{
            pageList = llList2List(pageList, ( (paginationCount * 9) - 9 ),  ( (paginationCount * 9) - 1 ) ) ;
            llDialog(id, "Menu", paginationNavigation + llListSort(pageList,1,TRUE), comChannel);
        }
    }
    else {
       llDialog(id, "Menu", pageList, comChannel);
    }
}

float blushAmt;
blush() {
    if(blushAmt < 0.7)
    {
        for(blushAmt = 0; blushAmt <= 1; blushAmt+=0.1)
        {
            llSay(88,"blush|"+(string)blushAmt);
            llSleep(0.00125);
        }
    }
    llSetTimerEvent(2);
}



default {
    attach(key n) {
        llResetScript();
    }

    on_rez(integer num) {
        llResetScript();
    }


    state_entry(){
        comChannel = -1 * (integer)llFrand(10000);

    }

    touch_start(integer num) {
        aListen = llListen(comChannel,"", NULL_KEY, "");
        --num;
        key toucherKey = llDetectedKey(num);


        float  posDif = llVecDist( llDetectedPos(num) , llGetPos() );

        if ( posDif <= 10  ) {
            pagination(touchEvents, toucherKey );
        } else {
            llRegionSayTo(toucherKey,0,"Nice try, however you are too far.");
            llOwnerSay("Your face is being touched by "+  llGetDisplayName( toucherKey ) + ", however they are out of range.");
        }


        llResetTime();
    }

    touch( integer num ) {
      --num ;
      key ownerKey = llGetOwner();
        if ( llDetectedKey(num) == ownerKey && llGetTime() > 0.7 ){
            aListen = llListen(comChannel,"", ownerKey, "");
            llDialog(ownerKey, "Menu", [ "Lock" ], comChannel);
        }
    }


    listen(integer channel, string name, key id, string message) {
        integer listIndex = llListFindList(touchEvents , [message]);


        /// PAGINATION ---
        if( message == "Main" ) {
          paginationCount = 1;
          pagination(touchEvents, id);
            // ADD MAIN MENU HERE
            //pagination(inventoryObjects);
        }
        else if ( message == "<<" ) {
            if ( paginationCount >= 2) {
              --paginationCount ;
                pagination(touchEvents, id);
            }
            else{
                pagination(touchEvents, id);
            }
        }
        else if ( message == ">>" ) {

            if ( paginationCount <= ( menuPageCount - 1 ) ) {
               ++paginationCount ;
                 pagination(touchEvents, id);
            }
            else{
                pagination(touchEvents, id);
            }
        }
        // END PAGINATION ---



        else if ( listIndex >= 0  ) {
            string oldName = llGetObjectName();
            llSetObjectName(" ");
            if( llList2String(touchEvents, listIndex) == "MINE" ) {
                llSay(PUBLIC_CHANNEL,"/me " + phrase( llList2String(touchEvents, listIndex + 1), id ) );
                llShout(PUBLIC_CHANNEL, "/me \'They're MINE!\'");
            } else {
                llSay(PUBLIC_CHANNEL,"/me " + phrase( llList2String(touchEvents, listIndex + 1), id ) );
            }


            key soundUUID = llList2Key(touchEvents, listIndex + 2);
            if( soundUUID != "" ) {
                llPlaySound( soundUUID ,.5);
            }
            llSetObjectName(oldName);
            blush();
            paginationCount = 1;
            llListenRemove(aListen);
        }
        else if ( message == "Lock" ) {
            llListenRemove(aListen);
            state Locked;
        }


    }


    timer() 
    {
        llSetTimerEvent(0);
        float blushAmt;
        for(blushAmt = 1; blushAmt >= 0; blushAmt-=0.1)
        {
            llSay(88,"blush|"+(string)blushAmt);
            llSleep(0.025);
        }
    }



}


state Locked {

    state_entry() {

    }
    touch_start(integer num) {
      --num;
      key ownerKey = llGetOwner();
      key toucherKey = llDetectedKey(num);
        if ( toucherKey == ownerKey ) {
            aListen = llListen(comChannel, "", ownerKey, "");
            llDialog(ownerKey, "Menu", ["Unlock"], comChannel);
        }
        else {
            llRegionSayTo(llDetectedKey(num),0,"Locked");
        }
    }
     listen(integer channel, string name, key id, string message) {
        if (message == "Unlock" ){
            llListenRemove(aListen);
            state default;
        }
    }
}
}
else {
    llSay(0, "you are not allowed to click");
}