<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="google-signin-client_id" id="google-signin-client_id" content="541616841401-iprs44jpiqi7b5afn66drpjgma242rkc.apps.googleusercontent.com">
  <title>Authentication ~ xarql</title>
</head>
<body>
  <div id="wrapper">
    <div id="column">
      <div class="g-signin2" data-onsuccess="onSignIn"></div>
      <p class="centered" id="google-p"><a href="#" id="google-sign-out">Sign out</a></p>
      <script>
      function signOut() {
    	  var auth2 = gapi.auth2.getAuthInstance();
    	  auth2.signOut().then(function () {
    		  console.log('User signed out.');
    		});
    	}
      </script>
      <c:if test="${id_token != null}">
        <div class="card">
          <p>Sign in status : ${id_token}</p>
        </div>
      </c:if>
    </div>
  </div>
  <noscript id="default-styles">
    <link rel="stylesheet" type="text/css" href="http://xarql.com/src/common/common.css">
    <link rel="stylesheet" type="text/css" href="http://xarql.com/src/common/card/large.css">
    <script>defaultStylesInjected = true;</script>
  </noscript>
  <noscript id="fonts">
    <!-- <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto"> -->
    <!-- <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Code+Pro"> -->
  </noscript>
  <script>
      var loadDeferredStyles = function() {
        var addStylesNode = document.getElementById("default-styles");
        var replacement = document.createElement("div");
        replacement.innerHTML = addStylesNode.textContent;
        replacement.id = "styles";
        document.body.appendChild(replacement);
        addStylesNode.parentElement.removeChild(addStylesNode);
      };
      var loadDeferredFonts = function() {
    	  var addFontsNode = document.getElementById("fonts");
    	  var replacement = document.createElement("div");
    	  replacement.innerHTML = addFontsNode.textContent;
    	  replacement.id = "fonts";
    	  document.body.appendChild(replacement);
    	  addFontsNode.parentElement.removeChild(addFontsNode);
      };
      var raf = window.requestAnimationFrame || window.mozRequestAnimationFrame ||
          window.webkitRequestAnimationFrame || window.msRequestAnimationFrame;
      if (raf) raf(function() { window.setTimeout(loadDeferredStyles, 0); });
      else window.addEventListener('load', loadDeferredStyles);
      if (raf) raf(function() { window.setTimeout(loadDeferredFonts, 0); });
      else window.addEventListener('load', loadDeferredFonts);
      var defaultStylesInjected = false;
  </script>
  <script src="https://code.jquery.com/jquery-3.3.1.min.js" integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8=" crossorigin="anonymous" defer=""></script>
  <script src="/xarql/src/auth/auth.js" defer=""></script>
  <script src="https://apis.google.com/js/platform.js" defer></script>
</body>
</html>