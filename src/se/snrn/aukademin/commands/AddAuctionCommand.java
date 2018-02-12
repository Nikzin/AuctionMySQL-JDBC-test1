package se.snrn.aukademin.commands;

import se.snrn.aukademin.DatabaseConnection;
import se.snrn.aukademin.MultiLineInput;
import se.snrn.aukademin.Show;

import java.sql.Array;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;

public class AddAuctionCommand implements CommandState {

    private ArrayList<String> questions;
    int numberOfQuestions;
    int currrentQuestion;
    MultiLineInput mli;
    ResultSet resultSet;
    ResultSetMetaData resultSetMetaData;


    public AddAuctionCommand() {

        questions = new ArrayList<>();

        questions.add("Product ID");
        questions.add("Start date (YYYY-MM-DD 00:00");
        questions.add("End date (YYYY-MM-DD 00:00");
        questions.add("Start price");
        questions.add("Accepted price");

        currrentQuestion = 0;

        mli = new MultiLineInput(questions);
        numberOfQuestions = mli.getNumberOfQuestions();
    }

    @Override
    public void enter() {
        Show.resultsWithGeneratedNumber(DatabaseConnection.getProducts());
        resultSet = DatabaseConnection.getProductsTable();
    }

    @Override
    public CommandState handleInput2(String input) {
        if (input != null && currrentQuestion < numberOfQuestions) {


            if (currrentQuestion == 0) {
                try {
                    if (resultSet != null) {

                        resultSet.absolute(Integer.parseInt(input)+1);
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
                try {
                    if (resultSet != null) {
                        input = String.valueOf(resultSet.getInt(1));
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }

            mli.setAnswer(currrentQuestion, input);

            currrentQuestion++;

            if (currrentQuestion == numberOfQuestions) {
                return new ConfirmAddAuktion(mli);
            }
            System.out.println(mli.getQuestion(currrentQuestion) + currrentQuestion);
        }

        return null;
    }
}
