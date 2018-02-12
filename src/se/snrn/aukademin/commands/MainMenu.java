package se.snrn.aukademin.commands;

import se.snrn.aukademin.DatabaseConnection;
import se.snrn.aukademin.Show;

import java.sql.ResultSet;

public class MainMenu implements CommandState {
    @Override
    public void enter() {
        System.out.println("What do you want to do?");
        System.out.println("1. add new supplier");
        System.out.println("2. add new customer");
        System.out.println("3. add new auction");
        System.out.println("4. show products");
        System.out.println("5. show customers");
        System.out.println("6. show customers who have bought something");
        System.out.println("7. show active auctions");
        System.out.println("8. show provision between dates");
        System.out.println("9. show total provision per month");
    }
    @Override
    public CommandState handleInput2(String input) {
        try {
            Integer.parseInt(input);
        } catch (Exception e) {
            System.out.println("your input is not in the choice list, please try again:");
            return new MainMenu();
        }
            switch (Integer.parseInt(input)) {
                case 1: {
                    return new AddSupplierCommand();
                }
                case 2: {
                    return new AddCustomerCommand();
                }
                case 3: {
                    return new AddAuctionCommand();
                }
                case 4: {
                    ResultSet resultSet = DatabaseConnection.getProducts();
                    Show.resultsWithGeneratedNumber(resultSet);
                    return new MainMenu();
                }
                case 5: {
                    ResultSet resultSet = DatabaseConnection.getCustomers();
                    Show.resultsWithGeneratedNumber(resultSet);
                    return new MainMenu();
                }
                case 6: {

                    ResultSet resultSet = DatabaseConnection.showBuyers();
                    Show.results(resultSet);
                    return new MainMenu();
                }
                case 7: {
                    return new ShowActiveAuctionsCommand();
                }
                case 8: {
                    return new ShowProvisionbetweenDates();
                }
                case 9: {
                    ResultSet resultSet = DatabaseConnection.getProvisionPerMonth();
                    Show.results(resultSet);
                    return new MainMenu();
                }
                default: System.out.println("your input is not in the choice list, please try again:");
            }
        return new MainMenu();
    }

}
