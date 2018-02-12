package se.snrn.aukademin.commands;

import se.snrn.aukademin.DatabaseConnection;
import se.snrn.aukademin.Show;

import java.sql.ResultSet;
import java.sql.SQLException;

public class ShowActiveAuctionsCommand implements CommandState {
    ResultSet resultSet;
    private String productName;

    @Override
    public void enter() {

        resultSet = DatabaseConnection.showAuctions();
        System.out.println("Select a auction to show bid history");
        System.out.println("type \"exit\" to return to main menu");
        Show.resultsWithGeneratedNumber(resultSet);
    }

    @Override
    public CommandState handleInput2(String input) {
        int selectedAuction = 0;
        if (resultSet != null) {


            try {
                resultSet.absolute(Integer.parseInt(input) + 1);
                selectedAuction = resultSet.getInt("auktion_id");
                productName = resultSet.getString("produkt_namn");
            } catch (SQLException e) {
                e.printStackTrace();
            }

            return new ShowAuctionBidHistory(selectedAuction, productName);
        }

        return null;
    }
}
