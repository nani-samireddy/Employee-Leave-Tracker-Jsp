import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;

public class OutlookEmailSender {
    public static void sendEmail(String recprecipients,String subject, String body) {
        
        
        
        
        // Outlook SMTP server settings
        String host = "smtp.office365.com";
        String port = "587";
        
        // Email properties
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", port);
        
        String senderEmail = "leavetracking@outlook.com";
        String senderPassword = "Chitti2001";

        // Create a session with authentication
        Session session = Session.getInstance(props, new Authenticator() {
        	// Sender's email credentials
            String senderEmail = "leavetracking@outlook.com";
            String senderPassword = "Chitti2001";
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(senderEmail, senderPassword);
            }
        });

        try {
            // Create a MimeMessage object
            Message message = new MimeMessage(session);
            
            // Set the sender and recipient addresses
            message.setFrom(new InternetAddress(senderEmail));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recprecipients));
            
            // Set the email subject and content
            message.setSubject(subject);
            message.setText(body);

            // Send the email
            Transport.send(message);

            System.out.println("Email sent successfully!");

        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
}
