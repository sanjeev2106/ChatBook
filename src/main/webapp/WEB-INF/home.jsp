<%@ page import="com.bciit.project.ChatBook.entities.User" %>
<%@ page import="com.bciit.project.ChatBook.enums.Visibility" %>
<%@ page import="com.bciit.project.ChatBook.entities.Post" %>
<%@ page import="java.util.List" %>
<%@ page import="com.bciit.project.ChatBook.enums.PostType" %>
<%
    User user = (User) session.getAttribute("user");

%>

<%@ include file="header.jsp" %>
<%------------------------------------------%>

<%--<h2 style="text-align: center">Welcome <%=user.getFirstName()+" "+user.getLastName()%></h2>--%>


<div class="container">
    <div class="row">
        <div class="col-lg-3 nopadding" style="border: 2px solid ghostwhite; height: 100px;">

            <div style="background-color: #016b90; height: 100px;">
                <div class="dropdown">
                    <div class="dropbtn"><i class="material-icons">more_vert</i></div>
                    <div class="dropdown-content">
                        <%
                            if (user.getAdmin()) {
                        %>
                        <div class="col-lg-12">
                            <div class="col-lg-8 menu-option">Manage users</div>
                            <div class="col-lg-4 menu-option"><i class="material-icons">mode_edit</i></div>
                        </div>
                        <div class="col-lg-12">
                            <div class="col-lg-8 menu-option">Manage posts</div>
                            <div class="col-lg-4 menu-option"><i class="material-icons">pageview</i></div>
                        </div>
                        <%
                        } else {
                        %>
                        <div class="col-lg-12">
                            <div class="col-lg-8 menu-option">Edit</div>
                            <div class="col-lg-4 menu-option"><i class="material-icons">mode_edit</i></div>
                        </div>
                        <div class="col-lg-12">
                            <div class="col-lg-8 menu-option">View</div>
                            <div class="col-lg-4 menu-option"><i class="material-icons">pageview</i></div>
                        </div>
                        <div class="col-lg-12">
                            <div class="col-lg-8 menu-option">Visibility</div>
                            <div class="col-lg-4 menu-option"><i class="material-icons">remove_red_eye</i></div>
                        </div>
                        <div class="col-lg-12">
                            <div class="menu-option">Change password</div>
                        </div>

                        <%
                            }
                        %>
                        <%-- <a class="btn" href="#"><span>Edit</span><span><i class="material-icons">mode_edit</i></span></a>
                            <a class="btn" href="#"><span>View</span><span><i class="material-icons">pageview</i></span></a>
                            <a class="btn" href="#"><span>Visibility</span><span><i class="material-icons">remove_red_eye</i></span></a>
                  --%>      </div>
                </div>

            </div>
            <div style="margin-top: -50px; text-align: center">
                <img src="<%=user.getPhoto()%>" class="rounded-circle"
                     style="height: 100px; width: 100px; border: 2px solid white;"/>

                <div class="col-lg-12">
                    <div class="col-lg-12" style=""><h4><%=user.getFullName()%>
                    </h4></div>
                    <div class="col-lg-12"><%=user.getSession()%>
                    </div>
                </div>

                <div class="col-lg-12" style="padding: 20px; background-color: ghostwhite">
                    <div class="col-lg-6" style="color: #016b90"><h5>Followers</h5></div>
                    <div class="col-lg-6" style="color: #016b90"><h5>Follows</h5></div>
                    <div class="col-lg-6"><%=(int)session.getAttribute("follows")%></div>
                    <div class="col-lg-6"><%=(int)session.getAttribute("followers")%></div>
                </div>
            </div>
        </div>

        <div class="col-lg-6">
            <div class="post col-lg-12 nopadding" style="border: 2px solid ghostwhite;">

                <div class="col-lg-6" style="tab-size: 25px; color: #016b90; padding: 6px; cursor: pointer"
                     title="write a post" id="text" data-toggle="modal"
                     data-target="#text-post-modal">
                    <span class="fa fa-edit post-icon"></span>
                    <span style="font-family: 'Courier New'; font-size: 20px;">Write a post</span>
                </div>
                <div class="col-lg-6 " style="background-color: ghostwhite; padding: 6px;">
                    <div class="col-lg-4"><i class="fa fa-file-movie-o post-icon" title="share video" id="video"
                                             data-toggle="modal"
                                             data-target="#video-post-modal"></i></div>
                    <div class="col-lg-4"><i class="fa fa-file-image-o post-icon" title="share image" id="image"
                                             data-toggle="modal"
                                             data-target="#image-post-modal"></i></div>
                    <div class="col-lg-4"><i class="fa fa-file-pdf-o post-icon" title="share document" id="document"
                                             data-toggle="modal"
                                             data-target="#doc-post-modal"></i>
                    </div>
                </div>
            </div>
            <%
            try{
                List<Post> posts = (List<Post>) session.getAttribute("posts");
                System.out.println("posts---> "+posts);
                for(Post post : posts){
                    if(post.getShareBy().getId().equals(user.getId()) || post.getVisibility() == Visibility.PUBLIC){
            %>
                <div class="col-lg-12 nopadding" style="border: 2px solid ghostwhite; padding: 6px;">
                    <div class="post-user col-lg-12" style="padding: 10px; background-color: #2471A3; color: #FBFCFC">
                        <div class="col-lg-1"><img src="<%=post.getShareBy().getPhoto()%>" STYLE="width: 35px; height: 35px" class="rounded-circle"/>  </div>
                        <div class="col-lg-10">
                            <span><%=post.getShareBy().getFullName()%></span><br>
                            <span><%=post.getShareBy().getSession()%></span>
                        </div>
                        <div class="col-lg-1">
                            <!--<i class="fa fa-bars" aria-hidden="true"></i>-->

                            <% if(post.getShareBy().getId().equals(user.getId()) || user.getAdmin() ){%>
                                <button id="delete" name="delete" style="background: none; border: none">
                                    <i class="fa fa-trash delete-post" id="<%=post.getId()%>" aria-hidden="true"></i></button>
                            <%}%>
                        </div>
                    </div>
                    <div class="post-body">
                        <% if(post.getDescription()!=null && !post.getDescription().isEmpty() && PostType.ARTICLE!=post.getType()){%>
                        <div style="padding: 70px 10px 10px; font-family: monospace" ><%=post.getDescription()%></div>
                        <%}%>
                        <div style="padding: 10px;">
                        <%if(post.getType()== PostType.ARTICLE){%>
                        <span style="width: 100%; height: 100%; "><%=post.getDescription()%></span>
                        <%}if(post.getType()==PostType.IMAGE){%>
                        <img src="<%=post.getAttachment()%>" style="width: 100%; height: 300px;" />
                        <%}if(post.getType()==PostType.VIDEO){%>
                            <VIDEO controls style="width: 100%; height: 100%;">
                                <source src="<%=post.getAttachment()%>">
                            </VIDEO>
                        <%}if(post.getType()==PostType.DOCUMENT){%>
                        <embed src="<%=post.getAttachment()%>" type="application/pdf"   height="300px" width="100%">
                        <%}%>
                        </div>
                    </div>
                    <div class="post-likes" style="padding: 10px;"></div>
                </div>
            <%
                }
                }
            }catch (Exception ignored){};

            %>



        </div>
        <div class="col-lg-3">
            <div class="col-lg-12" style="background-color: #016b90; padding: 5px 16px">
                <div class="col-lg-8 nopadding"><input type="text" name="search-user" id="search-user"/></div>
                <div class="col-lg-3 nopadding"><button>Search</button></div>
            </div>
            <%List<User> users = (List<User>) session.getAttribute("followerList");
                if(!users.isEmpty()){
                    for (User u : users){
            %>
            <div class="col-lg-12 nopadding" style="border: 2px solid #016b90;">

                <div class="col-lg-2"><img src="<%=u.getPhoto()%>" STYLE="width: 35px; height: 35px" class="rounded-circle"/>  </div>
                <div class="col-lg-7">
                    <span><%=u.getFirstName()%></span><br>
                    <span><%=u.getSession()%></span>
                </div>
                <div class="col-lg-2 nopadding"><a href="/follows/<%=u.getId()%>" class="btn-info" style="padding: 3px; display: inline-block; margin-top: 4px;">Follow</a> </div>

            </div>
            <%}
            }%>
        </div>
    </div>
