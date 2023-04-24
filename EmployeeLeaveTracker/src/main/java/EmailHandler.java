
import java.util.Properties;

public class EmailHandler {
	public static void sendLeaveEmail(Leave leave) {

		Properties props = new Properties();

		props.setProperty("mail.smtp.auth", "true");
		props.setProperty("mail.smtp.starttls.enable", "true");
		props.setProperty("mail.smtp.host", "smtp.gmail.com");

	}

}
