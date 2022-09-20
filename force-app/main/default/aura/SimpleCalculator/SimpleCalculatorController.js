({
	addition : function(component, event, helper) {
        console.log('button cicked');
        var firstNumber = component.get("v.firstNumber");
        var secondNumber = component.get("v.secondNumber");
        var result = parseInt(firstNumber) + parseInt(secondNumber);
        component.set("v.result", result);
        console.log(result);
	} 
})