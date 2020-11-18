package servlets;

import apps.Database;
import classes.Student;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/join_club_servlet")
public class JoinClubServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        if (request.getParameter("club_action") != null) {
            if (request.getParameter("club_action").equals("join")) {
                String fname = request.getParameter("fname");
                int clubId = Integer.parseInt(request.getParameter("club_id"));
                Student student = Database.getInstance().getStudent(fname);
                if (Database.getInstance().isClubMember(clubId, student.getId())) {
                    response.getWriter().write("False");
                } else {
                    Database.getInstance().addClubMember(clubId, student.getId());
                    response.getWriter().write("True");
                }
            }
            if (request.getParameter("club_action").equals("leave")) {
                String fname = request.getParameter("fname");
                int clubId = Integer.parseInt(request.getParameter("club_id"));
                Student student = Database.getInstance().getStudent(fname);
                if (Database.getInstance().isClubMember(clubId, student.getId())) {
                    Database.getInstance().deleteClubMember(clubId, student.getId());
                    response.getWriter().write("True");
                } else {
                    response.getWriter().write("False");
                }
            }
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
