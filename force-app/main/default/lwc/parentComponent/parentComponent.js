import { LightningElement } from 'lwc';

export default class ParentComponent extends LightningElement {
    value;
    msg;
    valueHandler(event){
        this.value = event.target.value;
    }

    checkboxSelectHandler(){
        const childComponent = this.template.querySelector('c-child-component');
        const returnedValue = childComponent.selectCheckbox(this.value);
        this.msg = returnedValue;
        console.log(returnedValue);
    }

    
}