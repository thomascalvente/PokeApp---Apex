import { LightningElement, api, wire } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import Name_FIELD from '@salesforce/schema/Pokemon__c.Name';
import ExtId_FIELD from '@salesforce/schema/Pokemon__c.ExtId__c';
import Generacion_FIELD from '@salesforce/schema/Pokemon__c.Generacion__c';
import Habilidad_FIELD from '@salesforce/schema/Pokemon__c.Habilidad__c';
import Imagen_FIELD from '@salesforce/schema/Pokemon__c.Imagen__c';
import Tipos_FIELD from '@salesforce/schema/Pokemon__c.Tipos__c';
import Altura_FIELD from '@salesforce/schema/Pokemon__c.Altura__c';
import Peso_FIELD from '@salesforce/schema/Pokemon__c.Peso__c';
import Ataque_FIELD from '@salesforce/schema/Pokemon__c.Ataque__c';
import Vida_FIELD from '@salesforce/schema/Pokemon__c.Vida__c';
import Defensa_FIELD from '@salesforce/schema/Pokemon__c.Defensa__c';
import Velocidad_FIELD from '@salesforce/schema/Pokemon__c.Velocidad__c';
import Slot1_FIELD from '@salesforce/schema/Pokemon__c.Slot1__c';
import Slot2_FIELD from '@salesforce/schema/Pokemon__c.Slot2__c';
import Slot3_FIELD from '@salesforce/schema/Pokemon__c.Slot3__c';
import Slot4_FIELD from '@salesforce/schema/Pokemon__c.Slot4__c';

export default class pokemonData extends LightningElement {
    @api recordId;
    @api objectApiName;
    imagenField;
    nameField;
    extIdField;
    generacionField = Generacion_FIELD;
    habilidadField = Habilidad_FIELD;
    tiposField = Tipos_FIELD;
    alturaField = Altura_FIELD;
    pesoField = Peso_FIELD;
    ataqueField = Ataque_FIELD;
    vidaField = Vida_FIELD;
    defensaField = Defensa_FIELD;
    velocidadField = Velocidad_FIELD;
    slot1Field = Slot1_FIELD;
    slot2Field = Slot2_FIELD;
    slot3Field = Slot3_FIELD;
    slot4Field = Slot4_FIELD;

    @wire(getRecord, {
        recordId: '$recordId',
        fields: [Imagen_FIELD,
                Name_FIELD,
                ExtId_FIELD]
    })
    pokemon({ error, data }) {
        if (data) {
            this.imagenField = getFieldValue(data, Imagen_FIELD);
            this.nameField = getFieldValue(data, Name_FIELD);
            this.extIdField = getFieldValue(data, ExtId_FIELD);
            this.error = undefined;
        } else if (error) {
            this.error = error;
        }
    }

    constructor() {
        super(); // Must be called first
        console.log(JSON.stringify(Vida_FIELD.fieldApiName.data));
    }
    
}