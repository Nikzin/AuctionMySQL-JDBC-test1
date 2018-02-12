package se.snrn.aukademin;

import java.util.ArrayList;

public class MultiLineInput {

    private ArrayList<String> questions;
    private ArrayList<String> answers;

    public MultiLineInput(ArrayList<String> questions) {
        this.questions = questions;

        answers = new ArrayList<>();

    }


    public int getNumberOfQuestions() {
        return questions.size();
    }

    public void setAnswer(int questionNumber, String answer) {
        answers.add(questionNumber, answer);
    }

    public String getQuestion(int currrentQuestion) {
        return questions.get(currrentQuestion);
    }

    public String getAnswer(int answer) {
        return answers.get(answer);
    }

    public ArrayList<String> getAnswers() {
        return answers;
    }
}
