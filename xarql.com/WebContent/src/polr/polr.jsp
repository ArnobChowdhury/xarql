<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.ArrayList" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html id="html">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>${posts.get(0).getTitleText()} ~ xarql</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta id="domain" value="${domain}">
  <link rel="stylesheet" type="text/css" id="theme-styles" href="${domain}/src/common/${theme}-common.min.css">
  <script src="https://code.jquery.com/jquery-3.3.1.min.js" integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8=" crossorigin="anonymous" defer=""></script>
  <script src="${domain}/src/common/jscookie.js" defer=""></script>
  <script src="${domain}/src/polr/polr.min.js" defer=""></script>
  <link rel="shortcut icon" href="${domain}/logo.png" type="image/x-icon">
</head>
<body>
  <div id="wrapper">
    <div id="column">
      <div id="main-post">
      <c:forEach begin="0" var="post" items="${posts}" end="0">
		  <div class="large-card">
		    <p class="overline">ID : <span id="main-post-id">${post.getId()}</span> ~ <a href="${domain}/polr/${post.getAnswers()}" class="view-link" post-id="${post.getAnswers()}">Replied To : ${post.getAnswers()}</a> ~ Date : ${post.getDisplayDate()}</p>
		    <p class="overline">Replies : <span id="reply-count">${post.getResponses()}</span> ~ SubReplies : ${post.getSubresponses()} ~ Bump : ${post.timeSinceBump()} ~ SubBump : ${post.timeSinceSubbump()}</p>
		    <h6>${post.getTitle()}</h6>
		    <p>${post.getContent()}</p>
		  </div>
		</c:forEach>
		</div>
      <div class="large-card" style="x-overflow:hidden;">
       <h4>Create Post</h4>
       <form action="${domain}/polr/post" method="POST" id="post-form">
         <input type="text" name="title" placeholder="Title (optional)" maxlength="64" style="width:100%;">
         <br/>
         <textarea name="content" cols="64" rows="8" tabindex="0" placeholder="Content (required)" wrap="soft" maxlength="4096" required style="width:100%;height:8rem;"></textarea>
         <br/>
         Replying To : <input type="number" id="replying-to-input" name="answers" value="${id}" min="0" size="4" required="" style="width:4rem;"/>
         <input id="submit" class="button" type="submit" value="Post"/> <input type="reset" class="button" value="Clear"/>
       </form>
       <c:if test="${not authenticated}">
         <form action="${domain}/auth/recaptcha" method="POST" id="recaptcha-form">
           <div style="position:relative;">
             <div data-theme="${theme}" class="g-recaptcha" data-callback="recaptchaCallback" data-sitekey="${recaptcha_key}"></div>
             <input id='recaptcha_check_empty' required="" tabindex='-1' style='width:50px; height:0; opacity:0; pointer-events:none; position:absolute; bottom:0;'>
           </div>
         </form>
         <script src="${domain}/src/auth/auth.min.js" defer=""></script>
         <script src="https://www.google.com/recaptcha/api.js" async="" defer=""></script>
       </c:if>
       <div class="link-div">
         <span class="link-span">
           <p class="link"><a href="${domain}/help">Help</a></p>
           <span class="ajax-bar" style="display:none">
             <p class="link"><a id="option-pane-open-button">Options</a></p>
             <p class="link"><a class="update-button">Update</a> <span class="status"></span></p>
           </span>
         </span>
       </div>
      </div>
      <div class="large-card" id="option-pane" style="display:none;position:relative;">
        <table>
          <tr><td><p>Size</td><td><span style="letter-spacing:1rem">:</span></td><td><a id="text-up">↑</a><span style="letter-spacing:1rem"> </span><a id="text-dn">↓</a></p></td></tr>
          <tr><td><p>Font</td><td><span style="letter-spacing:1rem">:</span></td><td><a id="font-light-button">Light</a><a id="font-normal-button">Normal</a></p></td></tr>
          <tr><td><p>Theme</td><td><span style="letter-spacing:1rem">:</span></td><td><a id="light-theme-button">Light</a><a id="dark-theme-button">Dark</a></p></td></tr>
        </table>
        <p><span style="position:absolute;bottom:0.8rem;right:2rem;"><a id="option-pane-close-button">Close</a></span></p>
      </div>
      <div id="replies">
		<c:forEach begin="1" var="post" items="${posts}">
		  <div class="large-card">
		    <p class="overline">ID : ${post.getId()} ~ Date : ${post.getDisplayDate()}</p>
		    <p class="overline">Replies : ${post.getResponses()} ~ SubReplies : ${post.getSubresponses()} ~ Bump : ${post.timeSinceBump()} ~ SubBump : ${post.timeSinceSubbump()}</p>
		    <h6>${post.getTitle()}</h6>
		    <p>${post.getContent()}</p>
		    <p><a href="${domain}/polr/${post.getId()}" class="view-link" post-id="${post.getId()}">View</a></p>
		  </div>
		</c:forEach>
	  </div>
	  <div class="large-card">
	    <h4>Navigation</h4>
	    <form id="nav-form" action="${domain}/polr/${id}" method="GET" accept-charset="utf-8" style="display:inline;">
	      <table style="display:inline">
	        <tr><td>Page</td><td>Sort</td><td>Flow</td></tr>
	        <tr><td><select name="page" id="page-dropdown">
	                <c:forEach begin="0" end="9" var="i">
                    <option value="${i}" <c:if test="${i == page}">selected="selected"</c:if> >${i}</option>
                    </c:forEach>
                  </select></td>
                <td><select name="sort" id="sort-dropdown">
                    <option value="date" <c:if test="${sort.equals('date')}">selected="selected"</c:if> >Date</option>
                    <option value="responses" <c:if test="${sort.equals('responses')}">selected="selected"</c:if> >Responses</option>
                    <option value="subresponses" <c:if test="${sort.equals('subresponses')}">selected="selected"</c:if> >SubResponses</option>
                    <option value="bump" <c:if test="${sort.equals('bump')}">selected="selected"</c:if> >Bump</option>
                    <option value="subbump" <c:if test="${sort.equals('subbump')}">selected="selected"</c:if> >SubBump</option>
                  </select></td>
                <td><select name="flow" id="flow-dropdown">
                    <option value="asc"  <c:if test="${flow.equals('asc')}">selected="selected"</c:if> >Ascending</option>
                    <option value="desc" <c:if test="${flow.equals('desc')}">selected="selected"</c:if> >Descending</option>
                  </select></td>
            </tr>
	      </table>
	      <input id="submit" class="button" type="submit" value="Custom"/>
	    </form>
	    <form <c:if test="${page <= 0}">style="display:none;"</c:if> id="prev-form" action="${domain}/polr/${id}?page=${page - 1}&sort=${sort}&flow=${flow}" style="display:inline;"><input id="submit" class="button" type="submit" value="Prev"/></form>
	    <form <c:if test="${page >= 9}">style="display:none;"</c:if> id="next-form" action="${domain}/polr/${id}?page=${page + 1}&sort=${sort}&flow=${flow}" style="display:inline;"><input id="submit" class="button" type="submit" value="Next"/></form>
      <div class="link-div">
        <span class="link-span">
          <p class="link"><a href="${domain}/polr/find">Search</a></p>
          <p class="link"><a href="${domain}/polr/flat">Browse</a></p>
          <span class="ajax-bar" style="display:none">
            <p class="link"><a class="update-button" href="#">Update</a> <span class="status"></span></p>
          </span>
        </span>
      </div>
	  </div>
	    <div id="data" class="card" style="visibility:hidden;display:none;">
		  <p id="page">${page}</p>
		  <p id="sort">${sort}</p>
		  <p id="flow">${flow}</p>
	  </div>
    </div>
  </div>
</body>
</html>