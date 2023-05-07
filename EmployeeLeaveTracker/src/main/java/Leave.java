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
	double numberOfDays;
	int leaveId;
	boolean canBeDeleted;
	boolean canBeEdited;

	public Leave(int leaveId, String signum, String from_date, String to_date, String type, String name, String mode,
			String reason, double numberOfDays) {
		super();
		this.leaveId = leaveId;
		this.from_date = from_date;
		this.to_date = to_date;
		this.type = type;
		this.signum = signum;
		this.name = name;
		this.mode = mode;
		this.reason = reason;
		this.numberOfDays = numberOfDays;
		Date date = new Date();

		int hours = date.getHours();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");

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

			if (today.compareTo(toDate) < 0) {
				this.canBeEdited = true;
			} else {
				this.canBeEdited = false;
			}

		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	public double getNumberOfDays() {
		return numberOfDays;
	}

	public void setNumberOfDays(double numberOfDays) {
		this.numberOfDays = numberOfDays;
	}

	public boolean isCanBeDeleted() {
		return canBeDeleted;
	}

	public void setCanBeDeleted(boolean canBeDeleted) {
		this.canBeDeleted = canBeDeleted;
	}

	public int getLeaveId() {
		return leaveId;
	}

	public void setLeaveId(int leaveId) {
		this.leaveId = leaveId;
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

	public boolean isCanBeEdited() {
		return canBeEdited;
	}

	public void setCanBeEdited(boolean canBeEdited) {
		this.canBeEdited = canBeEdited;
	}
}