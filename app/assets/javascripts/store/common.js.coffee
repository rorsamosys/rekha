$(document).ready ->
	$("#available").on "click", "#change_zip_btn", ->
		#$("#available").html("<%= escape_javascript(render partial: 'spree/shared/check_avalability') %>")