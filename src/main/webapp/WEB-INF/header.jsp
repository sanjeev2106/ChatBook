<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>ChatBook</title>

    <link rel="icon" href="/images/icon.ico" type="image/png" sizes="16x16">
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/home.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0-beta/js/materialize.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="js/post.js"></script>
    <script src="js/user.js"></script>

    <style>
        h1,h2,h3,h4,h5,h6{
            color: #016b90;
            font-family: "Courier New";
        }

        *{
            font-family: Helvetica;
        }
        .post-icon{
            font-size: 25px;
            padding: 6px;
            cursor: pointer;
        }
    </style>

</head>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <img src="images/icon3.ico" class="rounded-circle" style="width: 30px; height: 30px">
    <a class="navbar-brand" href="#">ChatBook</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarColor02"
            aria-controls="navbarColor02" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <%--<div class="col-12 xol-sm-12 col-md-6 col-lg-6 col-xl-6">
        <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">
            <img src="<%=user.getPhoto()%>" class="rounded-circle" style="height: 20px;width: 20px;"/>
            <span style="text-align: center; color: white"><%=user.getFirstName()%></span>
        </a>
        <div class="dropdown-menu" x-placement="bottom-start"
             style="position: absolute; will-change: transform; top: 0px; left: 0px; transform: translate3d(0px, 39px, 0px);">
            <%
                if (user.getAdmin()) {
            %>
            <a class="dropdown-item" href="#">Manage users</a>
            <a class="dropdown-item" href="#">Manage posts</a>
            <%
            } else {
            %>
            <a class="dropdown-item" href="#">View profile</a>
            <a class="dropdown-item" href="#">Edit profile</a>
            <a class="dropdown-item" href="#">Manage profile</a>
            <%
                }
            %>
            <a class="dropdown-item" href="#">Change password</a>
        </div>
    </div>--%>

    <div>
        <span class="fa-stack fa-1x">
            <i class="fa fa-circle fa-stack-2x"></i>
            <i class="fa fa-bell fa-stack-1x fa-inverse"></i>
            <span class="badge">4</span>
        </span>
    </div>

    <div class="collapse navbar-collapse" id="navbarColor02">
        <ul class="navbar-nav mr-auto" style="float: right">
            <li class="nav-item active">
                <a class="nav-link" href="/logout">Logout</a>
            </li>
        </ul>
    </div>


    <div class="search-container">
        <form class="form-inline my-2 my-lg-0">
            <input class="form-control mr-sm-2" type="text" placeholder="Search">
            <button class="btn btn-secondary my-2 my-sm-0" type="submit">Search</button>
        </form>
    </div>

</nav>
<body>