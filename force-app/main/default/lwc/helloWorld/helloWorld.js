import { LightningElement } from 'lwc';

export default class HelloWorld extends LightningElement { 
    value;
    inputHandler(event){
        this.value = event.target.value;
    }
}