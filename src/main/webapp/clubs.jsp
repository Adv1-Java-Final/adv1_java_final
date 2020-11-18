<%@ page import="apps.Database" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Main page</title>
    <%@include file="theme.jsp"%>
</head>
<body>
<%@include file="header.jsp"%>

<div class="container-fluid">
    <div class="row">
        <div class="col">
            <div id="all_clubs" class="p-2">
                <h1 class="h1 w-25 mx-auto mb-5">Clubs</h1>
                <%boolean isClubModerator = Database.getInstance().isModerator(name, "clubconnection");
                    if (isClubModerator || type.equals("admin")) {%>
                <div class="mb-4 px-5 py-2 bg-dark text-white rounded">
                    <input id="club_id" type="hidden" value="">
                    <div class="form-group">
                        <label for="club_name">Club title</label>
                        <input type="text" class="form-control" id="club_name">
                    </div>
                    <div class="form-group">
                        <label for="club_description">Club description</label>
                        <textarea class="form-control" id="club_description" rows="3" style="resize: none"></textarea>
                    </div>
                    <p id="add_club_feedback" class="d-none alert"></p>
                    <button id="btn_add_club" class="btn btn-info p-2">Add club</button>
                    <button id="btn_edit_club" class="btn btn-info p-2">Update club</button>
                </div>
                <%}%>

                <sql:query var="all_clubs" dataSource="jdbc/project">
                    SELECT * FROM club
                </sql:query>
                <input class="name" type="hidden" value="<%=name%>">
                <c:forEach var="club" items="${all_clubs.rows}">
                    <div class="clubs">
                        <div class="jumbotron p-2">
                            <h1 class="display-4"><c:out value="${club.name}"/></h1>
                            <hr class="my-4">
                            <p><c:out value="${club.description}"/></p>

                            <div class="d-flex justify-content-end mb-2">
                                <%if (!type.equals("admin")) {%>
                                <button class="leave_club btn btn-danger mr-2" data-id="<c:out value="${club.id}"/>">Leave</button>
                                <button class="join_club btn btn-success" data-id="<c:out value="${club.id}"/>">Join</button>
                                <%} if (isClubModerator || type.equals("admin")) {%>
                                <button class="edit_club btn btn-info p-2 ml-2"
                                        data-id="<c:out value="${club.id}"/>">
                                    <i class="far fa-edit"></i></button>
                                <button class="delete_club btn btn-danger p-2 ml-2"
                                        data-id="<c:out value="${club.id}"/>">
                                    <i class="far fa-trash-alt"></i></button>
                                <%}%>
                            </div>

                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>

<script src="js/crud_club.js"></script>
<script>
    $(document).ready(function () {
        $('.join_club').click(function () {
            let club_id = $(this).data('id')
            let fname = $('.name').val()
            $.ajax({
                url: 'join_club_servlet',
                type: 'post',
                data: {club_action: 'join', club_id: club_id, fname: fname},
                success: function (data) {
                    if (data === 'True') {
                        alert('You joined to this club!')
                    } else if (data === 'False') {
                        alert('You already joined this club!')
                    }
                }
            })
        });

        $('.leave_club').click(function () {
            let club_id = $(this).data('id')
            let fname = $('.name').val()
            $.ajax({
                url: 'join_club_servlet',
                type: 'post',
                data: {club_action: 'leave', club_id: club_id, fname: fname},
                success: function (data) {
                    if (data === 'True') {
                        alert('You left this club!')
                    } else if (data === 'False') {
                        alert('You are not member of this club. First join club')
                    }
                }
            })
        });
    })
</script>
</body>
</html>
