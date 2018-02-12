package se.snrn.aukademin.commands;

import se.snrn.aukademin.DatabaseConnection;
import se.snrn.aukademin.Show;

import java.sql.ResultSet;

public class ShowAuctionBidHistory implements CommandState {
    private int selectedAuction;
    private String productName;

    public ShowAuctionBidHistory(int selectedAuction, String productName) {

        this.selectedAuction = selectedAuction;
        this.productName = productName;
    }

    @Override
    public void enter() {
        ResultSet resultSet = DatabaseConnection.getAuctionBids(selectedAuction);


            System.out.println("Bids on" + productName);


        Show.results(resultSet);
        System.out.println("type \"exit\" to return to main menu");
    }

    @Override
    public CommandState handleInput2(String input) {
        return null;
    }
}
