@isTest
private class PokemonControllerTest {
    
    @testSetup
    static void setup() {     
        
        Pokemon__c pokemon = new Pokemon__c(Name='Charmander', ExtId__c=4, Tipos__c='Fire');
        insert pokemon;      
    }
    
   @istest
    static void queryWithDefaultParameters(){
        
        Test.startTest();
        	List<Pokemon__c> pokemons = PokemonController.searchPokemons('Todos',0,'','');
        Test.stopTest();
        
        system.assertEquals(pokemons.size(),1);
        system.assertEquals(pokemons[0],[SELECT Id, Generacion__c, Name, ExtId__c, Tipos__c 
                                         FROM Pokemon__c 
                                         WHERE ExtId__c = 4]);
    }
    
    @istest
    static void queryWhithFullParameters(){
        
        Test.startTest();
        	List<Pokemon__c> pokemons = PokemonController.searchPokemons('Fire',1,'a','Numero');
        Test.stopTest();
        
        system.assertEquals(pokemons.size(),1);
        system.assertEquals(pokemons[0],[SELECT Id, Generacion__c, Name, ExtId__c, Tipos__c 
                                         FROM Pokemon__c 
                                         WHERE ExtId__c = 4]);

    }
    
    @istest
    static void queryWhithOrderByName(){
        
        Test.startTest();
        	List<Pokemon__c> pokemons = PokemonController.searchPokemons('Fire',1,'a','Nombre');
        Test.stopTest();
        
        system.assertEquals(pokemons.size(),1);
        system.assertEquals(pokemons[0],[SELECT Id, Generacion__c, Name, ExtId__c, Tipos__c 
                                         FROM Pokemon__c 
                                         WHERE ExtId__c = 4]);

    }
    
    @istest
    static void queryWhithOrderByNamesDesc(){
        
        Test.startTest();
        	List<Pokemon__c> pokemons = PokemonController.searchPokemons('Fire',1,'','NombreDesc');
        Test.stopTest();
        
        system.assertEquals(pokemons.size(),1);
        system.assertEquals(pokemons[0],[SELECT Id, Generacion__c, Name, ExtId__c, Tipos__c 
                                         FROM Pokemon__c 
                                         WHERE ExtId__c = 4]);
    }
    
    @istest
    static void queryWhithOrderByTypes(){
        
        Test.startTest();
        	List<Pokemon__c> pokemons = PokemonController.searchPokemons('Fire',1,'','Tipo');
        Test.stopTest();
        
        system.assertEquals(pokemons.size(),1);
        system.assertEquals(pokemons[0],[SELECT Id, Generacion__c, Name, ExtId__c, Tipos__c 
                                         FROM Pokemon__c 
                                         WHERE ExtId__c = 4]);
    }
    
    @istest
    static void queryWhithOrderByTypesDesc(){
        
        Test.startTest();
        	List<Pokemon__c> pokemons = PokemonController.searchPokemons('Fire',1,'','TiposDesc');
        Test.stopTest();
        
        system.assertEquals(pokemons.size(),1);
        system.assertEquals(pokemons[0],[SELECT Id, Generacion__c, Name, ExtId__c, Tipos__c 
                                         FROM Pokemon__c 
                                         WHERE ExtId__c = 4]);
    }   

}