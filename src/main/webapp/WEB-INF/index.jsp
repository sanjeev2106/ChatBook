<%@ page import="com.bciit.project.ChatBook.enums.Gender" %>
<%@page contentType="text/html;charset = UTF-8" language="java" %>
<%@page isELIgnored="false" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>ChatBook</title>
    <link rel="icon" href="/images/icon.ico" type="image/ico" sizes="16x16">
    <link rel="stylesheet" href="css/bootstrap.min.css">

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>


    <script src="js/registration.js"></script>
    <script src="js/forgotPassword.js"></script>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>

    <style>
        .required:after {
            content: " *";
            color: red
        }
    </style>

    <script>
        $(document).ready(function () {
            if (document.referrer !== 'http://localhost:8000/') {
                history.pushState(null, null, '/');
                window.addEventListener('popstate', function () {
                    history.pushState(null, null, '/');
                });
            }
        });
    </script>

</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <img src="images/icon3.ico" class="rounded-circle" style="width: 30px; height: 30px">
    <a class="navbar-brand" href="#">ChatBook</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarColor02"
            aria-controls="navbarColor02" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarColor02">
        <ul class="navbar-nav mr-auto" style="float: right">
            <li class="nav-item active">
                <a class="nav-link" href="#" data-toggle="modal" data-target="#loginModel">Login<span class="sr-only">(current)</span></a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#" data-toggle="modal" data-target="#registerModel">Register</a>
            </li>
        </ul>
    </div>
</nav>
<%
    String msg = null;
    try {
        msg = request.getAttribute("message").toString();
    } catch (Exception e) {
    }
    if (msg != null) {
%>

<div class="alert alert-danger alert-dismissible" style="text-align: center; margin-top: -10px ">
    <a href="#" class="close" data-dismiss="alert" aria-label="close"
       style="margin-top: -15px; display: block">&times;</a>
    <h5 style="margin-top: -2px; margin-bottom: -2px">${message}</h5>
</div>
<%
    }
%>
<div class="container">
    <div class="row">
        <div class="col-lg-6">
            <div class="card text-white bg-info mb-3" style="width: 100%">
                <div class="card-header" style="text-align: center"><h4>Recent Shares</h4></div>
                <div class="card-body">
                    <h4 class="card-title">Info card title</h4>
                    <p class="card-text">Some quick example text to build on the card title and make up the bulk of the
                        card's
                        content.</p>
                </div>
                <div class="card-body">
                    <h4 class="card-title">Info card title</h4>
                    <p class="card-text">Some quick example text to build on the card title and make up the bulk of the
                        card's
                        content.</p>
                </div>
            </div>
        </div>

        <div class="col-lg-6">
            <div class="card text-white bg-info mb-3" style="width: 100%">
                <div class="card-header" style="text-align: center"><h4>Top Posts</h4></div>
                <div class="card-body">
                    <h4 class="card-title">Info card title</h4>
                    <p class="card-text">Some quick example text to build on the card title and make up the bulk of the
                        card's
                        content.</p>
                </div>
                <div class="card-body">
                    <h4 class="card-title">Info card title</h4>
                    <p class="card-text">Some quick example text to build on the card title and make up the bulk of the
                        card's
                        content.</p>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>

<%--register model--%>

