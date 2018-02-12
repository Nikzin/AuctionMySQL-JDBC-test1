package se.snrn.aukademin;

import se.snrn.aukademin.commands.InputStateMachine;

import java.util.Scanner;

public class Application {

    InputStateMachine inputStateMachine = new InputStateMachine();

    public Application() {

        DatabaseConnection databaseConnection = new DatabaseConnection("jdbc:mysql://localhost:3306/aukademin?useSSL=false", "java", "java");
        databaseConnection.connect();

        Scanner scanner = new Scanner(System.in);
        while(scanner.hasNext()) {
            inputStateMachine.handleInput(scanner.nextLine());
        }
    }
}
