import { LightningElement,api } from 'lwc';

export default class BetaLWC extends LightningElement {

    @api fruits = ['Apple', 'Banana', 'Grapes', 'Orange', 'Pineapple'];


    onClickHandler() {
        console.log('Button Clicked');
        //const fruit = this.fruits;
        const evt = new CustomEvent("childevent", {
            detail:  this.fruits
        });
        this.dispatchEvent(evt);
    }
}