function login() {
  $('#signup-form').hide();
  $('#login-form').show();
}

function signup() {
  $('#login-form').hide();
  $('#signup-form').show();
}

$(function() {
  $('#login-form form').bind("ajax:success", function(data, status, xhr) {
    location.reload(true);
  });

  $('#login-form form').bind("ajax:error", function(data, status, xhr) {
    $('#login-form div.error').text('');
    var error = $.parseJSON(status.responseText).error;
    $('#login-form div.error').append("<p>" + error + "</p>");
    $('#login-form div.error').show('fast').delay(3000).hide('fast');
  });

  $('#signup-form form').bind("ajax:success", function(data, status, xhr) {
    location.reload(true);
  });

  $('#signup-form form').bind("ajax:error", function(data, status, xhr) {
    $('#signup-form div.error').text('');
    var errors = $.parseJSON(status.responseText).errors;
    $.each(errors, function(elm, msg) {
      $('#signup-form div.error').append("<p>" + elm + " " + msg + "</p>");
    });
    $('#signup-form div.error').show('fast').delay(3000).hide('fast');
  });
});
