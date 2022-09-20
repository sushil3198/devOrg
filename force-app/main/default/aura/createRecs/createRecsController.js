({
    doInit: function(component, event, helper) {
        // Prepare a new record from template
        component.find("recordCreator").getNewRecord(
            "Person__c", // sObject type (objectApiName)
            null,      // recordTypeId
            false,     // skip cache?
            $A.getCallback(function() {
                var rec = component.get("v.newRecord");
                var error = component.get("v.newRecordError");
                if(error || (rec === null)) {
                    console.log("Error initializing record template: " + error);
                    return;
                }
                console.log("Record template initialized: " + rec.apiName);
            })
        );
    },
 
    handleSaveRecord: function(component, event, helper) {
        console.log("button clicked");
            component.set("v.simpleNewRecord.PersonId", component.get("v.recordId"));
            component.find("recordCreator").saveRecord(function(saveResult) {
                if (saveResult.state === "SUCCESS" || saveResult.state === "DRAFT") {
                    // record is saved successfully
                    var resultsToast = $A.get("e.force:showToast");
                    resultsToast.setParams({
                        "title": "Saved",
                        "message": "The record was saved.",
                        "type": 'success'
                    });
                    resultsToast.fire();
 
                } else if (saveResult.state === "ERROR") {
                    // handle the error state
                    console.log('Problem saving contact, error: ' + JSON.stringify(saveResult.error));
                    
                    var resultsToast = $A.get("e.force:showToast");
                    resultsToast.setParams({
                        "title": "Error",
                        "message": "Check Phone number/Email",
                        "type": 'error'
                    });
                    resultsToast.fire();
                }
                
                else {
                    console.log('Problem, state: ' + saveResult.state + ', error: ' + JSON.stringify(saveResult.error));
                }
            });
        
    }
})