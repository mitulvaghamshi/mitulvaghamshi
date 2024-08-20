// login register forms screens
const signIn = $("#sign-in");
const signUp = $("#sign-up");
signUp.hide(); // initially hide registration screen

// login register screen switch buttons
$("#sign-in-btn").click(() => signUp.fadeOut(500, () => signIn.fadeIn(500))); // show signin
$("#sign-up-btn").click(() => signIn.fadeOut(500, () => signUp.fadeIn(500))); // show signup

// login inputs
const logUsername = $("#log-username");
const logPassword = $("#log-password");

// registration input
const regUsername = $("#reg-username");
const regPassword = $("#reg-password");
const regCfmPassword = $("#reg-cfm-password");

// password confirm check
const confirmPass = () => {
  if (regPassword.value !== regCfmPassword.value) {
    $("#cfmPass").addClass("error");
  } else {
    $("#cfmPass").removeClass("error");
  }
};

// change gender value on label clicked
const setGender = (value) => $("#reg-gender").val(value);

// login user
$("#form-sign-in").submit((event) => {
  event.preventDefault();
  $.post("php/login.php", $("#form-sign-in").serialize(), (res) => {
    if (parseInt(res) === 0) {
      signIn.fadeOut(2000);
      location.href = "home.php";
    } else {
      logUsername.val("");
      logPassword.val("");
    }
  });
});

// register new user
$("#form-sign-up").submit((event) => {
  event.preventDefault();
  $.post("php/register.php", $("#form-sign-up").serialize(), (res) => {
    if (parseInt(res) === 0) {
      hideSignUp();
      logUsername.val(regUsername.value);
      logPassword.val(regPassword.value);
      $("#log-submit-btn").val("Ready to Go!");
    }
  });
});
