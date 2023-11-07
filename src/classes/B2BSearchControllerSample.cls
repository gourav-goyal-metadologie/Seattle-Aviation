/**
 * @description Demonstrates how to make REST calls to ConnectApi.CommerceSearch class
 * to perform Search and Category browsing for B2B Commerce on Lightning.
 *
 * @see B2BUtils
 */
public with sharing class B2BSearchControllerSample {
    // Cached API version of this apex class.
    private static Decimal apiVersionApexClass = [
        SELECT ApiVersion
        FROM ApexClass
        WHERE Name = 'B2BSearchControllerSample'
        //WITH SECURITY_ENFORCED
        LIMIT 1
    ]
    .ApiVersion;

    /**
     * @description Demonstrates how to call ConnectApi.CommerceSearch.productSearch
     * @param communityId The Id of the community from which the call originated
     * @param searchQuery The search query parameters which includes searchTerm, categoryId, refinements, page and includePrices
     * @param @param effectiveAccountId ID of the account for which the request is made. If null, defaults to the account ID for the context user.
     */
    @AuraEnabled(cacheable=true)
    public static Object productSearch(
        String communityId,
        String searchQuery,
        String effectiveAccountId
    ) {
        // Lookup the webstore ID associated with the community
		
        System.debug('Community ID : ' + communityId);
        System.debug('EffectiveAccountId B2BSearchControllerSample -> '+effectiveAccountId);
                        // Try catch handle

        String webstoreId = B2BUtils.resolveCommunityIdToWebstoreId(
            communityId
        );
    		// This doesn't execute since insert causes an exception
    		System.debug('Webstore Id after insert : ' + webstoreId); // getting webstoreId 
				
        //String webstoreId = '0ZE6s0000000085GAA';

        HttpRequest httpRequest = new HttpRequest();
        Object response;

        // As per the Salesforce documentation
        // "By security policy, sessions created by Lightning components aren’t
        //  enabled for API access. This prevents even your Apex code from
        //  making API calls to Salesforce. Using a named credential for
        //  specific API calls allows you to carefully and selectively bypass
        // this security restriction."
        // - https://developer.salesforce.com/docs/atlas.en-us.lightning.meta/lightning/apex_api_calls.htm
        //
        // So the following section that takes the OAuth is commented out and
        // used the named credential callout 'CallMeBack' below.
        // The steps to create named credentials are documented the repo here
        // docs/NamedCredentials.md

        // httpRequest.setMethod('POST');
        // httpRequest.setHeader('Content-Type', 'application/json');
        // httpRequest.setHeader('Authorization', 'OAuth ' + UserInfo.getSessionId());

        // String baseUrl = URL.getOrgDomainUrl().toExternalForm();
        // String apiUrl = '/services/data/v' + apiVersionApexClass + '/commerce/webstores/' + webstoreId + '/search/product-search';
        // httpRequest.setEndpoint(baseUrl + apiUrl);

        httpRequest.setMethod('POST');
        httpRequest.setHeader(
            'Content-Type',
            'application/json;  charset=utf-8'
        );
        httpRequest.setEndpoint(
            'callout:CallMeBack/services/data/v' +
            apiVersionApexClass +
            '/commerce/webstores/' +
            webstoreId +
            '/search/product-search'
        );
        httpRequest.setBody(searchQuery);
        //Integer statusCode = 200;
        try {
            Http http = new Http();
            HttpResponse httpResponse = new HttpResponse();
            if(!Test.isRunningTest())
            	httpResponse = http.send(httpRequest);
            else
                httpResponse.setStatusCode(200);
            System.debug('HttpResponse' + httpResponse);
            /* Integer statusCode = httpResponse.getStatusCode(); */
			System.debug('StatusCode : ' + httpResponse.getStatusCode()); // getting No status code here @by deb
            if (httpResponse.getStatusCode() >= 200 && httpResponse.getStatusCode() <= 204) {

                if(string.isnotblank(effectiveAccountId)){
                    String str=httpResponse.getBody();
                    System.debug('String -> '+str);
                    str=str.replace('000000000000000',effectiveAccountId);
                    if(!Test.isRunningTest())
                    	response = JSON.deserializeUntyped(str);
                    else
                        response = '';
                }else{
                    
                    response = JSON.deserializeUntyped(httpResponse.getBody());
                }
                

                //response = JSON.deserializeUntyped(httpResponse.getBody());

                  //response=response.replace('000000000000000',effectiveAccountId);

                 
                //   System.debug('String After Conversion -> '+str);
                //   response=(Object)str;

                System.debug('response -> '+response);
            } else {
                System.debug(' httpResponse ' + httpResponse.getBody());
                throw new CalloutException(httpResponse.getBody());
            }
        } catch (System.Exception e) {
            System.debug('ERROR: ' + e);
            throw e;
        }
		System.debug('Response : ' + response);
        return response;
    }
}