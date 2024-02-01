default //default state is mandatory
{
    state_entry() // runs each time the state is entered
    {
        llSay(0, "turning on!"); //object speaks!
        llSetColor(<1.0, 1.0, 1.0>, ALL_SIDES); // sets no tint (white)
        // note the semicolons at the end of each instruction
        // (do not put them at the end of "if" statements)
    }

    // Note: for technical reasons discussed elsewhere, we use a touch_end event rather than touch_start when state changes are involved
    touch_end(integer total_number) // another event with only one function inside
    {
        state off; // sets the script to a new "state" and starts running "state off"
    }
} // this curly bracket ends the body of the default state.

state off // a second state besides "default"
{
    state_entry() // this is run as soon as the state is entered
    {
        llSay(0, "turning off!");
        llSetColor(<0.0, 0.0, 0.0>, ALL_SIDES); // sets black tint
    }

    touch_end(integer total_number)
    {
        state default;
    }
}