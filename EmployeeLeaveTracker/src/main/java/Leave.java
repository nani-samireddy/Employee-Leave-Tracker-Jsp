import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Leave {
	String from_date;
	String to_date;
	String type;
	String signum;
	String name;
	String mode;
	String reason;
	int leaveId;
	public int getLeaveId() {
		return leaveId;
	}

	public void setLeaveId(int leaveId) {
		this.leaveId = leaveId;
	}

	boolean canBeDeleted;

	public boolean isCanBeDeleted() {
		return canBeDeleted;
	}

	public void setCanBeDeleted(boolean canBeDeleted) {
		this.canBeDeleted = canBeDeleted;
	}

	public Leave(int leaveId, String signum, String from_date, String to_date, String type, String name, String mode,
			String reason) {
		super();
		this.leaveId = leaveId;
		this.from_date = from_date;
		this.to_date = to_date;
		this.type = type;
		this.signum = signum;
		this.name = name;
		this.mode = mode;
		this.reason = reason;
		Date date = new Date();

		int hours = date.getHours();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");

		System.out.print(to_date);
		try {
			String todayStr = formatter.format(date);
			Date today = formatter.parse(todayStr);
			Date toDate = formatter.parse(to_date);
			Date fromDate = formatter.parse(from_date);

			if (today.compareTo(fromDate) > 0) {
				this.canBeDeleted = false;
			} else if (today.compareTo(fromDate) == 0) {
				if (hours <= 11) {
					this.canBeDeleted = true;
				} else {
					this.canBeDeleted = false;
				}

			} else {
				this.canBeDeleted = true;
			}

		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public String getMode() {
		return mode;
	}

	public void setMode(String mode) {
		this.mode = mode;
	}

	public String getFrom_date() {
		return from_date;
	}

	public void setFrom_date(String from_date) {
		this.from_date = from_date;
	}

	public String getTo_date() {
		return to_date;
	}

	public void setTo_date(String to_date) {
		this.to_date = to_date;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getSignum() {
		return signum;
	}

	public void setSignum(String signum) {
		this.signum = signum;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

}