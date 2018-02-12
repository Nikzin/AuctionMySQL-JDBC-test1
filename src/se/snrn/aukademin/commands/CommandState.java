package se.snrn.aukademin.commands;

public interface CommandState {

    void enter();

    CommandState handleInput2(String input);



}
