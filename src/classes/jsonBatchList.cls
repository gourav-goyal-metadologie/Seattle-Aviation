public class jsonBatchList {
    /*public class Messages {
		public String resultCode{get;set;}
		public List<Message> message{get;set;}
	}*/

	public List<BatchList> batchList{get;set;}
	/*public Messages messages{get;set;}

	public class Message {
		public String code{get;set;}
		public String text{get;set;}
	}*/

	public class BatchList {
        public String batchId{get;set;}
		//public String settlementTimeUTC{get;set;}
		//public String settlementTimeLocal{get;set;}
		public String settlementState{get;set;}
		//public String paymentMethod{get;set;}
		//public String marketType{get;set;}
		//public String product{get;set;}
	}
}