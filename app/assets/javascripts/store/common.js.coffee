addSelectedTaxon  = (first ,second , taxon_ids) -> 
	url = "/listing_product"
	myData =  {first : first, second : second, taxon_ids : taxon_ids }
	$.ajax
		type: "GET",
		data: myData,
		url: url,
									

$(document).ready ->
	$("#sidebar").on "click", ".submittable", ->
		taxon_ids = []
		first = []
		second = []

		
		$(".submittable:checked").each ->
			taxon_ids.push $(this).val()

		$(".price_sub:checked").each ->
			first.push $(this).attr 'range_first'
			second.push $(this).attr 'range_second'

  addSelectedTaxon first, second, taxon_ids


	$("#sidebar").on "click", ".price_sub", ->
		first = []
		second = []								
		taxon_ids = []	

		$(".submittable:checked").each ->
			taxon_ids.push $(this).val()

		$(".price_sub:checked").each ->
			first.push $(this).attr 'range_first'
			second.push $(this).attr 'range_second'

  addSelectedTaxon first, second, taxon_ids
			

	$(".Search_input_wp").on "click", ".Search_btn",  ->	
		number = $("#order_number").val()
		if number.length <= 0
			alert("Please enter order number")
			return false