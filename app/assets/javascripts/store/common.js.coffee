$(document).ready ->
	$("#sidebar").on "click", ".submittable", ->
		taxon_ids = []
		$(".submittable:checked").each ->
			taxon_ids.push $(this).val()
			return
		url = "/listing_product"
		myData =  { taxon_ids : taxon_ids}
		
		$.ajax
			type: "GET",
			data: myData,
			url: url,
			
			

	$(".Search_input_wp").on "click", ".Search_btn",  ->	
		number = $("#order_number").val()
		if number.length <= 0
			alert("Please enter order number")
			return false