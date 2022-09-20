import { LightningElement } from 'lwc';
import { fireEvent } from 'c/pubsub';
export default class PublisherLWC extends LightningElement {

    handleClick() {
        let message = {
            "message": 'Hello Pubsub'
        }
        fireEvent('simpleevt', message);
        console.log('Event Fired');
    }
}