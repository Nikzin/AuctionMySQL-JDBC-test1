package se.snrn.aukademin.commands;

import se.snrn.aukademin.DatabaseConnection;
import se.snrn.aukademin.MultiLineInput;

public class ConfirmAddAuktion implements CommandState {
    private MultiLineInput mli;

    String newAuktion;
    String columns;

    public ConfirmAddAuktion(MultiLineInput mli) {
        this.mli = mli;
        this.newAuktion = "";
        this.columns = "";
    }

    @Override
    public void enter() {
        for (int i = 0; i < mli.getNumberOfQuestions(); i++) {
            columns += String.format("%1$-20s", mli.getQuestion(i) + " ");
        }

        for (int i = 0; i < mli.getNumberOfQuestions(); i++) {
            newAuktion += String.format("%1$-20s", mli.getAnswer(i) + " ");
        }

        System.out.println(columns);
        System.out.println(newAuktion);

        System.out.println("Do you want to add this auction? (yes/no)");

    }

    @Override
    public CommandState handleInput2(String input) {
        switch (input) {
            case "yes": {
                System.out.println("Auction is added");
                DatabaseConnection.insertAuction(mli);
                return new MainMenu();
            }
            case "no": {
                System.out.println("Auction is cancelled");
                return new MainMenu();
            }
        }
        return null;
    }
}
