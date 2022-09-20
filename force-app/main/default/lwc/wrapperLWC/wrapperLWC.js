import { LightningElement } from 'lwc';
import returnList from '@salesforce/apex/WrapperDemo.returnList';
export default class WrapperLWC extends LightningElement {

    searchString;
    receivedData;
    contactList;
    oppsList;
    tableValues;
    dataTableValues;
    inputHandler(event) {
        this.searchString = event.target.value;
        console.log('searchTerm: ', this.searchString);
    }

    searchHandler() {
        returnList({ inputName: this.searchString }).then(response => {
            this.receivedData = response;
            console.log('Response: ', this.receivedData);
            this.contactList = this.receivedData.cList;
            this.oppsList = this.receivedData.oppsList;

            const combinedNames = this.contactList.map(contact => {
                return contact.LastName;
            })
            const OppsName = this.oppsList.map(opp => {
                return opp.Name;
            })

            this.tableValues = combinedNames.concat(OppsName);
            console.log('yo---------', this.tableValues);


            var atLastValues = [];
            for (let i = 0; i < this.tableValues.length; i++) {
                atLastValues.push({ id: i + 1, Name: this.tableValues[i] });
            }
            console.log('Obj==========>', atLastValues);
            this.dataTableValues = atLastValues;

        }).catch(error => {
            console.log('Error: ', error.body.message);
            console.log('Error Obj: ', error);
        })
    }





}