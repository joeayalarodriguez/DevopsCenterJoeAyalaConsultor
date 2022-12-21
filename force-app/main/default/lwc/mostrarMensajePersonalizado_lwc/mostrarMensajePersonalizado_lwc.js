import { LightningElement,wire, api } from 'lwc';
import getrecord from '@salesforce/apex/mostrarMensajePersonalizado_ctr.getrecord';
export default class MostrarMensajePersonalizado_lwc extends LightningElement {
    iscompletedfields=false;
    @api recordId;
    record;

    @wire(getrecord, {strAccountId:  '$recordId'})
    wiredgetrecords({ data, error }) {
        if (data) {
            console.log('datos recibidos',data );
            var resultData = JSON.parse(data);
            this.record = JSON.parse(JSON.stringify(resultData));
            this.iscompletedfields=true;
        }else {
            console.log('Errores  ', this.error);
            this.error = error;
            this.record = undefined;

        }
    }
}