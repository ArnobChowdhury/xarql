/*
 * MIT License http://g.xarql.com Copyright (c) 2018 Bryan Christopher Johnson
 */
package com.xarql.chat;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;

import javax.servlet.http.HttpServletResponse;

import com.xarql.util.DBManager;

public class MessageRetriever
{

    private HttpServletResponse response;
    private int                 lastID;

    private static final int DEFAULT_LAST_ID = 0;

    public MessageRetriever(HttpServletResponse response, int lastID)
    {
        this.response = response;
        setLastID(lastID);
    } // MessageRetriever(HttpServletResponse response, int lastID)

    public MessageRetriever(HttpServletResponse response)
    {
        this(response, 0);
    } // MessageRetriever(HttpServletResponse response)

    public MessageRetriever(int id) // Backend only
    {
        setLastID(id);
    } // MessageRetriever(int id)

    private void setLastID(int lastID)
    {
        if(lastID >= 0)
            this.lastID = lastID;
        else
            this.lastID = DEFAULT_LAST_ID;
    } // setLastID()

    public ArrayList<Message> execute()
    {
        if(response != null)
        {
            return ChatRoom.getList(lastID);
        }
        else
        {
            return getFromDatabase();
        }
    } // execute()

    private ArrayList<Message> getFromDatabase()
    {
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet rs = null;
        ArrayList<Message> messages = new ArrayList<Message>();
        String query = "SELECT * FROM chat WHERE date>? AND date<? AND id>?";
        Timestamp now = new Timestamp(System.currentTimeMillis());
        Timestamp sixHoursAgo = new Timestamp(System.currentTimeMillis() - 21600000);

        try
        {
            connection = DBManager.getConnection();
            statement = connection.prepareStatement(query);

            statement.setTimestamp(1, sixHoursAgo);
            statement.setTimestamp(2, now);
            statement.setInt(3, lastID);

            rs = statement.executeQuery();
            while(rs.next())
            {
                int rsId = rs.getInt("id");
                String rsMessage = rs.getString("message");
                Timestamp rsDate = rs.getTimestamp("date");
                String rsSession = rs.getString("session");
                Message currentMessage = new Message(rsId, rsMessage, rsDate, rsSession);
                messages.add(currentMessage);
            }
            return messages;
        }
        catch(SQLException s)
        {
            messages.clear();
            return messages;
        }
        finally
        {
            // Close in reversed order.
            if(rs != null)
                try
                {
                    rs.close();
                }
                catch(SQLException s)
                {
                }
            if(statement != null)
                try
                {
                    statement.close();
                }
                catch(SQLException s)
                {
                }
            if(connection != null)
                try
                {
                    connection.close();
                }
                catch(SQLException s)
                {
                }
        }
    } // getFromDatabase()
} // MessageRetriever