</div>

<%----------------------modals----------------------------%>

<%--text post model--%>
<div class="modal fade" id="text-post-modal" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header" style="background-color: #02a5de">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="form-group" style="overflow: hidden">
                    <label for="text-visibility"></label>
                    <select id="text-visibility" name="text-visibility" class="form-control col-lg-4">
                        <option value="<%=Visibility.ME%>">Only me</option>
                        <option value="<%=Visibility.FOLLOWS%>">I follows</option>
                        <option value="<%=Visibility.PUBLIC%>">Anyone</option>
                    </select>
                </div>
                <%--<div class="form-group ">--%>
                <%--<label for="text-post-title" class="required">Title(optional):</label>--%>
                <%--<input type="text" class="form-control" id="text-post-title" name="text-post-title"--%>
                <%--placeholder="post title" />--%>
                <%--</div>--%>
                <div class="form-group ">
                        <textarea type="text" rows="5" class="form-control" id="text-post" name="text-post"
                                  placeholder="share your thoughts.." required></textarea>
                </div>
                <button class="btn btn-primary" id="btn-text-post">Post</button>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>


<%--image post model--%>
<div class="modal fade" id="image-post-modal" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header" style="background-color: #02a5de">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form name="image-post-form" id="image-post-form" method="">
                <div class="modal-body">
                    <div class="form-group" style="overflow: hidden">
                        <label for="image-visibility"></label>
                        <select id="image-visibility" name="image-visibility" class="form-control col-lg-4">
                            <option value="<%=Visibility.ME%>">Only me</option>
                            <option value="<%=Visibility.FOLLOWS%>">I follows</option>
                            <option value="<%=Visibility.PUBLIC%>">Anyone</option>
                        </select>
                    </div>

                    <div class="form-group ">
                        <textarea type="text" class="form-control" id="image-post" name="image-post"
                                  placeholder="describe about this post if you wanna.."></textarea>
                    </div>

                    <div class="form-group">
                        <input type="file" name="image-file" accept="image/*" id="image-file" class="input-group"/>
                    </div>

                    <div class="form-group" style="overflow: hidden; " id="div-display-image">
                        <img src="" class="form-control" id="display-image" style="height: 100%;"/>
                    </div>

                    <button type="submit" class="btn btn-primary" id="btn-image-post">Post</button>

                </div>
            </form>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            </div>

        </div>
    </div>