<div class="modal fade" id="registerModel" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header" style="background-color: #02a5de">
                <h3 class="modal-title">Register</h3>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form name="userRegister" action="/register" method="post" enctype="multipart/form-data">

                    <div class="form-group">
                        <label for="firstName" class="required">First Name:</label>
                        <input type="text" class="form-control" id="firstName" name="firstName" pattern="[a-zA-Z\s]+"
                               title="only letters and white spaces allowed" placeholder="First Name" required/>
                    </div>
                    <div class="form-group">
                        <label for="lastName" class="required">Last Name:</label>
                        <input type="text" class="form-control" id="lastName" name="lastName" pattern="[a-zA-Z\s]+"
                               title="only letters and white spaces allowed" placeholder="Last Name" required/>
                    </div>
                    <div class="form-group">
                        <label for="email" class="required">Email address:</label>
                        <input type="email" class="form-control" id="email" name="email" placeholder="Email Id"
                               required/>
                    </div>

                    <div class="form-group">
                        <label class="required">Session:</label>
                        <div>
                            <label for="startSession"></label><input type="number" class="form-control col-lg-6"
                                                                     id="startSession" name="startSession" min="1900"
                                                                     max="2099" step="1" placeholder="from" required/>
                            <label for="endSession"></label><input type="number" class="form-control col-lg-6"
                                                                   id="endSession" name="endSession" min="1900"
                                                                   max="2099" step="1" placeholder="to" required/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="userName" class="required">Username:</label>
                        <input type="text" class="form-control" id="userName" name="userName" pattern="[^' ']+"
                               title="white spaces not allowed" placeholder="Username" required/>
                    </div>
                    <div class="form-group">
                        <label for="password" class="required">Password:</label>
                        <input type="password" class="form-control" id="password" name="password" placeholder="password"
                               required/>
                    </div>
                    <div class="form-group">
                        <label for="rePwd" class="required">Re-enter Password:</label>
                        <input type="password" class="form-control" id="rePwd" name="rePwd"
                               placeholder="Re-enter password" required/>
                    </div>
                    <div class="form-group">
                        <label for="dob" class="required">Date of Birth:</label>
                        <input type="date" class="form-control" id="dob" name="dob" required/>
                    </div>

                    <div class="form-group">
                        <label class="required col-lg-4" style="margin-left: -15px;">Gender:</label>
                        <label class="col-lg-4"><input type="radio" name="gender" value="<%=Gender.MALE%>"/><span style="padding: 0 4px">Male</span></label>
                        <label class="col-lg-4"><input type="radio" name="gender" value="<%=Gender.FEMALE%>"/><span style="padding: 0 4px">Female</span></label>

                    </div>

                    <div class="form-group">
                        <label for="number" class="required">Mobile Number:</label>
                        <input type="tel" class="form-control" id="number" name="number" pattern="[0-9]{10}"
                               title="enter 10 digit valid mobile number" placeholder="Mobile number" required/>
                    </div>
                    <div class="form-group">
                        <label for="pic">Profile Photo:</label>
                        <div class="input-group">
                            <input type="file" id="pic" name="pic" class="form-control" />
                            <%--<label class="custom-file-label" for="pic"></label>--%>
                        </div>
                    </div>

                    <button type="submit" class="btn btn-primary">Register</button>
                </form>
            </div>
            <div class="modal-footer">

                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<%--login model--%>
<div class="modal fade" id="loginModel" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header" style="background-color: #02a5de">
                <h3 class="modal-title">Login</h3>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form name="userLogin" action="/login" method="post">
                    <div class="form-group ">
                        <label for="loginUserName" class="required">Username:</label>
                        <input type="text" class="form-control" id="loginUserName" name="userName"
                               placeholder="Enter Username" required/>
                    </div>
                    <div class="form-group ">
                        <label for="loginPassword" class="required">Password:</label>
                        <input type="password" class="form-control" id="loginPassword" name="password"
                               placeholder="Enter password" required/>
                    </div>
                    <div class="checkbox">
                        <label><input type="checkbox"> Remember me</label>
                    </div>
                    <button type="submit" class="btn btn-primary">Submit</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal" data-toggle="modal"
                            data-target="#forgotPasswordModel">Unable to Login
                    </button>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<%--forgot password model--%>
<div class="modal fade" id="forgotPasswordModel" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header" style="background-color: #02a5de">
                <h3 class="modal-title">Forgot Password</h3>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="form-group ">
                    <label for="userName" class="required">Please enter your registered Username/Email Id:</label>
                    <input type="text" class="form-control" id="forgotId" name="forgotId"
                           placeholder="Enter Username/Email Id" required/>
                </div>
                <button type="button" class="btn btn-primary" id="btnForgot" data-dismiss="modal">Submit</button>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>


<%--otp model--%>
<div class="modal fade" id="otpModel" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header" style="background-color: #02a5de">
                <h3 class="modal-title">Forgot Password > OTP</h3>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <span id="responseMsg"></span>
                <br/><br/>
                <div class="form-group ">
                    <input type="text" class="form-control" id="otp" name="otp"
                           placeholder="Enter OTP" required/>
                </div>

                <button type="submit" id="verifyOTP" class="btn btn-primary" >Ok
                </button>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>


<%--alert model--%>
<div class="modal fade" id="alertModel" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header" style="background-color: #02a5de">
                <h3 class="modal-title">Alert</h3>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body" style="text-align: center">

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Ok</button>
            </div>
        </div>
    </div>
</div>


<%--reset password model--%>
<div class="modal fade" id="resetPassword" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header" style="background-color: #02a5de">
                <h3 class="modal-title">Reset Password</h3>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">

                <%--<form name="otpForm" action="/changePassword" method="POST">--%>
                    <div class="form-group">
                        <label for="password" class="required">Password:</label>
                        <input type="password" class="form-control" id="changePassword" name="changePassword"
                               placeholder="password"
                               required/>
                    </div>
                    <div class="form-group">
                        <label for="rePwd" class="required">Re-enter Password:</label>
                        <input type="password" class="form-control" id="confirmPassword" name="confirmPassword"
                               placeholder="Re-enter password" required/>
                    </div>

                    <button type="button" id="btnChangePassword" class="btn btn-primary" >Submit
                    </button>
                <%--</form>--%>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>