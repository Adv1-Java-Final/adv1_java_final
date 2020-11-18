<%  String name = (String) session.getAttribute("name");
    String type = (String) session.getAttribute("type");
    if (session.getAttribute("name") == null) { %>
        <c:redirect url="login.jsp"/>
<%}%>

<nav class="navbar navbar-expand-md navbar-dark bg-dark">
    <a class="navbar-brand" href="#">Astana IT University</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarCollapse">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item">
                <select class="nav-item browser-default custom-select" id="theme_select">
                    <option value="light">Light</option>
                    <option value="dark">Dark</option>
                </select>
            </li>
            <li class="nav-item active">
                <a href="main_page.jsp" class="nav-link">News</a>
            </li>
            <li class="nav-item">
                <a href="clubs.jsp" class="nav-link">Clubs</a>
            </li>
            <li class="nav-item">
                <a href="events.jsp" class="nav-link">Events</a>
            </li>
            <%if (type.equals("admin")) { %>
                <li class="nav-item">
                    <a href="students.jsp" class="nav-link">Students</a>
                </li>
                <li class="nav-item">
                    <a href="add_student.jsp" class="nav-link">Add students</a>
                </li>
            <%}%>
        </ul>
        <div class="dropdown">
            <button class="btn btn-outline-success dropdown-toggle" style="width: 150px;" type="button"
                    id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <%out.println(name);%>
            </button>
            <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                <button class="dropdown-item" id="btn_logout">Log out</button>
            </div>
        </div>
    </div>
</nav>

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"
        integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"
        integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.min.js"
        integrity="sha384-w1Q4orYjBQndcko6MimVbzY0tgp4pWB4lZ7lr30WKz0vr/aWKhXdBNmNb5D92v7s"
        crossorigin="anonymous"></script>
<script src="https://kit.fontawesome.com/bf20fcd267.js" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-cookie/1.4.1/jquery.cookie.min.js"
        integrity="sha256-1A78rJEdiWTzco6qdn3igTBv9VupN3Q1ozZNTR4WE/Y=" crossorigin="anonymous"></script>
<script>
    $(document).ready(function () {
        $('#btn_logout').click(function () {
            $.ajax({
                url: 'login_servlet',
                type: 'post',
                data: {action: 'logout'},
                success: function (data) {
                    if (data === 'True') {
                        location.href = 'login.jsp'
                    }
                }
            })
        });

        $('#theme_select').on('change', function() {
            event.preventDefault();
            if ($( "#theme_select" ).val() === "dark") {
                $('link[href="css/light_theme.css"]').attr('href','css/dark_theme.css');
                $.cookie("theme", "dark", { expires : 10 });
            } else {
                $('link[href="css/dark_theme.css"]').attr('href','css/light_theme.css');
                $.cookie("theme", "light", { expires : 10 });
            }
        });
    })
</script>