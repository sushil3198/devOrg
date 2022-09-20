import { LightningElement, api, wire } from 'lwc';
import messageChannel from '@salesforce/messageChannel/sampleMessageChannel__c';
import fetchAccounts from '@salesforce/apex/AccountManager.fetchAccounts';
import { publish, MessageContext } from 'lightning/messageService'
const columns = [
    { label: 'Id', fieldName: 'Id' },
    { label: 'Name', fieldName: 'Name' }
]
export default class ComponentTwo extends LightningElement {

    // @wire(fetchAccounts) accounts;
    @wire(MessageContext)
    messageContext;
    accounts;
    cols = columns;
    @api selectedData;
    nameToSend = [];
    connectedCallback() {
        console.log('Connected===================', this.accounts);
    }


    clickHandler() {

        fetchAccounts().then(response => {
            console.log('Data=====> ', response);
            this.accounts = response;
        }).catch(error => {
            console.log('Error----> ', error);
        })

    }
    rowHandler(event) {
        console.log(event.detail.selectedRows);
        let rows = JSON.parse(JSON.stringify(event.detail.selectedRows));
        console.log('selected Data ======= ', rows);
        this.selectedData = rows;

        this.selectedData.forEach(element => {
            console.log(element.Name);
        });

        //const evt = new CustomEvent('rowselect', { detail: this.selectedData });
        //this.dispatchEvent(evt);

        publish(this.messageContext, messageChannel, this.selectedData);
    }

    //BEL17062279940

}