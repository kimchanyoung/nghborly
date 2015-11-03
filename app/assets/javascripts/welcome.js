$(document).ready(function() {
  $('.river-form').on('click', function(event) {
    event.preventDefault();

    var url = event.currentTarget.action;

    $.ajax({
      url: url
    })
    .done(function(data) {
      $('#river').html('');
      $('#river').append(data);
    });
  });
});
