/**
 * Created by mykola.senyk on 30.01.2023.
 */

import { LightningElement, api } from 'lwc';
import { updateRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getDescriptionOfDonation from '@salesforce/apex/FromGoodsToDonation.FromGoodsToDonation'
import DESCRIPTION_FIELD from '@salesforce/schema/Donation__c.DescriptionOfDonate__c';

export default class GenerateDescription extends LightningElement {

    @api
    recordId;

    buildDescription() {
        getDescriptionOfDonation({donationId: this.recordId})
        .then(result => {
            console.log('Description', result);
            const fields = {};
            fields.Id = this.recordId;
            fields[DESCRIPTION_FIELD.fieldApiName] = result;
            const recordInput = { fields };
            return updateRecord(recordInput);
        })
        .then(res => {
            this.showSuccess('The description of donation has been updated');
        })
        .catch(error => {
            this.showError(error.body.message);
        });
    }

    showSuccess(message) {
        showToast(message, 'Success', 'success');
    }

    showError(error) {
        showToast(error, 'Oops! We have got an error', 'error');
    }

    showToast(message, title, variant) {
        this.dispatchEvent(
            new ShowToastEvent({
                title,
                message,
                variant
            })
        );
    }

}