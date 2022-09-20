import { LightningElement, wire } from 'lwc';
import messageChannel from '@salesforce/messageChannel/sampleMessageChannel__c';
import { subscribe, MessageContext } from 'lightning/messageService';

const cols = [
    { label: 'Name', fieldName: 'Name' }
]
export default class ComponentOne extends LightningElement {

    @wire(MessageContext)
    messageContext;
    data;
    simpleData;
    names;
    payload = null;
    columns = cols;
    connectedCallback() {
        this.handleEvt();
    }
    handleEvt() {
        this.payload = subscribe(this.messageContext, messageChannel, (message) => {
            console.log(message);
            this.data = message;
            console.log('Hello World========= ', this.data);

            this.simpleData = JSON.parse(JSON.stringify(this.data));
            let nameList = this.simpleData.map(data => {
                return data.Name;
            })
            console.log('Names-------', nameList);
            this.names = nameList;
        });


        // this.data = value;
        // // this.data = JSON.parse(JSON.stringify(value.Name));
        // console.log('Parent--', value);
        // console.log('Parent Names--', JSON.parse(JSON.stringify(this.data)));
        // this.simpleData = JSON.parse(JSON.stringify(this.data));
        // console.log('Simple-----', this.simpleData);
        // let nameList = this.simpleData.map(data => {
        //     return data.Name;
        // })
        // console.log('Names-------', nameList);
        // this.names = nameList;
    }
}