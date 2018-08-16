$(document).ready(function () {
	$('.inject-button').each(function () {
		var $this = $(this);
		$this.on("click", function () {
			if($('#iframe-' + $this.attr('post-id')).length == 0) {
				var iframe = document.createElement('iframe');
				iframe.setAttribute('src', 'http://xarql.com/polr/peek?id=' + $this.attr('post-id'));
				iframe.setAttribute('class', 'injected-iframe');
				iframe.setAttribute('id', 'iframe-' + $this.attr('post-id'));
				document.getElementById('wrapper').appendChild(iframe);
				$this.hide();
				$('#remover' + $this.attr('post-id')).show();
				history.pushState("xarql", "xarql", window.location.pathname + "?id=" + $('#main-post').text() + "&iframe=" + $this.attr('post-id'));
			}
		});
	});
	$('.remove-button').each(function () {
		var $this = $(this);
		$this.hide();
		$this.on("click", function () {
			if($('#iframe-' + $this.attr('post-id')).length > 0) {
				history.pushState("xarql", "xarql", window.location.pathname + "?id=" + $('#main-post').text());
				$('#iframe-' + $this.attr('post-id')).remove();
				$this.hide();
				$('#injector' + $this.attr('post-id')).show();
			}
		});
	});
});