import { LightningElement } from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';

export default class PersonValidate extends NavigationMixin(LightningElement) {
    firstName;
    lastName;
    phoneNumber;
    email;
    recordId;

    firstNameHandler(event) {
        this.firstName = event.target.value;
    }

    lastNameHandler(event) {
        this.lastName = event.target.value;
    }

    emailHandler(event) {
        this.email = event.target.value;
    }


    phoneNumberHandler(event) {
        this.phoneNumber = event.target.value;
    }

    
    createPerson() {
        let pNo = this.template.querySelector(".phoneNumber").value;
        let emailAddress = this.template.querySelector(".email").value;


        if (pNo.length < 10) {
           this.template.querySelector(".phoneNumber").setCustomValidity("Phone Number must be a Number & of 10 digits");
            // setTimeout(()=>{this.template.querySelector(".phoneNumber").setCustomValidity("Phone Number must be a Number & of 10 digits") },3000);

            const showError = new ShowToastEvent({
                title:'Error',
                message: 'Please Check your Phone number',
                variant: 'Error'
            });
            this.dispatchEvent(showError);
        }

        //      Email Validation
        else if(!emailAddress.match(/[^@]+@[^\.]+\..+/))
        {
            this.template.querySelector(".email").setCustomValidity("Please enter a Valid email ID");   
            
            const showError = new ShowToastEvent({
                title:'Error',
                message: 'Please Check your Email Address',
                variant: 'Error'
            });
            this.dispatchEvent(showError);
        }

        else {
            this.template.querySelector(".phoneNumber").setCustomValidity("");
            const fields = { 'First_Name__c': this.firstName, 'Last_Name__c': this.lastName, 'Phone_Number__c': this.phoneNumber, 'Email__c': this.email, 'Name': this.firstName + ' ' + this.lastName }
            const recordInputs = { apiName: 'Person__c', fields }
            createRecord(recordInputs)
                .then(response => {
                     console.log('Created Successfully' + response.id);
                     this.recordId = response.id;
                     
                     const showSuccess = new ShowToastEvent({
                        title:'Success',
                        message: 'Record Successfully Created',
                        variant: 'Success'
                    });
                    this.dispatchEvent(showSuccess);
                    
                    this[NavigationMixin.Navigate]({
                        type:'standard__recordPage',
                        attributes : {
                            recordId : this.recordId,
                            objectApiName: 'Person__c',
                            actionName:'view'
                        },
                    })
                
                })
                .catch(error => { 
                    console.log('Error while creating' + error.body.message); 

                    const showError = new ShowToastEvent({
                        title:'Oops! Please check input once',
                        message: error.body.message,
                        variant: 'Error'
                    });
                    this.dispatchEvent(showError);

            })
            
        }
        this.template.querySelector(".phoneNumber").reportValidity();
        this.template.querySelector(".email").reportValidity();
    }
}