</div>

<%--video post model--%>
<div class="modal fade" id="video-post-modal" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header" style="background-color: #02a5de">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form name="post-video-form" id="post-video-form" method="">
                <div class="modal-body">
                    <div class="form-group" style="overflow: hidden">
                        <label for="video-visibility"></label>
                        <select id="video-visibility" name="video-visibility" class="form-control col-lg-4">
                            <option value="<%=Visibility.ME%>">Only me</option>
                            <option value="<%=Visibility.FOLLOWS%>">I follows</option>
                            <option value="<%=Visibility.PUBLIC%>">Anyone</option>
                        </select>
                    </div>

                    <div class="form-group ">
                        <textarea type="text" class="form-control" id="video-post" name="video-post"
                                  placeholder="describe about this post if you wanna.." ></textarea>
                    </div>

                    <div class="form-group">
                        <input type="file" name="video-file" accept="video/*" id="video-file" class="input-group"/>
                    </div>

                    <div class="form-group" style="overflow: hidden; " id="div-display-video">
                        <video src="" class="form-control" id="display-video" style="height: 100%;"></video>
                    </div>

                    <button type="submit" class="btn btn-primary" id="btn-video-post">Post</button>

                </div>
            </form>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            </div>

        </div>
    </div>
</div>

<%--doc post model--%>
<div class="modal fade" id="doc-post-modal" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header" style="background-color: #02a5de">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form name="doc-post-form" id="doc-post-form">
            <div class="modal-body">
                <div class="form-group" style="overflow: hidden">
                    <label for="doc-visibility"></label>
                    <select id="doc-visibility" name="doc-visibility" class="form-control col-lg-4">
                        <option value="<%=Visibility.ME%>">Only me</option>
                        <option value="<%=Visibility.FOLLOWS%>">I follows</option>
                        <option value="<%=Visibility.PUBLIC%>">Anyone</option>
                    </select>
                </div>

                <div class="form-group ">
                        <textarea type="text" class="form-control" id="doc-post" name="doc-post"
                                  placeholder="describe about this post if you wanna.." ></textarea>
                </div>

                <div class="form-group">
                    <input type="file" name="doc-file" accept=
                            "application/msword, application/vnd.ms-excel, application/vnd.ms-powerpoint,
                                text/plain, application/pdf" id="doc-file" class="input-group"/>
                </div>

                <div class="form-group" style="overflow: hidden; " id="div-display-doc">
                    <object data="" class="form-control" id="display-doc" style="height: 100%;"></object>
                </div>

                <button type="submit" class="btn btn-primary" id="btn-doc-post">Post</button>

            </div>
            </form>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            </div>

        </div>
    </div>
</div>

<%--------------------------------------------%>
<%@ include file="footer.jsp" %>