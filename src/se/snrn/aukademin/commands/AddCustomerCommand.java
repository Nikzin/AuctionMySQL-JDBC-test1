package se.snrn.aukademin.commands;

import se.snrn.aukademin.MultiLineInput;

import java.util.ArrayList;

public class AddCustomerCommand implements CommandState {

    private ArrayList<String> questions;
    int numberOfQuestions;
    int currrentQuestion;
    MultiLineInput mli;

    public AddCustomerCommand() {

        questions = new ArrayList<>();

        questions.add("personal ID number");
        questions.add("first name");
        questions.add("last name");
        questions.add("phone number");
        questions.add("e-mail");
        questions.add("address: street name");
        questions.add("post code");
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
                return new ConfirmAddCustomer(mli);
            }
            System.out.println(mli.getQuestion(currrentQuestion));
        }
        return null;
    }
}
