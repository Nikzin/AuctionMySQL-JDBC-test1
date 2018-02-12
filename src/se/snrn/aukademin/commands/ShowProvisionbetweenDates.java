package se.snrn.aukademin.commands;



import se.snrn.aukademin.DatabaseConnection;
import se.snrn.aukademin.MultiLineInput;
import se.snrn.aukademin.Show;

import java.sql.ResultSet;
import java.util.ArrayList;

public class ShowProvisionbetweenDates implements CommandState {

    private ArrayList<String> questions;
    int numberOfQuestions;
    int currrentQuestion;
    MultiLineInput mli;

    public ShowProvisionbetweenDates() {

        questions = new ArrayList<>();

        questions.add("Start date (YYYY-MM-DD 00:00");
        questions.add("End date (YYYY-MM-DD 00:00");

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
                ResultSet resultSet = DatabaseConnection.showProvisionBwDates(mli);
                Show.results(resultSet);
                return new MainMenu();
            }
            if (currrentQuestion< numberOfQuestions){
            System.out.println(mli.getQuestion(currrentQuestion));}
        }
        return null;
    }
}











