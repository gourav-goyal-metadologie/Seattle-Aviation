public class Webhook {
  public static String jsonContent(List<Object> triggerNew, List<Object> triggerOld) {
    String newObjects = '[]';
    if (triggerNew != null) {
      newObjects = JSON.serialize(triggerNew);
    }
    String oldObjects = '[]';
    if (triggerOld != null) {
      oldObjects = JSON.serialize(triggerOld);
    }
    String userId = JSON.serialize(UserInfo.getUserId());
    String content = '{"new": ' + newObjects + ', "old": ' + oldObjects + ', "userId": ' + userId + '}';
    return content;
  }
  @future(callout=true) public static void callout(String url, String content) {
    Http h = new Http();
    HttpRequest req = new HttpRequest();
    req.setEndpoint(url);
    req.setMethod('POST');
    req.setHeader('Content-Type', 'application/json');
    req.setBody(content);
    h.send(req);
  }
}