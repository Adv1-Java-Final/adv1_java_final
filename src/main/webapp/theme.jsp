<%
    String light = "selected";
    String dark = "";
    Cookie[] cookies = request.getCookies();
    for (Cookie cookie: cookies) {
        if (cookie.getName().equals("theme") && cookie.getValue().equals("dark")) {
            dark = "selected";
            light = "";
            out.println("<link rel='stylesheet' href='css/dark_theme.css'>");
        } else if (cookie.getName().equals("theme") && cookie.getValue().equals("light")){
            out.println("<link rel='stylesheet' href='css/light_theme.css'>");
        }
    }
%>
