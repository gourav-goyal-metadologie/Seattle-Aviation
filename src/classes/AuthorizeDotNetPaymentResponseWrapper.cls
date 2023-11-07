public class AuthorizeDotNetPaymentResponseWrapper{    
	public class Messages {
		public String code;
		public String description;
	}

	public class TransactionResponse {
		public String responseCode;
		public String authCode;
		public String avsResultCode;
		public String cvvResultCode;
		public String cavvResultCode;
		public String transId;
		public String refTransID;
		public String transHash;
		public String testRequest;
		public String accountNumber;
		public String accountType;
		public List<Messages> messages;
		public String transHashSha2;
		public Integer SupplementalDataQualificationIndicator;
		public String networkTransId;
	}

	public TransactionResponse transactionResponse;
	public String refId;
	public Messages_Z messages;

	public class Message {
		public String code;
		public String text;
	}

	public class Messages_Z {
		public String resultCode;
		public List<Message> message;
	}
}