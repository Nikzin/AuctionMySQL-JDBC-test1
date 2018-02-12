package se.snrn.aukademin.commands;

import se.snrn.aukademin.DatabaseConnection;
import se.snrn.aukademin.MultiLineInput;

public class ConfirmAddCustomer implements CommandState {
    private MultiLineInput mli;

    String newSupplier;
    String columns;

    public ConfirmAddCustomer(MultiLineInput mli) {

        this.mli = mli;
        newSupplier = "";
        columns = "";
    }

    @Override
    public void enter() {
        //String namn, provision, telefon, orgnummer, epost, getuadress, postnummer, ort;
        for (int i = 0; i < mli.getNumberOfQuestions(); i++) {
            columns += String.format("%1$-20s", mli.getQuestion(i) + " ");
        }

        for (int i = 0; i < mli.getNumberOfQuestions(); i++) {
            newSupplier += String.format("%1$-20s", mli.getAnswer(i) + " ");
        }

        System.out.println(columns);
        System.out.println(newSupplier);

        System.out.println("Do you want to add this customer? (yes/no)");
    }

    @Override
    public CommandState handleInput2(String input) {
        switch (input) {
            case "yes": {
                System.out.println("added customer");
                DatabaseConnection.insertCustomer(mli);
                return new MainMenu();
            }
            case "no": {
                System.out.println("canceled adding customer");
                return new MainMenu();
            }
        }
        return null;
    }
}
