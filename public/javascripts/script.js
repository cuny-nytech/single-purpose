// Javascript file that will add dynamic things to the page


$(document).ready(function() {
  $('button').on('click', function() {
    var cList = $('#city_list').data('cities');
    var cityList = cList.trim().split(/\s+/);
    $('.city').toggle();
  });
});

