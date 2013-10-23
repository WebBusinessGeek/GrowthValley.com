function login() {
  $('#signup-form').hide();
  $('#login-form').show();
}

function signup() {
  $('#login-form').hide();
  $('#signup-form').show();
}

$(function() {
  $('#login-form form').bind("submit", function(data, status, xhr) {
    if($('#login-form #user_email').val().trim() == "") {
      $('#login-form span.error').text("Email cannot be left blank...");
      $('#login-form span.error').show('fast').delay(3000).hide('fast');
      return false;
    }
    else if($('#login-form #user_password').val().trim() == "") {
      $('#login-form span.error').text("Password cannot be left blank...");
      $('#login-form span.error').show('fast').delay(3000).hide('fast');
      return false;
    }
    else {
      return true;
    }
  });

  $('#signup-form form').bind("submit", function(data, status, xhr) {
    if($('#signup-form #user_full_name').val().trim() == "") {
      $('#signup-form span.error').text("Name cannot be left blank...");
      $('#signup-form span.error').show('fast').delay(3000).hide('fast');
      return false;
    }
    else if($('#signup-form #user_email').val().trim() == "") {
      $('#signup-form span.error').text("Email cannot be left blank...");
      $('#signup-form span.error').show('fast').delay(3000).hide('fast');
      return false;
    }
    else if($('#signup-form #user_password').val().trim() == "") {
      $('#signup-form span.error').text("Password cannot be left blank...");
      $('#signup-form span.error').show('fast').delay(3000).hide('fast');
      return false;
    }
    else {
      return true;
    }
  });

  $('#login-form form').bind("ajax:success", function(data, status, xhr) {
    alert('Logged in successfully!');
    location.reload(true);
  });

  $('#login-form form').bind("ajax:error", function(data, status, xhr) {
    $('#login-form span.error').text("Login failed!");
    $('#login-form span.error').show('fast').delay(3000).hide('fast');
  });

  $('#signup-form form').bind("ajax:success", function(data, status, xhr) {
    alert('Signed up successfully!');
    location.reload(true);
  });

  $('#signup-form form').bind("ajax:error", function(data, status, xhr) {
    $('#signup-form span.error').text("Signup failed!");
    $('#signup-form span.error').show('fast').delay(3000).hide('fast');
  });
});
