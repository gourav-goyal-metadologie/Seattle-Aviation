public class ComplianceRequestHelper {
    

    public static String createRequestXMLToSendShipment(inscor__Release__c release, 
                                                        inscor__Sales_Order__c salesOrder,
                                                        Account customer)
    {
        
        Contact con;
        if(customer.Contacts.size() > 0){
            con = customer.Contacts[0];
        }
        
        String termsofSaleCode = release.inscor__Account_Terms__c != null ? String.valueOf(release.inscor__Account_Terms__c).substring(0,8) : '';
        String destCountry;
        String destState;
        if(release.inscor__Ship_To_Address__c != null){
            destCountry = release.inscor__Ship_To_Address__r.inscor__Country__c;
            destState = release.inscor__Ship_To_Address__r.inscor__State__c;
        }else if(release.inscor__Dropship_Site__c != null){
            destCountry = release.inscor__Dropship_Site__r.inscor__Country__c;
            destState = release.inscor__Dropship_Site__r.inscor__State__c;
        }
        
        destCountry = CountryStateUtility.getCountryCode(destCountry);
        destState = CountryStateUtility.getStateCode(destState);
        
        Compliance_Configuration__c config = Compliance_Configuration__c.getOrgDefaults(); 
        
        String customerXML = '<TPID>'+customer.Id+'</TPID>'+
                              '<TPName>'+ComplianceUtility.getStringValue(customer.Name)+'</TPName>'+
                              '<TPAddress>'+ComplianceUtility.getStringValue(customer.ShippingStreet)+'</TPAddress>'+
                              '<TPCity>'+ComplianceUtility.getStringValue(customer.ShippingCity)+'</TPCity>'+
                              '<TPZipPostCode>'+ComplianceUtility.getStringValue(customer.ShippingPostalCode)+'</TPZipPostCode>'+
                              '<TPState>'+ComplianceUtility.getStringValue(customer.ShippingState)+'</TPState>'+
                              '<TPCountry>'+ComplianceUtility.getStringValue( destCountry )+'</TPCountry>'+
                              '<TPTelephone>'+ComplianceUtility.formatAccountContactPhone(customer.Phone)+'</TPTelephone>';
                                
        if(release.inscor__Dropship_Site__c != null){
            customerXML = '<TPID>'+customer.Id+'</TPID>'+
                              '<TPName>'+ComplianceUtility.getStringValue(customer.Name)+'</TPName>'+
                              '<TPAddress>'+ComplianceUtility.getStringValue(release.inscor__Dropship_Site__r.inscor__Street__c)+'</TPAddress>'+
                              '<TPCity>'+ComplianceUtility.getStringValue(release.inscor__Dropship_Site__r.inscor__City__c)+'</TPCity>'+
                              '<TPZipPostCode>'+ComplianceUtility.getStringValue(release.inscor__Dropship_Site__r.inscor__Postal_Code__c)+'</TPZipPostCode>'+
                              '<TPState>'+ComplianceUtility.getStringValue(release.inscor__Dropship_Site__r.inscor__State__c)+'</TPState>'+
                              '<TPCountry>'+ComplianceUtility.getStringValue( destCountry )+'</TPCountry>'+
                              '<TPTelephone>'+ComplianceUtility.formatAccountContactPhone(customer.Phone)+'</TPTelephone>';
                                
       
        
        }
        
            if(con != null){
                customerXML += '<ContactName>'+ComplianceUtility.getStringValue(con.Name)+'</ContactName>'+
                                '<ContactTitle>'+ComplianceUtility.getStringValue(con.Title)+'</ContactTitle>'+
                                '<ContactPhone>'+ComplianceUtility.formatAccountContactPhone(con.Phone)+'</ContactPhone>'+
                                '<ContactEmail>'+ComplianceUtility.getStringValue(con.Email)+'</ContactEmail>';
            }
        
        String requestXML = '<![CDATA[';
        
        requestXML += '<?xml version="1.0" encoding="UTF-8"?>'+
                       '<Shipment xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://edm.visualcompliance.com/edwinimport/xml/VD-EDM%20Shipment%20V2.1.xsd">'+
                           '<EIMReferenceID>'+release.Name+'</EIMReferenceID>'+
                           '<EIMType>'+ config.EIMType__c +'</EIMType>'+
                           '<SubmissionEnvironment>'+config.SubmissionEnvironment__c+'</SubmissionEnvironment>'+
                           '<ShipmentRefNo>'+release.Name+'</ShipmentRefNo>'+
                           '<ClientShipmentReference>'+release.Name+'</ClientShipmentReference>'+
                           '<Exporter>'+
                              '<TPID>'+ config.Exporter_TPID__c +'</TPID>'+
                              '<TPName>'+ config.Exporter_TPName__c +'</TPName>'+
                           '</Exporter>'+
                           '<Shipfrom>'+
                              '<TPID>'+ config.ShipFrom_TPID__c +'</TPID>'+
                              '<TPName>'+ config.ShipFrom_TPName__c +'</TPName>'+
                           '</Shipfrom>'+
                    '<ModeofTransport>'+  config.Mode_of_Transport_Code__c +'</ModeofTransport>' +
                           '<IsContainer />'+
                           '<OriginCountry>'+ config.OriginCountry__c +'</OriginCountry>'+
                           '<OriginState>'+ config.OriginState__c +'</OriginState>'+
                           '<ShipDateTime>'+ComplianceUtility.formatDate(Date.today())+'</ShipDateTime>'+
                           '<PortofExit>'+ config.PortofExit__c +'</PortofExit>'+
                           '<DestCountry>'+destCountry+'</DestCountry>'+
                           '<DestState>'+destState+'</DestState>'+
                           '<SignedBy>'+config.Singed_by__c+'</SignedBy>'+
                           '<ReasonForExport>'+ config.ReasonForExport__c +'</ReasonForExport>'+
                           '<RoutedTransaction />'+
                           '<IsHazmat />'+
                           '<FTZ />'+
                           '<PortofUnloading />'+
                     '<PlaceOfLoading>'+config.Place_of_Loading__c+'</PlaceOfLoading>'+
                           '<ImporterOfRecord>'+customerXML+'</ImporterOfRecord>'+
                           '<ShipmentConsignee>'+customerXML+'</ShipmentConsignee>'+
                           '<PartiesRelated />'+
                           '<ShipmentInvoiceNumber>'+release.Name+'</ShipmentInvoiceNumber>'+
                           '<ShipmentInvoiceDate>'+ComplianceUtility.formatDate(Date.today())+'</ShipmentInvoiceDate>'+
                           '<ShipmentPONumber>'+ComplianceUtility.getStringValue(salesOrder.inscor__Customer_PO_Number__c)+'</ShipmentPONumber>'+
                           '<ShipmentPODate>'+ComplianceUtility.formatDate(salesOrder.createdDate)+'</ShipmentPODate>'+
                           '<ShipmentCurrency>'+ config.ShipmentCurrency__c +'</ShipmentCurrency>'+
                           '<TermsofSale>'+
                              '<TermsofSaleCode>'+termsofSaleCode+'</TermsofSaleCode>'+
                              '<TermsofSaleDesc>'+ComplianceUtility.getStringValue(release.inscor__Account_Terms__r.Name)+'</TermsofSaleDesc>'+
                           '</TermsofSale>'+
                           '<IncoTerms>'+ComplianceUtility.getStringValue(release.inscor__Incoterms__c)+'</IncoTerms>'+
                           '<FreightCharges>'+
                              '<FreightChargesFor>'+ config.FreightChargesFor__c +'</FreightChargesFor>'+
                              '<FreightPrepaidCollect>'+ config.FreightPrepaidCollect__c +'</FreightPrepaidCollect>'+
                           '</FreightCharges>'+
                      '<Conveyance>'+ComplianceUtility.getStringValue( ComplianceUtility.removeTrademarkSpecialChar( release.inscor__Ship_Method__r.Name ) )+'</Conveyance>'+
                           '<ShipmentDetails>';
                                    Integer counter = 1;
                                    for( inscor__Release_Line__c reLI: release.inscor__Release_Lines__r ){
                                            requestXML += '<DetailLine>'+
                                                '<LineNumber>'+counter+'</LineNumber>'+
                                                '<PartNo>'+ComplianceUtility.getStringValue(reLI.inscor__Sales_Order_Line__r.inscor__Product__r.Name)+'</PartNo>'+
                                                '<ShortDescription>'+ComplianceUtility.getStringValue(reLI.inscor__Sales_Order_Line__r.inscor__Keyword__c)+'</ShortDescription>'+
                                                '<LineQuantity>'+ComplianceUtility.getDecimalValue(reLI.inscor__Quantity__c)+'</LineQuantity>'+
                                                '<LineQuantityUnit>'+ config.LineQuantityUnit__c +'</LineQuantityUnit>'+
                                                '<LineUnitCost>'+ComplianceUtility.getDecimalValue(reLI.inscor__Sales_Order_Line__r.inscor__Price__c)+'</LineUnitCost>'+
                                                '<LineCurrency>'+config.Shipment_Line_Unit_Price_Currency__c+'</LineCurrency>'+
                                                '<LineValue>'+ComplianceUtility.getDecimalValue(reLI.inscor__Line_Value__c)+'</LineValue>'+
                                                '<LineIsHazmat>'+reLI.inscor__Sales_Order_Line__r.inscor__Product__r.inscor__HazMat__c+'</LineIsHazmat>'+
                                                '<HazmatUNNo>'+ComplianceUtility.getStringValue(reLI.inscor__Sales_Order_Line__r.inscor__Product__r.inscor__HazMat_Id__c)+'</HazmatUNNo>'+
                                                '<DFMCode>'+config.DFM_Code__c+'</DFMCode>'+
                                                '<CountryOriginCode>'+ComplianceUtility.getStringValue(reLI.inscor__Sales_Order_Line__r.inscor__Product__r.inscor__Country_of_Origin__c)+'</CountryOriginCode>'+
                                                '<HSCode>'+ComplianceUtility.getStringValue( ComplianceUtility.removeDotSpecialChar(reLI.inscor__Sales_Order_Line__r.inscor__Product__r.inscor__HTS_Code__c) )+'</HSCode>'+
                                                '<ECCN>'+ComplianceUtility.getStringValue(reLI.inscor__Sales_Order_Line__r.inscor__Product__r.inscor__ECCN__r.Name)+'</ECCN>'+
                                                '<LongDescription>'+ComplianceUtility.getStringValue(reLI.inscor__Sales_Order_Line__r.inscor__Product__r.Description)+'</LongDescription>'+
                                                '<HSQty1>'+ComplianceUtility.getDecimalValue(reLI.inscor__Quantity__c)+'</HSQty1>'+
                                                '<HSUnit1>'+config.LineQuantityUnit__c+'</HSUnit1>'+
                                                '</DetailLine>';
                                            counter++;
                                    }
                              
            requestXML+= '</ShipmentDetails>'+
                        '</Shipment>';
        requestXML += ']]>';
        return requestXML;
        
    }
    
    public static String createRequestXMLToSendItem(Product2 productObj){
        
        String requestXML = '<![CDATA[';
        
        requestXML += '<?xml version="1.0" encoding="utf-8"?>'+
                            '<Items xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://edm.visualcompliance.com/edwinimport/xml/VD-EDM%20Item%20V2.1.xsd">'+
                                '<Item>'+
                                    '<PartNumber>'+ComplianceUtility.getStringValue(productObj.Name)+'</PartNumber>'+
                                    '<ClientReferenceNumber>'+ComplianceUtility.getStringValue(productObj.Name)+'</ClientReferenceNumber>'+
                                    '<ShortDescription>'+ComplianceUtility.getStringValue(productObj.inscor__Keyword__c)+'</ShortDescription>'+
                                    '<LongDescription>'+ComplianceUtility.getStringValue(productObj.inscor__Description__c)+'</LongDescription>'+
                                    '<OriginCountry>'+ComplianceUtility.getStringValue(CountryStateUtility.getCountryCode(productObj.inscor__Country_of_Origin__c))+'</OriginCountry>'+
                                    '<IsHazmat>'+productObj.inscor__HazMat__c+'</IsHazmat>'+
                                    '<HazmatID>'+ComplianceUtility.getStringValue(productObj.inscor__HazMat_Id__c)+'</HazmatID>'+
                                    '<isInactive>'+!productObj.IsActive+'</isInactive>'+
                                '</Item>'+
                            '</Items>';
        requestXML += ']]>';
        return requestXML;
    }
    
    
    
    //This method will return XML String for Contact.
    //Added 02June2021 
     public static String createRequestXMLToContactWithAccount(Contact con, Account customer) {
        
         String shippingCountry = ComplianceUtility.getStringValue(customer.ShippingCountry);
        
         shippingCountry = CountryStateUtility.getCountryCode(shippingCountry);
         
        String customerXML = '<TPID>'+customer.Id+'</TPID>'+
                              '<TPName>'+ComplianceUtility.getStringValue(customer.Name)+'</TPName>'+
                              '<TPAddress>'+ComplianceUtility.getStringValue(customer.ShippingStreet)+'</TPAddress>'+
                              '<TPCity>'+ComplianceUtility.getStringValue(customer.ShippingCity)+'</TPCity>'+
                              '<TPZipPostCode>'+ComplianceUtility.getStringValue(customer.ShippingPostalCode)+'</TPZipPostCode>'+
                              '<TPState>'+ComplianceUtility.getStringValue(customer.ShippingState)+'</TPState>'+
                              '<TPCountry>'+shippingCountry+'</TPCountry>'+
                              '<TPTelephone>'+ComplianceUtility.formatAccountContactPhone(customer.Phone)+'</TPTelephone>';
                                
        
         String contactXML = '<ContactType>'+'PRIMARY'+'</ContactType>'+
                            '<ContactName>'+ComplianceUtility.getStringValue(con.Name)+'</ContactName>'+
                             '<ContactTitle>'+ComplianceUtility.getStringValue(con.Title)+'</ContactTitle>'+
                             '<ContactPhone>'+ComplianceUtility.formatAccountContactPhone(con.Phone)+'</ContactPhone>'+
                             '<ContactEmail>'+ComplianceUtility.getStringValue(con.Email)+'</ContactEmail>';
           
        
        String requestXML = '<![CDATA[';
        
        requestXML += '<?xml version="1.0" encoding="UTF-8"?>'+
                       '<TradePartners xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://edm.visualcompliance.com/edwinimport/xml/VD-EDM%20TradePartner%20V2.1.xsd">'+
                           '<TradePartner>'+customerXML+
                           '<Contacts>'+
                            '<ContactDetail>'+ contactXML+'</ContactDetail>'+
                           '</Contacts>';
            requestXML+= '</TradePartner>'+
                        '</TradePartners>';
        requestXML += ']]>';
        return requestXML;
        
    }
}