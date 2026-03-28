package com.gqt;

import java.io.IOException;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/StartRepayment")
public class StartRepayment extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        SHGModel model = (SHGModel) session.getAttribute("model");
        
        if (model == null) {
            response.sendRedirect("index.html");
            return;
        }
        
        String loanAmountStr = request.getParameter("loanAmount");
        String interestStr = request.getParameter("interest");
        String[] paidMembers = request.getParameterValues("paid");
        String timeTakenStr = request.getParameter("timeTaken");
        
        if (loanAmountStr == null || interestStr == null || 
            loanAmountStr.trim().isEmpty() || interestStr.trim().isEmpty()) {
            request.setAttribute("error", "Please enter loan amount and interest rate");
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }
        
        double loanAmount, interest;
        try {
            loanAmount = Double.parseDouble(loanAmountStr);
            interest = Double.parseDouble(interestStr);
            
            if (loanAmount <= 0 || interest < 0) {
                throw new NumberFormatException();
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid numeric values. Please enter positive numbers.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }
        
        List<String> paid = new ArrayList<>();
        if (paidMembers != null) {
            paid = Arrays.asList(paidMembers);
        }
        
        long timeTaken = 60;
        try {
            timeTaken = Long.parseLong(timeTakenStr);
        } catch (NumberFormatException e) {}
        
        model.calculateLoanDetails(loanAmount, interest);
        model.calculateRepaymentScore(paid, timeTaken);
        session.setAttribute("model", model);
        
        response.sendRedirect("repaymentResult.jsp");
    }
}