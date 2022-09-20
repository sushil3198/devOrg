import { LightningElement } from 'lwc';

export default class ParentLMS extends LightningElement {
    data;
    simpleData;
    names;
    handleEvt(event){
        let value = event.detail;
        this.data = value;
       // this.data = JSON.parse(JSON.stringify(value.Name));
        console.log('Parent--', value);
        console.log('Parent Names--', JSON.parse(JSON.stringify(this.data)));
        this.simpleData = JSON.parse(JSON.stringify(this.data));
        console.log('Simple-----', this.simpleData);
        let nameList = this.simpleData.map( data => {
            return data.Name;
        })
        console.log('Names-------', nameList);
        this.names = nameList;
    }
}