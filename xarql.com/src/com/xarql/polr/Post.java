/*
 * MIT License http://g.xarql.com Copyright (c) 2018 Bryan Christopher Johnson
 */
package com.xarql.polr;

import java.sql.Timestamp;

import com.xarql.main.DeveloperOptions;

public class Post
{
    // Attributes
    private int     id;
    private String  title;
    private String  content;
    private int     answers;
    private boolean removed;
    // Attributes For Sorting
    private Timestamp date;
    private Timestamp bump;
    private Timestamp subbump;
    private int       responses;
    private int       subresponses;

    // Limits
    public static final int MIN_ID           = 0;
    public static final int MIN_RESPONSES    = 0;
    public static final int MIN_SUBRESPONSES = 0;

    // Constants
    public static final String DELETION_MESSAGE         = "<span class=\"warn\">[POST REMOVED]</span>";
    public static final String TITLE_DELETION_MESSAGE   = DELETION_MESSAGE;
    public static final String CONTENT_DELETION_MESSAGE = "<span class=\"warn\">CONTENT NOT AVAILABLE</span><br><span class=\"warn\">REPLYING NOT PERMITTED</span>";
    public static final String DOMAIN                   = DeveloperOptions.getDomain();

    // Constructor
    public Post(int id, String title, String content, int answers, int removed, Timestamp date, Timestamp bump, Timestamp subbump, int responses, int subresponses)
    {
        setId(id);
        setTitle(title);
        setContent(content);
        setAnswers(answers);
        setRemoved(removed);
        setDate(date);
        setBump(bump);
        setSubbump(subbump);
        setResponses(responses);
        setSubresponses(subresponses);
    } // Post(all)

    // Mutators (All private)

    private void setId(int id)
    {
        if(id >= MIN_ID)
            this.id = id;
        else
            this.id = MIN_ID;
    } // setId(int id)

    private void setTitle(String title)
    {
        if(title == null)
            this.title = "";
        else
            this.title = title;
    } // setTitle(String title)

    private void setContent(String content)
    {
        this.content = content;
    } // setContent(String content)

    private void setAnswers(int answers)
    {
        if(answers >= MIN_ID)
            this.answers = answers;
        else
            this.answers = MIN_ID;
    } // setAnswers(int answers)

    private void setRemoved(int removed)
    {
        if(removed == 0)
            this.removed = false;
        else
        {
            this.removed = true;
            setTitle(TITLE_DELETION_MESSAGE);
            setContent(CONTENT_DELETION_MESSAGE);
        }
    } // setRemoved(int removed)

    private void setDate(Timestamp date)
    {
        this.date = date;
    } // setDate(Timestamp date)

    private void setBump(Timestamp bump)
    {
        this.bump = bump;
    } // setBump(Timestamp bump)

    private void setSubbump(Timestamp subbump)
    {
        this.subbump = subbump;
    } // setSubbump(Timestamp subbump)

    private void setResponses(int responses)
    {
        if(responses >= MIN_RESPONSES)
            this.responses = responses;
        else
            this.responses = MIN_RESPONSES;
    } // setResponses(int responses)

    private void setSubresponses(int subresponses)
    {
        if(subresponses >= MIN_SUBRESPONSES)
            this.subresponses = subresponses;
        else
            this.subresponses = MIN_SUBRESPONSES;
    } // setSubresponses(int subresponses)

    // Selectors (All public)

    public int getId()
    {
        return id;
    } // getId()

    public String getTitle()
    {
        return title.replace("{DOMAIN}", DOMAIN);
    } // getTitle()

    public String getTitleText()
    {
        return title.replaceAll("<[^>]*>", "");
    } // getTitleText()

    public String getContent()
    {
        return content.replace("{DOMAIN}", DOMAIN);
    } // getContent()

    public String getContentText()
    {
        return content.replaceAll("<[^>]*>", "");
    } // getContentText()

    public int getAnswers()
    {
        return answers;
    } // getAnswers()

    public boolean getRemoved()
    {
        return removed;
    } // getRemoved()

    public Timestamp getDate()
    {
        return date;
    } // getDate()

    public String getDisplayDate()
    {
        return getDate().toString().substring(0, 19);
    } // getDisplayDate()

    public Timestamp getBump()
    {
        return bump;
    } // getBump()

    public String timeSinceBump()
    {
        long timeSince = System.currentTimeMillis() - bump.getTime();
        if(timeSince < 60000) // Less than 1 minute
            return timeSince / 1000 + "s";
        else if(timeSince < 3600000) // Less than 1 hour
            return timeSince / 60000 + "m";
        else if(timeSince < 86400000) // Less than 1 day
            return timeSince / 3600000 + "h";
        else
            return timeSince / 86400000 + "d";
    } // timeSinceBump()

    public Timestamp getSubbump()
    {
        return subbump;
    } // getSubbump()

    public String timeSinceSubbump()
    {
        long timeSince = System.currentTimeMillis() - subbump.getTime();
        if(timeSince < 60000) // Less than 1 minute
            return timeSince / 1000 + "s";
        else if(timeSince < 3600000) // Less than 1 hour
            return timeSince / 60000 + "m";
        else if(timeSince < 86400000) // Less than 1 day
            return timeSince / 3600000 + "h";
        else
            return timeSince / 86400000 + "d";
    } // timeSinceBump()

    public int getResponses()
    {
        return responses;
    } // getResponses()

    public int getSubresponses()
    {
        return subresponses;
    } // getSubresponses()

    @Override
    public String toString()
    {
        return getTitleText() + " ~ " + getContentText();
    } // toString()

} // Post
