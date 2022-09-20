import { LightningElement } from 'lwc';

export default class PapaLWC extends LightningElement {
    phal;
   // data;
    fruitObj = [];
    parentFruits(event) {
        this.phal = event.detail;
        console.log(this.phal);
       // this.data = JSON.stringify(this.phal);
        //console.log(this.data);
        for (var i = 0; i < this.phal.length; i++) {
            this.fruitObj.push({ id: i + 1, value: this.phal[i] });
        }
        //this.fruitObj = [];
        console.log('Fruitssss------->', this.fruitObj);
    }
}