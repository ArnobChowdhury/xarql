package com.xarql.jott;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.xarql.util.BuildTimer;
import com.xarql.util.ServletUtilities;

/**
 * Servlet implementation class JottMarkDown
 */
@WebServlet ("/JottMarkDown")
public class JottMarkDown extends HttpServlet
{
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public JottMarkDown()
    {
        super();
    } // JottMarkDown()

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
     *      response)
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        BuildTimer bt = new BuildTimer(request);
        ServletUtilities util = new ServletUtilities(request);
        util.standardSetup();

        try
        {
            String input = request.getParameter("content");
            request.setAttribute("input", input);
            JottFile jf = new JottFile(input);
            String output = jf.getContent();
            request.setAttribute("output", output);
        }
        catch(NullPointerException npe)
        {
            request.setAttribute("input", "");
            request.setAttribute("output", "");
        }

        request.getRequestDispatcher("/src/jott/jott-md.jsp").forward(request, response);
    } // doGet()

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
     *      response)
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        doGet(request, response);
    } // doPost()

} // JottMarkDown
