$(window).load(function(){
	$('#items').isotope({
	  // options
	  itemSelector : '.item',
	  layoutMode : 'masonry'
	});
})

$(window).resize(function(){
	$('#items').isotope('reLayout');
})