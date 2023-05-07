
public class DBResponse {
	private String message;
	private String code;
	/* code used are 
	 * [dates-overlap]
	 * [leave-added]
	 * 
	 * */
	public DBResponse(String message, String code) {
		super();
		this.message = message;
		this.code = code;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	

}
