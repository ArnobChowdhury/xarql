package com.xarql.polr.edit;

import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.http.HttpServletResponse;

import com.xarql.polr.PageCache;
import com.xarql.util.DatabaseUpdate;

public class PostRestorer extends DatabaseUpdate
{
    private int id;

    public PostRestorer(int id, HttpServletResponse response)
    {
        super("UPDATE polr SET removed=0 WHERE id=?", response);
        this.id = id;
    } // PostRemover()

    @Override
    protected void setVariables(PreparedStatement statement) throws SQLException
    {
        statement.setInt(1, id);
    } // setVariables()

    @Override
    public boolean execute()
    {
        boolean output = super.makeRequest();
        PageCache.clear();
        return output;
    } // execute()

} // PostRestorer
