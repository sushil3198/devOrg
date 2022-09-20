public class RestAPI {

    public static HttpResponse makeGetRequest(){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://86b3ff479f38019c2cecb31f465614d0.m.pipedream.net');
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        return response;
    }
}