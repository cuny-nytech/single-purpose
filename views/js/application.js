//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require jquery-readyselector
//= require_tree 


$(document).ready(function () {
	setInterval(function() {
		$("#colorful").animate( {								backgroundColor: "#FF0000" }, 200)
		.animate( {backgroundColor: '#FF00FF' }, 200)
		.animate( {backgroundColor: '#0000FF'}, 200)
		.animate( {backgroundColor: '#00FF00'}, 200)
		.animate( {backgroundColor: '#FFFF00'}, 200); 
	}, 1000);
});