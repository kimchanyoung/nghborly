$(document).ready(function() {
  var pusher = new Pusher('545220afdca7480dd648', { encrypted: true});

  var channel = pusher.subscribe('test_channel');

  channel.bind('my_event', function(data) {
    $('#messages').append('<li>' + data.message + '</li>');
  });
});
