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
            <div id="all_events" class="p-2">
                <h1 class="h1 w-25 mx-auto mb-5">Events</h1>
                <%boolean isEventModerator = Database.getInstance().isModerator(name, "eventconnection");
                    if (isEventModerator || type.equals("admin")) {%>
                <div class="mb-4 px-5 py-2 bg-dark text-white rounded">
                    <input id="event_id" type="hidden" value="">
                    <div class="form-group">
                        <label for="event_name">Event title</label>
                        <input type="text" class="form-control" id="event_name">
                    </div>
                    <div class="form-group">
                        <label for="event_description">Event body</label>
                        <textarea class="form-control" id="event_description" rows="3" style="resize: none"></textarea>
                    </div>
                    <p id="add_event_feedback" class="d-none alert"></p>
                    <button id="btn_add_event" class="btn btn-info p-2">Add event</button>
                    <button id="btn_edit_event" class="btn btn-info p-2">Update event</button>
                </div>
                <%}%>
                <p id="event_delete_feedback" class="d-none alert alert-success"></p>

                <sql:query var="all_events" dataSource="jdbc/project">
                    SELECT * FROM event
                </sql:query>
                <c:forEach var="event" items="${all_events.rows}">
                    <div class="events">
                        <div class="jumbotron p-2">
                            <h1 class="display-4"><c:out value="${event.name}"/></h1>
                            <hr class="my-4">
                            <p><c:out value="${event.description}"/></p>
                            <%if (isEventModerator || type.equals("admin")) {%>
                            <div class="d-flex justify-content-end mb-2">
                                <button class="edit_event btn btn-info p-2 ml-2"
                                        data-id="<c:out value="${event.id}"/>">
                                    <i class="far fa-edit"></i></button>
                                <button class="delete_event btn btn-danger p-2 ml-2"
                                        data-id="<c:out value="${event.id}"/>">
                                    <i class="far fa-trash-alt"></i></button>
                            </div>
                            <%}%>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>

<script src="js/crud_event.js"></script>
</body>
</html>
