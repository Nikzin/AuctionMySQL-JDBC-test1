package se.snrn.aukademin.commands;

import se.snrn.aukademin.DatabaseConnection;
import se.snrn.aukademin.MultiLineInput;

public class ConfirmAddSupplier implements CommandState {
    private MultiLineInput mli;

    String newSupplier;
    String columns;

    public ConfirmAddSupplier(MultiLineInput mli) {

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

        System.out.println("Do you want to add this supplier? (yes/no)");
    }

    @Override
    public CommandState handleInput2(String input) {
        switch (input) {
            case "yes": {
                System.out.println("Supplier added");
                DatabaseConnection.insertSupplier(mli);
                return new MainMenu();
            }
            case "no": {
                System.out.println("Adding of supplier cancelled");
                return new MainMenu();
            }
        }
        return null;
    }
}
