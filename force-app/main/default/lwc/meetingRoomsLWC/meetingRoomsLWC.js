import { LightningElement } from 'lwc';

export default class MeetingRoomsLWC extends LightningElement {
    meetingRoomsInfo = [
        { roomName: 'A-101', roomCapacity : 100 },
        { roomName: 'A-102', roomCapacity : 12 },
        { roomName: 'A-103', roomCapacity : 15 },
        { roomName: 'B-104', roomCapacity : 25 },
        { roomName: 'B-201', roomCapacity : 85 },
        { roomName: 'B-206', roomCapacity : 15 },
        { roomName: 'B-207', roomCapacity : 25 },
        { roomName: 'C-301', roomCapacity : 75 },
        { roomName: 'C-304', roomCapacity : 55 },
    ];
}