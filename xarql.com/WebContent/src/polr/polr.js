$(document).ready(function () {
	function getUrlParameter(sParam) {
	    var sPageURL = decodeURIComponent(window.location.search.substring(1)),
	        sURLVariables = sPageURL.split('&'),
	        sParameterName,
	        i;

	    for (i = 0; i < sURLVariables.length; i++) {
	        sParameterName = sURLVariables[i].split('=');

	        if (sParameterName[0] === sParam) {
	            return sParameterName[1] === undefined ? true : sParameterName[1];
	        }
	    }
	}
	
	// Update page contents
	function update() {
		$(".status").each(function() {
			$(this).text("trying");
		});
	    var updt = $("<div></div>").load("http://xarql.com/polr/updt?id=" + $("#main-post-id").text() + "&page=" + $("#page").text() + "&sort=" + $("#sort").text() + "&flow=" + $("#flow").text() + "#full", function(response, status, xhr) {
	    	if(status == "error") {
	    		$(".status").each(function() {
	    			$(this).text(xhr.statusText);
	    		});
	    	}
	    	else {
				$("#main-post").replaceWith(updt.find("#main-post-container").html());
				$("#replies").replaceWith(updt.find("#replies-container").html());
				$("title").text(updt.find("#main-post-title").text() + " ~ xarql");
				viewLinks();
				$(".status").each(function() {
					$(this).text(xhr.statusText);
				});
	    	}
	    });
	}
	// Refresh on page load
	var refresh = getUrlParameter('refresh');
	if(typeof refresh != 'undefined' && refresh === 'true') {
		update();
		history.pushState("xarql", "xarql", window.location.pathname); // Remove parameters in URL
	}
  $(".update-button").each(function () {
		var $this = $(this);
		$this.on("click", function () {
			update();
		});
	});
  
  // AJAX posting
  $( "#post-form" ).submit(function( event ) {
	// Stop form from submitting normally
	    event.preventDefault();
	$(".status").each(function() {
		$(this).text("trying");
	});
   
    // Get values from form, reset form
    var $form = $( this ),
      title = $form.find("input[name='title']").val(),
      content = $form.find("textarea[name='content']").val(),
      answers = $form.find("input[name='answers']").val(),
      url = $form.attr("action");
    $form.trigger('reset');
    $("#replying-to-input").val(parseInt($("#main-post-id").text()));
    
    // Send the data using AJAX POST
    $.ajax({
    	type: "POST",
    	url: url,
    	data : {
    		title: title,
    		content: content,
    		answers: answers,
    	}
    	}).done(function(){
    		$(".status").each(function() {
    			$(this).text("success");
    		});
    	}).fail(function(){
    		$(".status").each(function() {
    			$(this).text("error");
    		});
    	}).always(function(){
    		window.setTimeout(update, 500); // wait .5 seconds
    	});
    });
  
  function nav() {
		$(".status").each(function() {
			$(this).text("trying");
		});
		var $form = $("#nav-form"),
	      page = $("#page-dropdown").val(),
	      sort = $("#sort-dropdown").val(),
	      flow = $("#flow-dropdown").val();
	    var updt = $("<div></div>").load("http://xarql.com/polr/updt?id=" + $("#main-post-id").text() + "&page=" + page + "&sort=" + sort + "&flow=" + flow, function(response, status, xhr) {
	    	if(status == "error") {
	    		$(".status").each(function() {
	    			$(this).text(xhr.statusText);
	    		});
	    	}
	    	else {
	    		$("#main-post").replaceWith(updt.find("#main-post-container").html());
				$("#replies").replaceWith(updt.find("#replies-container").html());
				$("title").text(updt.find("#main-post-title").text() + " ~ xarql");
				history.pushState("xarql", "xarql", window.location.pathname + "?page=" + page + "&sort=" + sort + "&flow=" + flow);
				$("#page").text(page);
				$("#sort").text(sort);
				$("#flow").text(flow);
				viewLinks();
				if(page > 0) { $("#prev-form").show(); $("#prev-form").css("display", "inline");} else { $("#prev-form").hide(); }
				if(page < 9) { $("#next-form").show(); $("#next-form").css("display", "inline");} else { $("#next-form").hide(); }
				$(".status").each(function() {
					$(this).text(xhr.statusText);
				});
				$("html, body").animate({scrollTop: 0}, "fast");
	    	}
	    });
	}
	$("#nav-form").submit(function(event) {
		event.preventDefault();
		nav();
	});
	$('#next-form').submit(function(event) {
		event.preventDefault();
		var pageNum = parseInt($('#page-dropdown').val());
		if(pageNum < 9)
			$('#page-dropdown').val(pageNum + 1);
		nav();
	});
	$('#prev-form').submit(function(event) {
		event.preventDefault();
		var pageNum = parseInt($('#page-dropdown').val());
		if(pageNum > 0)
			$('#page-dropdown').val(pageNum - 1);
		nav();
	});
  
  // Change font size
  $('html').css('font-size', Cookies.get('font-size'));
  $("#text-up").on("click", function() {
	  var computedFontSize = parseFloat(window.getComputedStyle(document.getElementById("html")).fontSize);
	  $('html').css('font-size', (computedFontSize + 1) + 'px');
	  Cookies.set('font-size', (computedFontSize + 1) + 'px', { path: '' });
  });
  $("#text-dn").on("click", function() {
	  var computedFontSize = parseFloat(window.getComputedStyle(document.getElementById("html")).fontSize); // Get font size of <html></html>
	  $('html').css('font-size', (computedFontSize - 1) + 'px'); // Change font size by -1
	  Cookies.set('font-size', (computedFontSize - 1) + 'px', { path: '' });
  });
  
  function view(id) {
		$(".status").each(function() {
			$(this).text("trying");
		});
	    var updt = $("<div></div>").load("http://xarql.com/polr/updt?id=" + id + "&page=0", function(response, status, xhr) {
	    	if(status == "error") {
	    		$(".status").each(function() {
	    			$(this).text(xhr.statusText);
	    		});
	    	}
	    	else {
				$("#main-post").replaceWith(updt.find("#main-post-container").html());
				$("#replies").replaceWith(updt.find("#replies-container").html());
				$("title").text(updt.find("#main-post-title").text() + " ~ xarql");
				history.pushState("xarql", "xarql", "http://xarql.com/polr/" + id);
				$(".status").each(function() {
					$(this).text(xhr.statusText);
				});
				$("html, body").animate({scrollTop: 0}, "fast");
				$("#replying-to-input").val(parseInt($("#main-post-id").text()));
				$("#page-dropdown").val(0);
				$("#prev-form").hide();
				$("#next-form").show();
				$("#next-form").css("display", "inline");
				viewLinks();
	    	}
	    });
	}
  
  function viewLinks()
  {
	  $(".view-link").each(function () {
		  $(this).unbind("click");
		  $(this).on("click", function () {
			  var id = $(this).attr("post-id");
			  view(id);
			  return false;
		});
	});
  }
  viewLinks();
  
  // Use crunch styles
  function crunch() {
    $("#styles").replaceWith('<link id="styles" rel="stylesheet" type="text/css" href="http://xarql.com/src/common/crunch.css">');
    Cookies.set('crunch', 'true', { path: ''});
    $("#crunch-button").hide();
    $("#uncrunch-button").show();
  }
  function uncrunch() {
    $("#styles").replaceWith('<div id="styles"><link rel="stylesheet" type="text/css" href="http://xarql.com/src/common/common.css"><link rel="stylesheet" type="text/css" href="http://xarql.com/src/common/card/large.css"></div>');
    Cookies.set('crunch', 'false', { path: ''});
    $("#uncrunch-button").hide();
    $("#crunch-button").show();
  }
  $("#crunch-button").on("click", function() {
    crunch();
  });
  $("#uncrunch-button").on("click", function() {
    uncrunch();
  });
  $("#uncrunch-button").hide();
  $(".ajax-bar").each(function() {
	  $(this).show();
  });
  function autoCrunch() {
	  if($('#styles').length)
		  defaultStylesInjected = true;
	  if(defaultStylesInjected == false)
		  window.setTimeout(autoCrunch, 100); /* wait 100 milliseconds before checking again */
	  else {
		  if(Cookies.get('crunch') === 'true')
			  crunch();
	  }
  }
  autoCrunch();
});