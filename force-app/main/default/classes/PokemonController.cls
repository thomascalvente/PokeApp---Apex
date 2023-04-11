public with sharing class PokemonController {

    @AuraEnabled(Cacheable=true)
    public static Pokemon__c[] searchPokemons(String tipo, Integer generacion
    , String searchTerm, String orden) {

        searchTerm = searchTerm.trim();

        searchTerm = '%' + searchTerm + '%';

        String query = 'SELECT Name, ExtId__c, Altura__C, Peso__c, TiposFiltrados__c, Imagen__c FROM Pokemon__c';

        if (searchTerm != '') {
        query += ' WHERE Name LIKE :searchTerm ';
        }
        if (tipo != 'Todos') {
        query += ' AND Tipos__c INCLUDES(:tipo) ';
        }
        if (generacion != 0) {
        query += ' AND Generacion__c =:generacion ';
        }
        if(orden == 'Tipo'){
            query += ' ORDER BY TiposFiltrados__c';

        }else if(orden == 'TiposDesc'){  
            query += ' ORDER BY TiposFiltrados__c DESC';
            
        }else if(orden == 'Nombre'){
            query += ' ORDER BY Name';

        }else if(orden == 'NombreDesc'){
            query += ' ORDER BY Name DESC';

        }else if(orden == 'Numero'){
            query += ' ORDER BY ExtId__c';
            
        }else{
            query += ' ORDER BY ExtId__c DESC';
        }
        

        return Database.query(query);
    }
}
