({
    doInit: function(component, event, helper) {
        var action = component.get("c.getPaginateAllRecords");
        action.setCallback(this, function(data) {
            if(data.getReturnValue().length > 0){
                var a = data.getReturnValue()[0];
                component.set("v.recordId", a);
                component.set("v.count", 0);
                if(data.getReturnValue().length-1 == 0 || data.getReturnValue().length < 0){
                    component.set("v.isNext", true);
                    component.set("v.isPrev", true);
                    
                }
                else{
                    component.set("v.isNext", false);
                    component.set("v.isPrev", true);
                }
                
                
            }
          
        });
        $A.enqueueAction(action);
      },
    
    handleNext: function(component, event, helper) {
        var action = component.get("c.getPaginateAllRecords");
        action.setCallback(this, function(data) {
            if(data.getReturnValue().length > 0){
                var count = component.get("v.count");
                if(count < data.getReturnValue().length-1){
                var a = data.getReturnValue()[count+1];
                component.set("v.recordId", a);
                component.set("v.count", count+1);    
                }
                if(count+1 < data.getReturnValue().length-1){
                    component.set("v.isNext", false);
                    component.set("v.isPrev", false);
                }
                else{
                    component.set("v.isNext", true);
                    component.set("v.isPrev", false);
                }
            }
        });
        $A.enqueueAction(action);
      },
    
    handlePrevious: function(component, event, helper) {
        var action = component.get("c.getPaginateAllRecords");
        action.setCallback(this, function(data) {
            if(data.getReturnValue().length > 0){
                var count = component.get("v.count");
                if(count < data.getReturnValue().length-1 && count != 0){
                var a = data.getReturnValue()[count-1];
                component.set("v.recordId", a);
                component.set("v.count", count-1);    
                }
                if(count-1 > 0){
                    component.set("v.isNext", false);
                    component.set("v.isPrev", false);
                }
                else{
                    component.set("v.isNext", false);
                    component.set("v.isPrev", true);
                }
            }
        });
        $A.enqueueAction(action);
      }
})