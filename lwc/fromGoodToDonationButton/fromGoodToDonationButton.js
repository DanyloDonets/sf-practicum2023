import { LightningElement, track, api } from 'lwc';
import { updateRecord } from 'lightning/uiRecordApi';
import GoodsToDonation from '@salesforce/apex/FromGoodsToDonation.FromGoodsToDonation'
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import DescriptionField from '@salesforce/schema/Donation__c.DescriptionOfDonate__c';
import IdField from '@salesforce/schema/Donation__c.Id';
export default class FromGoodToDonationButton extends LightningElement {

    @api recordId;

async  generateDescription(){
        try{
            const description = await GoodsToDonation({donationId: this.recordId});

            const fields ={};
            fields[IdField.fieldApiName]= this. recordId;
            fields[DescriptionField.fieldApiName] = description;
                               const recordInput ={fields};

                               await updateRecord(recordInput).then((record) => {

                                                           const event = new ShowToastEvent({
                                                                               title: 'Generate description',
                                                                               message:
                                                                                   'Description is generated!',
                                                                           });
                                                                   this.dispatchEvent(event);
                                                         });


                            }catch(e){
                                this.dispatchEvent(new ShowToastEvent({
                                  title: 'Generate description',
                                   message:
                                   'Error! Сontact your System Administrator!',
                                    }));
                            }


            }
        }