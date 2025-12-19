package SHGGradingSystem;

import java.util.Scanner;

public class SHGMain {

    public static void main(String[] args) throws Exception {

        Scanner sc = new Scanner(System.in);
        SHGService service = new SHGService();

        System.out.println("=== SHG GRADING SYSTEM ===");

        while (true) {
            System.out.println("\n1. Start Meeting");
            System.out.println("2. Loan Repayment");
            System.out.println("3. View Final Grade");
            System.out.println("4. Exit");
            System.out.print("Enter choice: ");

            int choice = sc.nextInt();
            //sc.nextLine(); // consume newline

            switch (choice) {
                case 1:
                    service.startMeeting();
                    break;
                case 2:
                    service.startRepayment();
                    break;
                case 3:
                    service.showFinalGrade();
                    break;
                case 4:
                    System.out.println("Thank you!");
                    System.exit(0);
                default:
                    System.out.println("Invalid choice");
            }
        }
    }
}
