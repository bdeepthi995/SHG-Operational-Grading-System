package com.gqt;

import java.io.IOException;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/StartMeeting")
public class StartMeeting extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        SHGModel model = (SHGModel) session.getAttribute("model");
        
        if (model == null) {
            response.sendRedirect("index.html");
            return;
        }
        
        String[] attendedMembers = request.getParameterValues("attended");
        String timeTakenStr = request.getParameter("timeTaken");
        
        List<String> attended = new ArrayList<>();
        if (attendedMembers != null) {
            attended = Arrays.asList(attendedMembers);
        }
        
        long timeTaken = 60;
        try {
            timeTaken = Long.parseLong(timeTakenStr);
        } catch (NumberFormatException e) {}
        
        model.calculateMeetingScore(attended, timeTaken);
        session.setAttribute("model", model);
        
        response.sendRedirect("meetingResult.jsp");
    }
}
