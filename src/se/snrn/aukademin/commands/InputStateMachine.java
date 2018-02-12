package se.snrn.aukademin.commands;

public class InputStateMachine {

    private CommandState currentCommandState;

    public InputStateMachine() {
       // currentCommandState = new LoginCommand();
        currentCommandState = new MainMenu();
        currentCommandState.enter();
    }

    public void handleInput(String input) {
        if (input.toLowerCase().equals("exit")) {
            currentCommandState = new Exit(currentCommandState instanceof LoginCommand);
            currentCommandState.enter();
            return;
        }

        CommandState newCommandState = currentCommandState.handleInput2(input);

        if (newCommandState != null) {
            newCommandState.enter();
            currentCommandState = newCommandState;
        }
    }
}

