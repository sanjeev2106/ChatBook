$(document).ready(function () {
    $('#div-display-image').hide();
    $('#div-display-video').hide();
    $('#div-display-doc').hide();

    $('#image-file').change( function(event) {
        $("#display-image").fadeIn("fast").attr('src', URL.createObjectURL(event.target.files[0]));
        $('#div-display-image').show();
    });

    $('#video-file').change( function(event) {
        $("#display-video").fadeIn("fast").attr('src', URL.createObjectURL(event.target.files[0]));
        $('#div-display-video').show();
    });

    $('#doc-file').change( function(event) {
        $("#display-doc").fadeIn("fast").attr('data', URL.createObjectURL(event.target.files[0]));
        $('#div-display-doc').show();
    });

    // text-post
    $(document).on('click', '#btn-text-post', function () {
        var post = $.trim($("#text-post").val());
        console.log(post);

        if(post.length>0){
            $.ajax({
                url: "/post/text/save",
                data: {"post": post, "visibility": $("#text-visibility").val()},
                method: "POST",
                success: function (data) {
                    if(data){
                        //console.log("data: "+data);
                        $("#text-post-modal").modal("hide");
                        $("#alertModel .modal-body").text("Post shared..! :-)");
                        $("#alertModel").modal("show");
                        location.reload(true);
                    }else{
                        $("#text-post-modal").modal("hide");
                        $("#alertModel .modal-body").text("Some error occurring while posting please try again..! :-(");
                        $("#alertModel").modal("show");
                    }

                },
                error: function(XMLHttpRequest, textStatus, errorThrown) {
                    console.log("Status: " + textStatus + "Error: " + errorThrown);
                }
            });
        }else{
            $("#alertModel .modal-body").text("Please write your thoughts first");
            $("#alertModel").modal("show");
        }
    });


    // image post

    $('#image-post-form').submit( function(e) {
        e.preventDefault();

        var data = new FormData(this); // <-- 'this' is your form element

        $.ajax({
            url: '/post/image/save',
            data: data,
            cache: false,
            contentType: false,
            processData: false,
            type: 'POST',
            success: function(data){
                if(data){
                    //console.log("data: "+data);
                    $("#image-post-modal").modal("hide");
                    $("#alertModel .modal-body").text("Post shared..! :-)");
                    $("#alertModel").modal("show");
                    location.reload(true);
                }else{
                    $("#image-post-modal").modal("hide");
                    $("#alertModel .modal-body").text("Some error occurring while posting please try again..! :-(");
                    $("#alertModel").modal("show");
                }
            }
        })
    });


    // video post

    $('#post-video-form').submit( function(e) {
        e.preventDefault();

        var data = new FormData(this); // <-- 'this' is your form element

        $.ajax({
            url: '/post/video/save',
            data: data,
            cache: false,
            contentType: false,
            processData: false,
            type: 'POST',
            success: function(data){
                if(data){
                    //console.log("data: "+data);
                    $("#video-post-modal").modal("hide");
                    $("#alertModel .modal-body").text("Post shared..! :-)");
                    $("#alertModel").modal("show");
                    location.reload(true);
                }else{
                    $("#video-post-modal").modal("hide");
                    $("#alertModel .modal-body").text("Some error occurring while posting please try again..! :-(");
                    $("#alertModel").modal("show");
                }
            }
        })
    });


    // doc post

    $('#doc-post-form').submit( function(e) {
        e.preventDefault();

        var data = new FormData(this); // <-- 'this' is your form element

        $.ajax({
            url: '/post/document/save',
            data: data,
            cache: false,
            contentType: false,
            processData: false,
            type: 'POST',
            success: function(data){
                if(data){
                    //console.log("data: "+data);
                    $("#doc-post-modal").modal("hide");
                    $("#alertModel .modal-body").text("Post shared..! :-)");
                    $("#alertModel").modal("show");
                    location.reload(true);
                }else{
                    $("#doc-post-modal").modal("hide");
                    $("#alertModel .modal-body").text("Some error occurring while posting please try again..! :-(");
                    $("#alertModel").modal("show");
                }
            }
        })
    });

    $(document).on('click', '#delete', function () {
        var postId = $(".delete-post").attr("id");
        //alert("hello");
        var check = $.ajax({
            url: "/post/delete",
            data: {"id": postId},
            method: "DELETE"
        });
        check.done(function (data) {
            if (data) {
                window.location.reload();
                //console.log("deleted post id: "+postId)
            }
        });
        check.fail(function (jqXHR, textStatus) {
            alert("Something wrong while deleting this post. Please try again..")
            //console.log("Error in fetching emails");
        })
    });
});
