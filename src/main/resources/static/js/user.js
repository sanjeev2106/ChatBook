$(document).ready(function () {

    $(document).on('keyup','#search-user',function () {
        //alert("hello");
        var name = $.trim($(this).val());
        var check = $.ajax({
            url: "/search",
            data: {"name": name},
            method: "GET"
        });
        check.done(function (users) {
            console.log(users);
            $("#search-user").autocomplete({
                //var email = $.trim($(this).val());
                source:users
            })
        });

    })

});