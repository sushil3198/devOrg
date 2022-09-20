public class FoodMenuController {
    
    @AuraEnabled
    public static List<String> returnValue(String str){
        List<String> vegValues = new List<String>();
        List<String> nonVegValues= new List<String>();
        vegValues.add('Samosa');
        vegValues.add('Pakoda');
        vegValues.add('Cheela');
        vegValues.add('Pav Bhaji');
        nonVegValues.add('Chicken');
        nonVegValues.add('Chicken Tikka');
        nonVegValues.add('Chicken Kabab');
        nonVegValues.add('Fish Orley');
        
        if(str == 'veg')
            return vegValues;
        else if(str == 'nonveg')
        	return nonVegValues;
        return null;
    }
    
    
}