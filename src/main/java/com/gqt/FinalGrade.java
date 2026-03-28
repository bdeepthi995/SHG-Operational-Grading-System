package com.gqt;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/FinalGrade")
public class FinalGrade extends HttpServlet {
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        SHGModel model = (SHGModel) session.getAttribute("model");
        
        if (model == null) {
            response.sendRedirect("index.html");
            return;
        }
        
        if (model.getMeetingScore() == 0 || model.getRepaymentScore() == 0) {
            request.setAttribute("error", "Please complete both Meeting and Repayment evaluations first");
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }
        
        model.calculateFinalGrade();
        session.setAttribute("model", model);
        
        response.sendRedirect("finalResult.jsp");
    }
}