import { LightningElement, track, api } from 'lwc';

export default class ChildComponent extends LightningElement {
    @track value = ['red'];


    options = [
        { label: 'Red Marker', value: 'red' },
        { label: 'Orange Marker', value: 'orange' },
        { label: 'Maroon Marker', value: 'Maroon' },
        { label: 'Yellow Marker', value: 'Yellow' },
        { label: 'Pink Marker', value: 'Pink' },
        { label: 'Black Marker', value: 'Black' },
        { label: 'Grey Marker', value: 'Grey' },
    ];


    @api selectCheckbox(checkboxValue) {
       const selectedCheckBox =  this.options.find( checkbox =>{
            return checkboxValue === checkbox.value;
        });

        if(selectedCheckBox){
            this.value = selectedCheckBox.value;
            return "Successfully Checked";
        }
    
        return "No checkbox found";
    }

    

}