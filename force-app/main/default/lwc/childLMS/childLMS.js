import { LightningElement, api } from 'lwc';
import fetchAccounts from '@salesforce/apex/AccountManager.fetchAccounts';

const columns = [
    { label: 'Id', fieldName: 'Id' },
    { label: 'Name', fieldName: 'Name' }
]
export default class ChildLMS extends LightningElement {

    // @wire(fetchAccounts) accounts;
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

        const evt = new CustomEvent('rowselect', { detail: this.selectedData });
        this.dispatchEvent(evt);
    }


}