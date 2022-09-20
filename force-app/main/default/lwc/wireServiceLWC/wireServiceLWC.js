import { LightningElement, wire } from 'lwc';
import getAccounts from '@salesforce/apex/WireClassDemo.getAccounts'
export default class WireServiceLWC extends LightningElement {

    @wire(getAccounts) 
    accounts
    
    onClickHandler(){
        console.log('Apex -----------> ', this.accounts.data);
    }
    
}