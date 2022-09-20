import { LightningElement } from 'lwc';
import { pubsub } from 'c/pubsub';

export default class SubscriberLWC extends LightningElement {
    message;

    connectedCallback() {
        this.register();
    }

    register() {
        pubsub.registerListener("simpleevt", this.handleEvent.bind(this));
    }

    handleEvent(messageFromEvt) {
        console.log('Event Registered');
        this.message = messageFromEvt ? JSON.stringify(messageFromEvt, null) : "No message triggered";

    }
}