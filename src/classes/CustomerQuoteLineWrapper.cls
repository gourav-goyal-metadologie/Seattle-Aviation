global class CustomerQuoteLineWrapper implements Comparable {

    public inscor__Customer_Quote_Line__c customerQuotesLine;
    
    // Constructor
    public CustomerQuoteLineWrapper(inscor__Customer_Quote_Line__c op) {
        customerQuotesLine = op;
    }
    
    // Compare opportunities based on the opportunity inscor__Quantity__c.
    global Integer compareTo(Object compareTo) {
        // Cast argument to OpportunityWrapper
        CustomerQuoteLineWrapper compareToOppy = (CustomerQuoteLineWrapper)compareTo;
        
        // The return value of 0 indicates that both elements are equal.
        Integer returnValue = 0;
        if (customerQuotesLine.inscor__Quantity__c > compareToOppy.customerQuotesLine.inscor__Quantity__c) {
            // Set return value to a positive value.
            returnValue = 1;
        } else if (customerQuotesLine.inscor__Quantity__c < compareToOppy.customerQuotesLine.inscor__Quantity__c) {
            // Set return value to a negative value.
            returnValue = -1;
        } else if ((customerQuotesLine.inscor__Quantity__c == null) && (compareToOppy.customerQuotesLine.inscor__Quantity__c != null)){
            // nulls-first implementation
            returnValue = -1;
        } else if ((customerQuotesLine.inscor__Quantity__c != null) && (compareToOppy.customerQuotesLine.inscor__Quantity__c == null)){
            // nulls-first implementation
            returnValue = 1;
        }        
        return returnValue;       
    }
}