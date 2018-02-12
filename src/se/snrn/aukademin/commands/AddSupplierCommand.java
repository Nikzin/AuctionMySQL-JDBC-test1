package se.snrn.aukademin.commands;

import se.snrn.aukademin.MultiLineInput;

import java.util.ArrayList;

public class AddSupplierCommand implements CommandState {

    private ArrayList<String> questions;
    int numberOfQuestions;
    int currrentQuestion;
    MultiLineInput mli;

    public AddSupplierCommand() {

        questions = new ArrayList<>();

        questions.add("name");
        questions.add("comission (decimal number");
        questions.add("phone number");
        questions.add("corporate ID number");
        questions.add("e-mail");
        questions.add("address: street name");
        questions.add("postcode");
        questions.add("location");


        currrentQuestion = 0;

        mli = new MultiLineInput(questions);
        numberOfQuestions = mli.getNumberOfQuestions();
    }

    @Override
    public void enter() {
        System.out.println(questions.get(currrentQuestion));
    }

    @Override
    public CommandState handleInput2(String input) {
        if (input != null && currrentQuestion < numberOfQuestions) {
            mli.setAnswer(currrentQuestion, input);
            currrentQuestion++;
            if (currrentQuestion == numberOfQuestions) {
                return new ConfirmAddSupplier(mli);
            }
            System.out.println(mli.getQuestion(currrentQuestion));
        }
        return null;
    }
}
