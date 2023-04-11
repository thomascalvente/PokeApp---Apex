@isTest
private class GetMovesBatchTest {

    @isTest 
    static void testParameterNotNull() {
        
        String responseExpected = '{"accuracy":100,"effect_chance":10,"effect_entries":[{"effect":"Inflicts regular damage.  Has a $effect_chance% chance to freeze the target.","language":{"name":"en","url":"https://pokeapi.co/api/v2/language/9/"},"short_effect":"Has a $effect_chance% chance to freeze the target."}],"id":8,"name":"ice-punch","power":75,"pp":15,"priority":0,"target":{"name":"selected-pokemon","url":"https://pokeapi.co/api/v2/move-target/10/"},"type":{"name":"ice","url":"https://pokeapi.co/api/v2/type/15/"}}';
        SingleRequestMock fakeResponse = new SingleRequestMock(200,
                                                               'OK',
                                                               responseExpected,
                                                               null);
        Test.setMock(HttpCalloutMock.class, fakeResponse); 
        Test.startTest();
            List<Integer> numero = new List<Integer>{8};
            Database.executeBatch(new GetMovesBatch(numero),1);
        Test.stopTest();
        Movimiento__c movimiento = [SELECT Name, ExtId__c, pp__C, Punteria__c, Prioridad__c, Poder__c, Chance_de_Efecto__c, Efecto__c
                                    FROM Movimiento__c
                                    WHERE Name = 'Ice-punch'
                                    LIMIT 1];
        
        System.assertEquals('Ice-punch', movimiento.Name );
        System.assertEquals(8, movimiento.ExtId__c);
        System.assertEquals(15, movimiento.pp__c);
        System.assertEquals(100, movimiento.Punteria__c);
        System.assertEquals(0, movimiento.Prioridad__c);
        System.assertEquals(75, movimiento.Poder__c);
        System.assertEquals(10, movimiento.Chance_de_Efecto__c);
        System.assertEquals('Has a $effect_chance% chance to freeze the target.', movimiento.Efecto__c);
    } 
    
    @isTest 
    static void testParametersNull() {
        
        
        String responseExpected = '{"accuracy":null,"effect_chance":null,"effect_entries":[{"effect":"Inflicts regular damage.","language":{"name":"en","url":"https://pokeapi.co/api/v2/language/9/"},"short_effect":"Inflicts regular damage with no additional effect."}],"id":1,"name":"pound","power":null,"pp":null,"priority":null,"target":{"name":"selected-pokemon","url":"https://pokeapi.co/api/v2/move-target/10/"},"type":{"name":"normal","url":"https://pokeapi.co/api/v2/type/1/"}}';
        SingleRequestMock fakeResponse = new SingleRequestMock(200,
                                                               'OK',
                                                               responseExpected,
                                                               null);
        Test.setMock(HttpCalloutMock.class, fakeResponse); 
        Test.startTest();
            List<Integer> numero = new List<Integer>{1};
            Database.executeBatch(new GetMovesBatch(numero),1);
        Test.stopTest();
        Movimiento__c movimiento = [SELECT Name, ExtId__c, pp__C, Punteria__c, Prioridad__c, Poder__c, Chance_de_Efecto__c, Efecto__c
                                    FROM Movimiento__c
                                    WHERE Name = 'Pound'
                                    LIMIT 1];
        
        System.assertEquals('Pound', movimiento.Name );
        System.assertEquals(1, movimiento.ExtId__c);
        System.assertEquals(0, movimiento.pp__c);
        System.assertEquals(0, movimiento.Punteria__c);
        System.assertEquals(0, movimiento.Prioridad__c);
        System.assertEquals(0, movimiento.Poder__c);
        System.assertEquals(0, movimiento.Chance_de_Efecto__c);
        System.assertEquals('Inflicts regular damage with no additional effect.', movimiento.Efecto__c);
    }
    
    @isTest 
    static void effectEntriesTestEmpty () {
        
        
        String responseExpected = '{"accuracy":null,"effect_chance":null,"effect_entries":[],"id":1,"name":"pound","power":null,"pp":null,"priority":null,"target":{"name":"selected-pokemon","url":"https://pokeapi.co/api/v2/move-target/10/"},"type":{"name":"normal","url":"https://pokeapi.co/api/v2/type/1/"}}';
        SingleRequestMock fakeResponse = new SingleRequestMock(200,
                                                               'OK',
                                                               responseExpected,
                                                               null);
        Test.setMock(HttpCalloutMock.class, fakeResponse); 
        Test.startTest();
            List<Integer> numero = new List<Integer>{1};
            Database.executeBatch(new GetMovesBatch(numero),1);
        Test.stopTest();
        Movimiento__c movimiento = [SELECT Name, ExtId__c, pp__C, Punteria__c, Prioridad__c, Poder__c, Chance_de_Efecto__c, Efecto__c
                                    FROM Movimiento__c
                                    WHERE Name = 'Pound'
                                    LIMIT 1];
        
        System.assertEquals('Pound', movimiento.Name );
        System.assertEquals(1, movimiento.ExtId__c);
        System.assertEquals(0, movimiento.pp__c);
        System.assertEquals(0, movimiento.Punteria__c);
        System.assertEquals(0, movimiento.Prioridad__c);
        System.assertEquals(0, movimiento.Poder__c);
        System.assertEquals(0, movimiento.Chance_de_Efecto__c);
        System.assertEquals(null, movimiento.Efecto__c);
    }
    
    @isTest 
    static void differentLanguageEffectEntriesTestToEnglish () {
        
        
        String responseExpected = '{"accuracy":100,"effect_chance":10,"effect_entries":[{"effect":"Inflicts regular damage.  Has a $effect_chance% chance to freeze the target.","language":{"name":"de","url":"https://pokeapi.co/api/v2/language/9/"},"short_effect":"Has a $effect_chance% chance to freeze the target."}],"id":8,"name":"ice-punch","power":75,"pp":15,"priority":0,"target":{"name":"selected-pokemon","url":"https://pokeapi.co/api/v2/move-target/10/"},"type":{"name":"ice","url":"https://pokeapi.co/api/v2/type/15/"}}';
        SingleRequestMock fakeResponse = new SingleRequestMock(200,
                                                               'OK',
                                                               responseExpected,
                                                               null);
        Test.setMock(HttpCalloutMock.class, fakeResponse); 
        Test.startTest();
            List<Integer> numero = new List<Integer>{8};
            Database.executeBatch(new GetMovesBatch(numero),1);
        Test.stopTest();
        Movimiento__c movimiento = [SELECT Name, ExtId__c, pp__C, Punteria__c, Prioridad__c, Poder__c, Chance_de_Efecto__c, Efecto__c
                                    FROM Movimiento__c
                                    WHERE Name = 'Ice-punch'
                                    LIMIT 1];
        
        System.assertEquals('Ice-punch', movimiento.Name );
        System.assertEquals(8, movimiento.ExtId__c);
        System.assertEquals(15, movimiento.pp__c);
        System.assertEquals(100, movimiento.Punteria__c);
        System.assertEquals(0, movimiento.Prioridad__c);
        System.assertEquals(75, movimiento.Poder__c);
        System.assertEquals(10, movimiento.Chance_de_Efecto__c);
        System.assertEquals(null, movimiento.Efecto__c);
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
            Database.executeBatch(new GetMovesBatch(numero),1);
        Test.stopTest();
        
        
        System.assertEquals(0, [SELECT count() FROM Movimiento__c] );
    }
}