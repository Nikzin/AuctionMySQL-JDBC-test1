package se.snrn.aukademin;

import java.sql.*;

public class DatabaseConnection {

    private String url;
    private String user;
    private String pass;
    static Connection connection;

    public DatabaseConnection(String url, String user, String pass) {

        this.url = url;
        this.user = user;
        this.pass = pass;


    }

    public void connect() {
        try {
            connection = DriverManager.getConnection(url, user, pass);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static ResultSet getProductsTable() {

        ResultSet resultSet = null;
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("SELECT * FROM produkter");
            resultSet = preparedStatement.executeQuery();
            resultSet.next();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return resultSet;
    }

    public static ResultSet getProducts() {

        ResultSet resultSet = null;
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("SELECT Produkt_ID AS Product_ID, produkter.Namn AS Product, Beskrivning AS Description, " +
                    "leverantör.Namn AS Supplier FROM produkter " +
                    "JOIN leverantör ON produkter.Leverantör_ID = leverantör.Leverantör_ID");
            resultSet = preparedStatement.executeQuery();
            resultSet.next();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return resultSet;
    }

    public static ResultSet getResult(String statement) {

        ResultSet resultSet = null;
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(statement);
            resultSet = preparedStatement.executeQuery();
            resultSet.next();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return resultSet;
    }

    public static void insertSupplier(MultiLineInput mli) {
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("CALL LäggTillLeverantör(?,?,?,?,?,?,?,?)");
            int i = 1;
            for (String value : mli.getAnswers()
                    ) {
                preparedStatement.setString(i, value);
                i++;
            }
            preparedStatement.execute();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void insertAuction(MultiLineInput mli) {
        try {


            PreparedStatement preparedStatement = connection.prepareStatement("CALL Skapa_Auktion(?,?,?,?,?)");


            preparedStatement.setInt(1, Integer.parseInt(mli.getAnswer(0)));
            preparedStatement.setTimestamp(2, Timestamp.valueOf(mli.getAnswer(1) + ":00"));

            preparedStatement.setTimestamp(3, Timestamp.valueOf(mli.getAnswer(2) + ":00"));
            preparedStatement.setInt(4, Integer.parseInt(mli.getAnswer(3)));
            preparedStatement.setInt(5, Integer.parseInt(mli.getAnswer(4)));

            preparedStatement.execute();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static ResultSet getCustomers() {

        ResultSet resultSet = null;
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("SELECT kund.Kund_ID AS Customers,\n" +
                    "  kund.Personnummer AS Person_Number,\n" +
                    "  kund.Förnamn AS First_Name,\n" +
                    "  kund.Efternamn Last_Name,\n" +
                    "  kund.Telefon AS Telephon,\n" +
                    "  kund.Epost AS Email,\n" +
                    "  kund.Gatuadress AS Street_Address,\n" +
                    "  kund.Postnummer AS ZIP_Code,\n" +
                    "  kund.Ort AS Location\n" +
                    "FROM kund;");
            resultSet = preparedStatement.executeQuery();
            resultSet.next();

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return resultSet;
    }

    public static void insertCustomer(MultiLineInput mli) {
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("CALL LäggTillKund(?,?,?,?,?,?,?,?)");
            int i = 1;
            for (String value : mli.getAnswers()
                    ) {
                preparedStatement.setString(i, value);
                i++;
            }
            preparedStatement.execute();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static ResultSet showBuyers() {

        ResultSet resultSet = null;
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("SELECT * FROM kunder_som_köpt_något_samt_totalt_ordervärde");
            resultSet = preparedStatement.executeQuery();
            resultSet.next();

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return resultSet;
    }

    public static ResultSet showAuctions() {

        ResultSet resultSet = null;
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("CALL ShowActiveAuctions");
            resultSet = preparedStatement.executeQuery();
            resultSet.next();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return resultSet;
    }

    public static ResultSet getAuctionBids(int selectedAuction) {
        ResultSet resultSet = null;
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("CALL showAuctionBids(?)");
            preparedStatement.setInt(1, selectedAuction);
            resultSet = preparedStatement.executeQuery();
            resultSet.next();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return resultSet;
    }

    public static ResultSet getProvisionPerMonth() {
        ResultSet resultSet = null;
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("SELECT * FROM total_provision_per_månad");
            resultSet = preparedStatement.executeQuery();
            resultSet.next();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return resultSet;
    }

    public static ResultSet showProvisionBwDates(MultiLineInput mli) {
        ResultSet resultSet = null;
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("CALL auktioner_som_avslutas_under_ett_visst_datum (?,?)");

            preparedStatement.setTimestamp(1, Timestamp.valueOf(mli.getAnswer(0) + ":00"));

            preparedStatement.setTimestamp(2, Timestamp.valueOf(mli.getAnswer(1) + ":00"));
            resultSet = preparedStatement.executeQuery();
            resultSet.next();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return resultSet;
    }

    public static boolean tryLogin(MultiLineInput mli) {
        ResultSet resultSet = null;
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("CALL enterpassword (?,?)");
            int i = 1;
            for (String value : mli.getAnswers()
                    ) {
                preparedStatement.setString(i, value);
                i++;
            }
            resultSet = preparedStatement.executeQuery();

            return resultSet.next();


        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
