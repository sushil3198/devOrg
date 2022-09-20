import { LightningElement, wire } from 'lwc';
import messageChannel from '@salesforce/messageChannel/lwcExample__c';
import { subscribe, MessageContext } from 'lightning/messageService';
import returnResult from '@salesforce/apex/assetController.returnResult';
import sObjectPermissionFLS from '@salesforce/apex/assetController.sObjectPermissionFLS';
import fetchObjectFLS from '@salesforce/apex/assetController.fetchObjectFLS';
const columns = [
    { label: 'Field Name', fieldName: 'Field' },
    { label: 'Edit Acess', fieldName: 'PermissionsEdit' },
    { label: 'Read Access', fieldName: 'PermissionsRead' }
];
export default class ObjectFLS extends LightningElement {

    @wire(MessageContext)
    messageContext;
    payloadss = null;
    parameterValue = 'Profile';
    profileList;
    optionsList;
    value;
    showPick2 = false;
    hasFLS = false;
    combo2Val;
    pick2Options
    objectType;
    flsData;
    cols = columns;
    connectedCallback() {
        this.handleSubscribe();
        returnResult({ value: this.parameterValue }).then(response => {
            console.log('Response from Controller ----> ', response);
            this.profileList = response.profileList;
            console.log('ProfileList---------------------> ', this.profileList);
            let tempList = [];
            for (var i = 0; i < this.profileList.length; i++) {
                tempList.push({ label: this.profileList[i].Name, value: this.profileList[i].Id });
            }
            this.optionsList = tempList;
            console.log('Options --> ', this.optionsList);
        }).catch(error => { console.error(error) })
    }


    handleSubscribe() {
        console.log('inside Subscriber');
        this.payloadss = subscribe(this.messageContext, messageChannel, (message) => this.handleMessage(message));
        console.log('payload ----> ', this.payloadss);
        console.log('Stringify ----> ', JSON.stringify(this.payloadss));
    }

    handleMessage(message) {
        console.log('inside this bock>>>');
        console.log('message--> ', message);
    }


    pickOneHandler(event) {
        this.value = event.detail.value;
        console.log(event.target.options);
        console.log('value---> ', this.value);
        sObjectPermissionFLS({ profileId: this.value }).then(response => {
            console.log('Response from sObjectPermissionFLS ---> ', response);
            if (response.length > 0) {
                this.showPick2 = true;
                let tempList = [];
                for (var i = 0; i < response.length; i++) {
                    tempList.push({ label: response[i].SobjectType, value: response[i].Id });
                }
                console.log('TempList Options---> ', tempList);

                this.pick2Options = tempList;
            } else {
                this.showPick2 = false;
                this.pick2Options = [];
            }
            console.log('options ----> ', this.pick2Options);
        }).catch(error => {
            console.error('Error >>>>> ', error);
        })
    }

    pick2Handler(event) {
        this.combo2Val = event.detail.value;
        console.log('Comboval 2 ---> ', this.combo2Val);
        this.objectType = this.pick2Options.find(opt => opt.value === event.detail.value).label;
        console.log('Label --> ', this.objectType);
        fetchObjectFLS({
            profileId: this.value,
            objectName: this.objectType
        }).then(response => {
            console.log('response FLS -> ', response);
            if (response.length > 0) {
                this.hasFLS = true;
                this.flsData = response;
            } else {
                this.hasFLS = false;
            }
        }).catch(error => {
            console.error('Error --> ', error);
        })
    }
}