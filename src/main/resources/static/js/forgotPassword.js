$(document).ready(function () {

    $(document).on('click', '#btnForgot', function () {
        $.ajax({
            url: "/forgotPassword",
            data: {"forgotId": $("#forgotId").val()},
            method: "POST",
            success: function (data) {
                if (data.includes('@')) {
                    $("#otpModel .modal-body #responseMsg").text(data);
                    $("#otpModel").modal("show");
                } else {
                    $("#alertModel .modal-body").text(data);
                    $("#alertModel").modal("show");
                }
            }
        });
    });

    $(document).on('click', '#verifyOTP', function () {
        var otp = $.trim($("#otp").val());
        if(otp.length>0) {
            $.ajax({
                url: "/validateOTP",
                data: {"otp": otp},
                method: "POST",
                success: function (data) {
                    if (data) {
                        $("#otpModel").modal("hide");
                        $("#resetPassword").modal("show");
                    } else {
                        $("#alertModel .modal-body").text("Invalid OTP");
                        $("#alertModel").modal("show");
                    }
                }
            })
        }else {
            $("#alertModel .modal-body").text("Please enter the OTP");
            $("#alertModel").modal("show");
        }
    });

    $(document).on('click', '#btnChangePassword', function () {

        var password = $.trim($("#changePassword").val());
        var cnfPassword = $.trim($("#confirmPassword").val());

        if (password.length > 0 && cnfPassword.length > 0) {
            if (password == cnfPassword) {
                $.ajax({
                    url: "/changePassword",
                    data: {"changePassword": password},
                    method: "POST",
                    success: function (data) {
                        if (data) {
                            $("#resetPassword").modal("hide");
                            $("#alertModel .modal-body").text("Password Updated !");
                            $("#alertModel").modal("show");
                        }else{
                            $("#resetPassword").modal("hide");
                            $("#alertModel .modal-body").text("Password didn't updated  !");
                            $("#alertModel").modal("show");
                        }
                    }
                })
            } else {

                alert("Both password should be equal.");
                document.getElementById('changePassword').value = null;
                document.getElementById('confirmPassword').value = null;
            }
        } else {
            /*$("#alertModel .modal-body").text("Field can't be empty.");
            $("#alertModel").modal("show");*/
            alert("Field can't be empty.");
        }

    });

});