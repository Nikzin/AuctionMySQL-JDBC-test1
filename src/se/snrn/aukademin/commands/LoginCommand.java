package se.snrn.aukademin.commands;

import se.snrn.aukademin.DatabaseConnection;
import se.snrn.aukademin.MultiLineInput;
import se.snrn.aukademin.Show;

import java.sql.Array;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;

public class LoginCommand implements CommandState {

    private ArrayList<String> questions;
    int numberOfQuestions;
    int currrentQuestion;
    MultiLineInput mli;
    ResultSet resultSet;
    ResultSetMetaData resultSetMetaData;
    private boolean loginSuccessfull;


    public LoginCommand() {

        questions = new ArrayList<>();

        questions.add("Username");
        questions.add("Password");


        currrentQuestion = 0;

        mli = new MultiLineInput(questions);
        numberOfQuestions = mli.getNumberOfQuestions();
    }

    @Override
    public void enter() {
        System.out.println(mli.getQuestion(0));
    }

    @Override
    public CommandState handleInput2(String input) {

        if (input != null && currrentQuestion < numberOfQuestions) {
            mli.setAnswer(currrentQuestion, input);
            currrentQuestion++;
        }
        if (currrentQuestion == numberOfQuestions) {
            loginSuccessfull = DatabaseConnection.tryLogin(mli);
            if (loginSuccessfull) {
                return new MainMenu();
            } else {
                System.out.println("Wrong username/password, please try again");
                return new LoginCommand();
            }
        }
        if (currrentQuestion < numberOfQuestions) {
            System.out.println(mli.getQuestion(currrentQuestion));
        }

        return null;
    }
}
