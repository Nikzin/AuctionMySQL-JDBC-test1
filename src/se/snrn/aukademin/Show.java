package se.snrn.aukademin;

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;

public class Show {
    static ResultSetMetaData resultSetMetaData;


    public static void results(ResultSet resultSet) {
        String columnames = "";
        String rows = "";

        try {
            if (resultSet != null) {

                resultSetMetaData = resultSet.getMetaData();

                int columnsNumber = resultSetMetaData.getColumnCount();

                for (int i = 1; i <= columnsNumber; i++) {

                    columnames += String.format("%1$-30s", resultSetMetaData.getColumnLabel(i) + " ");
                }
                resultSet.absolute(0);
                while (resultSet.next()) {
                    for (int i = 1; i <= columnsNumber; i++) {

                        rows += String.format("%1$-30s", resultSet.getString(i) + " ");
                    }


                    rows += "\n";
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }


        System.out.println(columnames + "\n");
        System.out.println(rows);
    }

    public static void resultsWithGeneratedNumber(ResultSet resultSet) {
        String columnames = "";
        String rows = "";
        int generatedId = 0;


        try {
            if (resultSet != null) {

                resultSetMetaData = resultSet.getMetaData();

                int columnsNumber = resultSetMetaData.getColumnCount();
                columnames += String.format("%1$-30s", "#");
                for (int i = 2; i <= columnsNumber; i++) {
                    columnames += String.format("%1$-30s", resultSetMetaData.getColumnLabel(i) + " ");
                }
                resultSet.absolute(0);
                while (resultSet.next()) {
                    rows += String.format("%1$-30s", generatedId);
                    generatedId++;
                    for (int i = 2; i <= columnsNumber; i++) {

                        rows += String.format("%1$-30s", resultSet.getString(i) + " ");
                    }


                    rows += "\n";
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }


        System.out.println(columnames + "\n");
        System.out.println(rows);
    }
}



