$(document).ready(function () {
    $(document).on('focusout', '#rePwd', function () {
        var pwd = $.trim($("#password").val());
        var cpwd = $.trim($("#rePwd").val());
        if(pwd.length>0 && cpwd.length>0) {
            if (pwd != cpwd) {
                alert("Both password should be equal");
                document.getElementById('password').value = null;
                document.getElementById('rePwd').value = null;
            }
        }
    });

    $(document).on('focusout', '#email', function () {
        var email = $.trim($("#email").val());
        if(email.length>0) {
            var check = $.ajax({
                url: "/checkEmailAvailability",
                data: {"email": email},
                method: "GET"
            });
            check.done(function (data) {
                if (data.email != null) {
                    alert("This email is already registered !");
                    document.getElementById('email').value = null;
                }
            });
            check.fail(function (jqXHR, textStatus) {
                console.log("Error in fetching emails");
            })
        }
    });


    $(document).on('focusout', '#userName', function () {
        var name = $.trim($("#userName").val());
        if(name.length>0) {
            var check = $.ajax({
                url: "/checkUserNameAvailability",
                data: {"userName": name},
                method: "GET"
            });
            check.done(function (data) {
                if (data.userName != null) {
                    alert("Username already exists");
                    document.getElementById('userName').value = null;
                }
            });
            check.fail(function (jqXHR, textStatus) {
                console.log("Error in fetching usernames");
            })
        }
    });
});
