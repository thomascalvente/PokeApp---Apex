@isTest
private class GetAbilitiesBatchTest {

    
    @isTest 
    static void testEffectEntries() {
        
        String responseExpected = '{"effect_entries":[{"effect":"Attacken die Schaden","language":{"name":"de","url":"https://pokeapi.co/api/v2/language/6/"},"short_effect":"Mit jedem Treffer"},{"effect":"This Pokemons damaging move.","language":{"name":"en","url":"https://pokeapi.co/api/v2/language/9/"},"short_effect":"Has a 10% chance of making target Pokémon flinch with each hit."}],"id":1,"name":"stench"}';
        SingleRequestMock fakeResponse = new SingleRequestMock(200,
                                                               'OK',
                                                               responseExpected,
                                                               null);
        Test.setMock(HttpCalloutMock.class, fakeResponse); 
        
        Test.startTest();
        List<Integer> numero = new List<Integer>{1};
            
            Database.executeBatch(new GetAbilitiesBatch(numero),1);
        Test.stopTest();
        
        Habilidad__c habilidad = [SELECT Name, ExtId__c, Efecto__c 
                                  FROM Habilidad__c 
                                  WHERE Name = 'Stench'
                                  LIMIT 1];
        System.assertEquals('Stench', habilidad.Name);
        System.assertEquals(1, habilidad.ExtId__c);
        System.assertEquals('Has a 10% chance of making target Pokémon flinch with each hit.', habilidad.Efecto__c);
        
    }
    @isTest 
    static void testIfEmptyEffectEntries () {
        
        String responseExpected = '{"effect_entries":[], "id":2,"name":"stench"}';
        SingleRequestMock fakeResponse = new SingleRequestMock(200,
                                                               'OK',
                                                               responseExpected,
                                                               null);
        Test.setMock(HttpCalloutMock.class, fakeResponse); 
        Test.startTest();
        List<Integer> numero = new List<Integer>{1};
            
            Database.executeBatch(new GetAbilitiesBatch(numero),1);
        Test.stopTest();
        Habilidad__c habilidad = [SELECT Name, ExtId__c, Efecto__c 
                                  FROM Habilidad__c
                                  WHERE Name = 'Stench'
                                  LIMIT 1];
        
        System.assertEquals('Stench', habilidad.Name);
        System.assertEquals(2, habilidad.ExtId__c);
        System.assertEquals(null, habilidad.Efecto__c);
    }
    @isTest 
    static void testNoResponse() {
        
        SingleRequestMock fakeResponse = new SingleRequestMock(404,
                                                               'Not Found',
                                                               '',
                                                               null);
        Test.setMock(HttpCalloutMock.class, fakeResponse); 
        
        Test.startTest();
        List<Integer> numero = new List<Integer>{990};
            
        Database.executeBatch(new GetAbilitiesBatch(numero),1);
        Test.stopTest();
        
        System.assertEquals(0, [SELECT count() FROM Habilidad__c]);
    }
}