import { LightningElement, wire } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import messageChannel from '@salesforce/messageChannel/lwcExample__c';
import { publish, MessageContext } from 'lightning/messageService';
import returnResult from '@salesforce/apex/assetController.returnResult';
import permissionManipulation from '@salesforce/apex/assetController.permissionManipulation';
import sObjectPermission from '@salesforce/apex/assetController.sObjectPermission';
import getUserPermissionSets from '@salesforce/apex/assetController.getUserPermissionSets';
import fetchCustomPermission from '@salesforce/apex/assetController.fetchCustomPermission';
const columns = [
    { label: 'sObjectType', fieldName: 'SobjectType' },
    { label: 'Read Access', fieldName: 'PermissionsRead' },
    { label: 'Write Access', fieldName: 'PermissionsCreate' },
    { label: 'Delete Access', fieldName: 'PermissionsDelete' },
    { label: 'Edit Access', fieldName: 'PermissionsEdit' }
];
export default class Assetlwc extends NavigationMixin(LightningElement) {

    @wire(MessageContext)
    messageContext;

    message;
    optionsList;
    //firstValue;
    op;
    columnNames = columns;
    data;
    profileList;
    userList;
    permissionSetList;
    permissionSetMsg;
    permissionSetError = false;
    customPermissionList;
    customPermissionData = false;
    customPermissionError = false;
    isProfile = false;
    customDataMsg;
    comboval;
    options2List = [];
    combo2val;
    apexClassList;
    displayError = false;
    optionsList = [
        { label: 'Profile', value: 'Profile' },
        { label: 'User', value: 'User' },
        { label: 'Permission Set', value: 'Permission_Set' }
    ];
    options3List = [
        { label: 'Apex Class', value: 'class' },
        { label: 'sObject', value: 'object' }
    ];
    combo3val;
    showData = false;
    apexData = false;
    objectData = false;

    firstComboHandler(event) {
        console.log('Target  Profile-------->', event.target.value);
        this.comboval = event.detail.value;
        this.showData = false;
        this.customPermissionError = false;
        this.permissionSetError = false;
        console.log('Value ----> ', this.comboval);

        returnResult({ value: this.comboval }).then(response => {
            console.log('Response -----> ', response);
            if (this.comboval == 'Profile') {
                this.isProfile = true;
                this.profileList = response.profileList;
                console.log('ProfileList---------------------> ', this.profileList);
                let tempList = [];
                for (var i = 0; i < this.profileList.length; i++) {
                    tempList.push({ label: this.profileList[i].Name, value: this.profileList[i].Id });
                }
                console.log('Options 2 ----> ', tempList);
                this.options2List = tempList;
            }
            else if (this.comboval == 'User') {
                console.log('******* User ******');
                this.isProfile = false;
                this.userList = response.userList;
                console.log(this.userList);
                let temp = [];
                for (var i = 0; i < this.userList.length; i++) {
                    temp.push({ label: this.userList[i].Username, value: this.userList[i].Id });
                }
                this.options2List = temp;
                console.log('optionsssss-------> ', this.options2List);
            }
            else if (this.comboval == 'Permission_Set') {
                console.log('****** Permission Set ********');
                this.isProfile = false;
                this.permissionSetList = response.permList;
                console.log(this.permissionSetList);
            }

        }).catch(error => { console.error('Error ----> ', error) })


    }

    secondComboHandler(event) {
        this.combo2val = event.detail.value;
        console.log('combo2Val ----> ', this.combo2val);
        this.customPermissionData = false;
        this.customPermissionError = false;
        if (this.comboval == 'Profile') {
            this.options3List = [
                { label: 'Apex Class', value: 'class' },
                { label: 'sObject', value: 'object' }
            ];
            permissionManipulation({ profileId: this.combo2val }).then(response => {
                console.log('Response from Apex ----> ', response);
                this.apexClassList = response;
                if (response.length <= 0) {
                    this.displayError = true;
                    console.log('Inside If---> ', this.displayError);
                } else { this.displayError = false; }

                // let tempApex;
                // tempApex = [];
                // console.log(tempApex);
                // for (var i = 0; i < response.length; i++) {
                //     tempApex.push({Name: response[i].Name});
                // }
                // console.log('Temp----> ', tempApex);
                // this.apexClassList = tempApex;
                console.log('Data----> ', this.apexClassList);
            }).catch(error => {
                console.error('Error -----> ', error);
            });

            sObjectPermission({ profileId: this.combo2val }).then(response => {
                console.log('sObject ----> ', response);
                this.data = response;
            }).catch(error => {
                console.error('Error ----> ', error);
            })
        } /************** If Condition ends here *******************/

        else if (this.comboval == 'User') {
            this.permissionSetError = false;
            this.options3List = [];
            console.log('else if -----> ', this.combo2val);
            getUserPermissionSets({ userId: this.combo2val }).then(response => {
                console.log('Response -----> ', response);
                let tempList = [];
                let option = [];
                if (response.length > 0) {
                    this.permissionSetError = false;
                    for (var i = 0; i < response.length; i++) {
                        tempList.push(response[i].PermissionSet);
                    }
                    console.log('response ---> ', tempList);
                    for (var j = 0; j < tempList.length; j++) {
                        option.push({ label: tempList[j].Name, value: tempList[j].Id });
                    }
                    console.log('option3List --------> ', option);
                    this.options3List = option;
                }
                else {
                    this.permissionSetError = true;
                    this.customPermissionError = false;
                    this.permissionSetMsg = 'No Permission Set is assigned to this user';
                }
            }).catch(error => {
                console.error('Error -------> ', error)
            })
        }
    }

    thirdComboHandler(event) {
        this.combo3val = event.detail.value;
        console.log('Select Option ----> ', this.combo3val);
        if (this.comboval == 'Profile') {
            this.customPermissionData = false;
            if (this.combo3val != null || this.combo3val != undefined) {
                this.showData = true;
                if (this.combo3val == 'class') {
                    this.apexData = true;
                    this.objectData = false;
                }
                else if (this.combo3val == 'object') {
                    this.apexData = false;
                    this.objectData = true;
                }
            }

        }

        if (this.comboval == 'User') {
            this.showData = false;
            fetchCustomPermission({ permissionSetId: this.combo3val }).then(response => {
                console.log('Response -------> ', response);
                //let tempList = [];
                if (response.length > 0) {
                    this.customPermissionData = true;
                    this.displayError = false;
                    this.customPermissionError = false;
                    // for (let i = 0; i < response.length; i++) {
                    //     tempList.push(response[i].DeveloperName);
                    // }
                    this.customPermissionList = response;
                    console.log('tempList ----> ', this.customPermissionList);
                    // this.customPermissionList = tempList;
                }
                else {
                    console.log('Inside custom permission else');
                    this.displayError = true;
                    //  this.customPermissionData = true;
                    this.customPermissionError = true;
                    this.customDataMsg = 'This Permission Set has no Custom Permission Assigned';
                }

            }).catch(error => {
                console.log('Error-----> ', error);
            })
        }

    }

    navigationHandler() {
        console.log('Button Click');
        if (this.isProfile == true) {
            console.log('inside Message ----> ');
            const message = { messageToSend: "Profile" };
            console.log('inside Message ----> ' + JSON.stringify(message));
            publish(this.messageContext, messageChannel, message);
            console.log('event fired>>>>>');
        }
        this[NavigationMixin.Navigate]({
            type: 'standard__navItemPage',
            attributes: { apiName: 'FLS' }
        });
    }
}