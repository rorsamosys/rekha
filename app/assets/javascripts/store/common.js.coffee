$(document).ready ->
	$("#sidebar").on "click", ".submittable", ->
		id = $(this).val()
		taxonomy = $(this).attr 'data'
		checked = $('input:checkbox:checked')
		url = "/listing_product"
		myData =  { taxonomy : taxonomy, id : id}
		valuesArray = $("input:checkbox:checked").map(->
		  @value
		).get().join(",")
		console.log(valuesArray)
		$.ajax
			type: "GET",
			data: myData,
			url: url,
			success: (data) ->
				alert("In Success")

	$(".Search_input_wp").on "click", ".Search_btn",  ->	
		number = $("#order_number").val()
		if number.length <= 0
			alert("Please enter order number")
			return false