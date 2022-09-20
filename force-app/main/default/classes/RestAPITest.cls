@isTest
private class RestAPITest {
    
    @isTest static void testCallout(){
        System.Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        HttpResponse res = RestAPI.makeGetRequest();
        System.debug(res);
    }
}