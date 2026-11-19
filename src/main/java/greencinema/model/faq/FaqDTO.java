package greencinema.model.faq;

public class FaqDTO {
	private int faqId;
	private int faqType;
	private String faqInquiry;
	private String faqAnswer;
	public int getFaqId() {
		return faqId;
	}
	public void setFaqId(int faqId) {
		this.faqId = faqId;
	}
	public int getFaqType() {
		return faqType;
	}
	public void setFaqType(int faqType) {
		this.faqType = faqType;
	}
	
	public String getFaqInquiry() {
		return faqInquiry;
	}
	public void setFaqInquiry(String faqInquiry) {
		this.faqInquiry = faqInquiry;
	}
	public String getFaqAnswer() {
		return faqAnswer;
	}
	public void setFaqAnswer(String faqAnswer) {
		this.faqAnswer = faqAnswer;
	}


}
