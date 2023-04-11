import { NavigationMixin } from "lightning/navigation";
import { LightningElement, wire } from "lwc";
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import searchPokemons from "@salesforce/apex/PokemonController.searchPokemons";
export default class pokemonList extends NavigationMixin(LightningElement) {
  tipo = "Todos";
  generacion = "0";
  searchTerm = "";
  orden = "Numero";
  visiblePokemons;

  @wire(searchPokemons, {
    tipo: "$tipo",
    generacion: "$generacion",
    searchTerm: "$searchTerm",
    orden: "$orden"
  })
  pokemons;

  updatePokemonHandler(event){
    this.visiblePokemons=[...event.detail.records]
    console.log(event.detail.records)
}


connectedCallback(){
  this.delayTimeout = setTimeout(() => {
    this.showToast(
      'Success',
      'Los pokemones han sido traídos con éxito!',
      'success'
    );
  }, 1500);
}

showToast(title, message, variant) {
    const event = new ShowToastEvent({
        title: title,
        message: message,
        variant: variant
    });
    this.dispatchEvent(event);
}


  // Filtros generacion y tipo
  get tipos() {
    return [
      { label: "Todos", value: "Todos" },
      { label: "Bug", value: "Bug" },
      { label: "Dark", value: "Dark" },
      { label: "Dragon", value: "Dragon" },
      { label: "Electric", value: "Electric" },
      { label: "Fairy", value: "Fairy" },
      { label: "Fighting", value: "Fighting" },
      { label: "Fire", value: "Fire" },
      { label: "Flying", value: "Flying" },
      { label: "Ghost", value: "Ghost" },
      { label: "Grass", value: "Grass" },
      { label: "Ground", value: "Ground" },
      { label: "Ice", value: "Ice" },
      { label: "Normal", value: "Normal" },     
      { label: "Poison", value: "Poison" },
      { label: "Psychic", value: "Psychic" },
      { label: "Rock", value: "Rock" },      
      { label: "Steel", value: "Steel" },     
      { label: "Water", value: "Water" }
    ];
  }

  get generaciones() {
    return [
      { label: "Todos", value: "0" },
      { label: "Primera", value: "1" },
      { label: "Segunda", value: "2" },
      { label: "Tercera", value: "3" },
      { label: "Cuarta", value: "4" },
      { label: "Quinta", value: "5" },
      { label: "Sexta", value: "6" },
      { label: "Septima", value: "7" },
      { label: "Octava", value: "8" }
    ];
  }

  get ordenar() {
    return [
      { label: "Número", value: "Numero" },
      { label: "Número ↓", value: "NumeroDesc" },
      { label: "Nombre", value: "Nombre" },
      { label: "Nombre ↓", value: "NombreDesc" },
      { label: "Tipo", value: "Tipo" },
      { label: "Tipo ↓", value: "TiposDesc" }
    ];
  }

  handleSearchTermChange(event) {
    window.clearTimeout(this.delayTimeout);
    const searchTerm = event.target.value;
    this.delayTimeout = setTimeout(() => {
      this.searchTerm = searchTerm;
    }, 100);
  }
  handleGeneracionChange(event) {
    window.clearTimeout(this.delayTimeout);
    const generacion = event.target.value;
    this.delayTimeout = setTimeout(() => {
      this.generacion = generacion;
    }, 300);
  }

  handleTipoChange(event) {
    window.clearTimeout(this.delayTimeout);
    const tipo = event.target.value;
    this.delayTimeout = setTimeout(() => {
      this.tipo = tipo;
    }, 300);
  }

  handleOrdenChange(event) {
    window.clearTimeout(this.delayTimeout);
    const orden = event.target.value;
    this.delayTimeout = setTimeout(() => {
      this.orden = orden;
    }, 300);
  }

  get hasResults() {
    
    if(this.pokemons.data.length == 0 && this.searchTerm){
        const event = new ShowToastEvent({
            title: 'Ohh ohhhh',
            message: 'No se ha encontrado ningún pokemon!',
            variant: 'Error',
        });
        this.dispatchEvent(event);   
    }
    return this.pokemons.data.length > 0;
  }
  handlePokemonView(event) {    
    const pokemonId = event.detail;
    this[NavigationMixin.GenerateUrl]({
      type: "standard__recordPage",
      attributes: {
        recordId: pokemonId,
        objectApiName: "Pokemon__c",
        actionName: "view"
      }
    }).then(url => {
      window.open(url, "_blank");
  });
  }
}