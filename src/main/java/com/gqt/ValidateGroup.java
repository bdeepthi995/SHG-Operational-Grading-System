package com.gqt;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/ValidateGroup")
public class ValidateGroup extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String groupIdStr = request.getParameter("groupId");
        String leader = request.getParameter("leader");
        
        if (groupIdStr == null || leader == null || groupIdStr.trim().isEmpty() || leader.trim().isEmpty()) {
            request.setAttribute("error", "Please enter both Group ID and Leader Name");
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }
        
        int groupId;
        try {
            groupId = Integer.parseInt(groupIdStr);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid Group ID format. Please enter a number.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }
        
        SHGModel model = new SHGModel();
        boolean isValid = model.validateGroup(groupId, leader);
        
        if (isValid) {
            HttpSession session = request.getSession(true);
            session.setAttribute("model", model);
            response.sendRedirect("dashboard.jsp");
        } else {
            model.closeResources();
            request.setAttribute("error", "Invalid Group ID or Leader Name. Please try again.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}