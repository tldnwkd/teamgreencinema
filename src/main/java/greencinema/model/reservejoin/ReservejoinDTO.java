package greencinema.model.reservejoin;

import java.sql.Date;

public class ReservejoinDTO {
	private int reserveId;
	private String userId;
	private int adultCount;
	private int teensCount;
	private int totalPrice;
	private Date reserveDate;
	private Date cancelDate;
}
