@isTest
private class GetPokemonsBatchTest {
    @testSetup
    static void setup() {
        //insert pokemon complete
        Habilidad__c habilidad = new Habilidad__c();
        habilidad.Name = 'overgrow';
        insert habilidad;
        
        Movimiento__c movimiento = new Movimiento__c();
        movimiento.Name = 'razor-wind';
        insert movimiento;
        
        Movimiento__c movimiento2 = new Movimiento__c();
        movimiento2.Name = 'swords-dance';
        insert movimiento2;
        
        Movimiento__c movimiento3 = new Movimiento__c();
        movimiento3.Name = 'cut';
        insert movimiento3;
        
        Movimiento__c movimiento4 = new Movimiento__c();
        movimiento4.Name = 'bind';
        insert movimiento4;
        
        Pokemon__c pokemon = new Pokemon__c();
        pokemon.Name = 'Bulbasaur';
        pokemon.ExtId__c = 1;
        pokemon.Altura__C = '7 mts.';
        pokemon.Peso__c = '69 kg.';
        pokemon.Tipos__c = 'Grass;Poison';
        pokemon.Vida__c = 45;
        pokemon.Defensa__c = 49;
        pokemon.Ataque__c = 49;
        pokemon.Velocidad__c = 45;
        pokemon.Imagen__c = 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/1.png';
        pokemon.Habilidad__c = habilidad.Id;
        pokemon.Slot1__c = movimiento.Id;
        pokemon.Slot2__c = movimiento2.Id;
        pokemon.Slot3__c = movimiento3.Id;
        pokemon.Slot4__c = movimiento4.Id;
        insert pokemon;
        
		
		//insert pokemon with 2 imagen
        Pokemon__c pokemon2 = new Pokemon__c();
        pokemon2.Imagen__c = 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-v/black-white/animated/1.gif';
        insert pokemon2;
        
        
        //insert pokemon with 1 move
        Movimiento__c movimiento5 = new Movimiento__c();
        movimiento5.Name = 'vine-whip';
        insert movimiento5;
        
        Pokemon__c pokemon3 = new Pokemon__c();
        pokemon3.Name = 'Charmander';
        pokemon3.Slot1__c = movimiento5.Id;
        insert pokemon3;
        
        
        //insert pokemon with 2 move
        Movimiento__c movimiento6 = new Movimiento__c();
        movimiento6.Name = 'headbutt';
        insert movimiento6;
        
        Movimiento__c movimiento7 = new Movimiento__c();
        movimiento7.Name = 'tackle';
        insert movimiento7;
        
        Pokemon__c pokemon4 = new Pokemon__c();
        pokemon4.Name = 'Charizar';
        pokemon4.Slot1__c = movimiento6.Id;
        pokemon4.Slot2__c = movimiento7.Id;
        insert pokemon4;
        
        
        //insert pokemon with 3 move
        Movimiento__c movimiento8 = new Movimiento__c();
        movimiento8.Name = 'body-slam';
        insert movimiento8;
        
        Movimiento__c movimiento9 = new Movimiento__c();
        movimiento9.Name = 'take-down';
        insert movimiento9;
        
        Movimiento__c movimiento10 = new Movimiento__c();
        movimiento10.Name = 'double-edge';
        insert movimiento10;
        
        Pokemon__c pokemon5 = new Pokemon__c();
        pokemon5.Name = 'Squirtle';
        pokemon5.Slot1__c = movimiento8.Id;
        pokemon5.Slot2__c = movimiento9.Id;
        pokemon5.Slot3__c = movimiento10.Id;
        insert pokemon5;
        
    }
    @isTest 
    static void testInsertCompletePokemon() {
        
        String responseExpected = '{"abilities":[{"ability":{"name":"overgrow","url":"https://pokeapi.co/api/v2/ability/65/"},"is_hidden":false,"slot":1}],"height":7,"id":1,"moves":[{"move":{"name":"razor-wind","url":"https://pokeapi.co/api/v2/move/13/"}},{"move":{"name":"swords-dance","url":"https://pokeapi.co/api/v2/move/14/"}},{"move":{"name":"cut","url":"https://pokeapi.co/api/v2/move/15/"}},{"move":{"name":"bind","url":"https://pokeapi.co/api/v2/move/20/"}}],"name":"bulbasaur","order":1,"sprites":{"other":{"home":{"front_default":"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/1.png"}},"versions": {"generation-v": {"black-white": {"animated": {}}}}},"stats":[{"base_stat":45,"effort":0,"stat":{"name":"hp","url":"https://pokeapi.co/api/v2/stat/1/"}},{"base_stat":49,"effort":0,"stat":{"name":"attack","url":"https://pokeapi.co/api/v2/stat/2/"}},{"base_stat":49,"effort":0,"stat":{"name":"defense","url":"https://pokeapi.co/api/v2/stat/3/"}},{"base_stat":65,"effort":1,"stat":{"name":"special-attack","url":"https://pokeapi.co/api/v2/stat/4/"}},{"base_stat":65,"effort":0,"stat":{"name":"special-defense","url":"https://pokeapi.co/api/v2/stat/5/"}},{"base_stat":45,"effort":0,"stat":{"name":"speed","url":"https://pokeapi.co/api/v2/stat/6/"}}],"types":[{"slot":1,"type":{"name":"grass","url":"https://pokeapi.co/api/v2/type/12/"}},{"slot":2,"type":{"name":"poison","url":"https://pokeapi.co/api/v2/type/4/"}}],"weight":69}';
        SingleRequestMock fakeResponse = new SingleRequestMock(200,
                                                               'OK',
                                                               responseExpected,
                                                               null);
        Test.setMock(HttpCalloutMock.class, fakeResponse);
        
        
        Test.startTest();
        List<Integer> numero = new List<Integer>{1};
            
            Database.executeBatch(new GetPokemonsBatch(numero),1);
        Test.stopTest();
        
        Pokemon__c pokemon = [SELECT Name, ExtId__c, Altura__C,
                              Peso__c, Tipos__c, Vida__c, Defensa__c, Ataque__c,
                              Velocidad__c, Imagen__c, Habilidad__c, Slot1__c, Slot2__c, Slot3__c, Slot4__c
                              FROM Pokemon__c
                              LIMIT 1];
        
        Habilidad__c habilidad = [SELECT Name
                                  FROM Habilidad__c
                                  WHERE Name = 'overgrow'
                                  LIMIT 1];
        
        Movimiento__c movimiento = [SELECT Name
                                  FROM Movimiento__c
                                  WHERE Name = 'razor-wind'
                                  LIMIT 1];
        
        Movimiento__c movimiento2 = [SELECT Name
                                  FROM Movimiento__c
                                  WHERE Name = 'swords-dance'
                                  LIMIT 1];
            
        Movimiento__c movimiento3 = [SELECT Name
                                  FROM Movimiento__c
                                  WHERE Name = 'cut'
                                  LIMIT 1];
            
        Movimiento__c movimiento4 = [SELECT Name
                                  FROM Movimiento__c
                                  WHERE Name = 'bind'
                                  LIMIT 1];
        
        System.assertEquals('Bulbasaur', pokemon.Name );
        System.assertEquals('Grass;Poison', pokemon.Tipos__c);
        System.assertEquals('https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/1.png',
                            pokemon.Imagen__c);
        System.assertEquals(1, pokemon.ExtId__c);
        System.assertEquals('69 kg.', pokemon.Peso__c);
        System.assertEquals('7 mts.', pokemon.Altura__c);
        System.assertEquals(45, pokemon.Vida__c);
        System.assertEquals(45, pokemon.Velocidad__c);
        System.assertEquals(49, pokemon.Defensa__c);
        System.assertEquals(49, pokemon.Ataque__c);
        System.assertEquals(habilidad.Id, pokemon.Habilidad__c);
        System.assertEquals(movimiento.Id, pokemon.Slot1__c);
        System.assertEquals(movimiento2.Id, pokemon.Slot2__c);
        System.assertEquals(movimiento3.Id, pokemon.Slot3__c);
        System.assertEquals(movimiento4.Id, pokemon.Slot4__c);
    }
    
    @isTest 
    static void testInsertPokemonWith2Image() {
        
        String responseExpected = '{"abilities":[{"ability":{"name":"overgrow","url":"https://pokeapi.co/api/v2/ability/65/"},"is_hidden":false,"slot":1}],"height":7,"id":1,"moves":[{"move":{"name":"razor-wind","url":"https://pokeapi.co/api/v2/move/13/"}},{"move":{"name":"swords-dance","url":"https://pokeapi.co/api/v2/move/14/"}},{"move":{"name":"cut","url":"https://pokeapi.co/api/v2/move/15/"}},{"move":{"name":"bind","url":"https://pokeapi.co/api/v2/move/20/"}}],"name":"bulbasaur","order":1,"sprites":{"other":{"home":{}},"versions": {"generation-v": {"black-white": {"animated": {"front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-v/black-white/animated/1.gif"}}}}},"stats":[{"base_stat":45,"effort":0,"stat":{"name":"hp","url":"https://pokeapi.co/api/v2/stat/1/"}},{"base_stat":49,"effort":0,"stat":{"name":"attack","url":"https://pokeapi.co/api/v2/stat/2/"}},{"base_stat":49,"effort":0,"stat":{"name":"defense","url":"https://pokeapi.co/api/v2/stat/3/"}},{"base_stat":65,"effort":1,"stat":{"name":"special-attack","url":"https://pokeapi.co/api/v2/stat/4/"}},{"base_stat":65,"effort":0,"stat":{"name":"special-defense","url":"https://pokeapi.co/api/v2/stat/5/"}},{"base_stat":45,"effort":0,"stat":{"name":"speed","url":"https://pokeapi.co/api/v2/stat/6/"}}],"types":[{"slot":1,"type":{"name":"grass","url":"https://pokeapi.co/api/v2/type/12/"}},{"slot":2,"type":{"name":"poison","url":"https://pokeapi.co/api/v2/type/4/"}}],"weight":69}';
        SingleRequestMock fakeResponse = new SingleRequestMock(200,
                                                               'OK',
                                                               responseExpected,
                                                               null);
        Test.setMock(HttpCalloutMock.class, fakeResponse);
        
        
        Test.startTest();
        List<Integer> numero = new List<Integer>{1};
            
        Database.executeBatch(new GetPokemonsBatch(numero),1);
        Test.stopTest();
        
        Pokemon__c pokemon = [SELECT Imagen__c
                              FROM Pokemon__c
                              WHERE Imagen__c = 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-v/black-white/animated/1.gif'
                              LIMIT 1];
        
        
        
        
        System.assertEquals('https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-v/black-white/animated/1.gif',
                            pokemon.Imagen__c);

    }
    @isTest 
    static void testInsertPokemonWith1Move() {
        
        String responseExpected = '{"abilities":[{"ability":{"name":"overgrow","url":"https://pokeapi.co/api/v2/ability/65/"},"is_hidden":false,"slot":1}],"height":7,"id":1,"moves":[{"move":{"name": "vine-whip","url": "https://pokeapi.co/api/v2/move/22/"}}],"name":"charmander","order":1,"sprites":{"other":{"home":{"front_default":"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/1.png"}},"versions": {"generation-v": {"black-white": {"animated": {}}}}},"stats":[{"base_stat":45,"effort":0,"stat":{"name":"hp","url":"https://pokeapi.co/api/v2/stat/1/"}},{"base_stat":49,"effort":0,"stat":{"name":"attack","url":"https://pokeapi.co/api/v2/stat/2/"}},{"base_stat":49,"effort":0,"stat":{"name":"defense","url":"https://pokeapi.co/api/v2/stat/3/"}},{"base_stat":65,"effort":1,"stat":{"name":"special-attack","url":"https://pokeapi.co/api/v2/stat/4/"}},{"base_stat":65,"effort":0,"stat":{"name":"special-defense","url":"https://pokeapi.co/api/v2/stat/5/"}},{"base_stat":45,"effort":0,"stat":{"name":"speed","url":"https://pokeapi.co/api/v2/stat/6/"}}],"types":[{"slot":1,"type":{"name":"grass","url":"https://pokeapi.co/api/v2/type/12/"}},{"slot":2,"type":{"name":"poison","url":"https://pokeapi.co/api/v2/type/4/"}}],"weight":69}';
        SingleRequestMock fakeResponse = new SingleRequestMock(200,
                                                               'OK',
                                                               responseExpected,
                                                               null);
        Test.setMock(HttpCalloutMock.class, fakeResponse);
        
        
        Test.startTest();
        List<Integer> numero = new List<Integer>{1};
            
            Database.executeBatch(new GetPokemonsBatch(numero),1);
        Test.stopTest();
        
        Pokemon__c pokemon = [SELECT Slot1__c
                              FROM Pokemon__c
                              WHERE Name = 'Charmander'
                              LIMIT 1];
        
        Movimiento__c movimiento = [SELECT Name
                                  FROM Movimiento__c
                                  WHERE Name = 'vine-whip'
                                  LIMIT 1];
        

        System.assertEquals(movimiento.Id, pokemon.Slot1__c);

    }
    @isTest 
    static void testInsertPokemonWith2Move() {
        
        String responseExpected = '{"abilities":[{"ability":{"name":"overgrow","url":"https://pokeapi.co/api/v2/ability/65/"},"is_hidden":false,"slot":1}],"height":7,"id":1,"moves":[{"move":{"name": "headbutt","url": "https://pokeapi.co/api/v2/move/29/"}},{"move":{"name": "tackle","url": "https://pokeapi.co/api/v2/move/33/"}}],"name":"charizar","order":1,"sprites":{"other":{"home":{"front_default":"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/1.png"}},"versions": {"generation-v": {"black-white": {"animated": {}}}}},"stats":[{"base_stat":45,"effort":0,"stat":{"name":"hp","url":"https://pokeapi.co/api/v2/stat/1/"}},{"base_stat":49,"effort":0,"stat":{"name":"attack","url":"https://pokeapi.co/api/v2/stat/2/"}},{"base_stat":49,"effort":0,"stat":{"name":"defense","url":"https://pokeapi.co/api/v2/stat/3/"}},{"base_stat":65,"effort":1,"stat":{"name":"special-attack","url":"https://pokeapi.co/api/v2/stat/4/"}},{"base_stat":65,"effort":0,"stat":{"name":"special-defense","url":"https://pokeapi.co/api/v2/stat/5/"}},{"base_stat":45,"effort":0,"stat":{"name":"speed","url":"https://pokeapi.co/api/v2/stat/6/"}}],"types":[{"slot":1,"type":{"name":"grass","url":"https://pokeapi.co/api/v2/type/12/"}},{"slot":2,"type":{"name":"poison","url":"https://pokeapi.co/api/v2/type/4/"}}],"weight":69}';
        SingleRequestMock fakeResponse = new SingleRequestMock(200,
                                                               'OK',
                                                               responseExpected,
                                                               null);
        Test.setMock(HttpCalloutMock.class, fakeResponse);
        
        
        Test.startTest();
        List<Integer> numero = new List<Integer>{1};
            
            Database.executeBatch(new GetPokemonsBatch(numero),1);
        Test.stopTest();
        
        Pokemon__c pokemon = [SELECT Slot1__c, Slot2__c
                              FROM Pokemon__c
                              WHERE Name = 'Charizar'
                              LIMIT 1];
        
        Movimiento__c movimiento = [SELECT Name
                                  FROM Movimiento__c
                                  WHERE Name = 'headbutt'
                                  LIMIT 1];
        
         Movimiento__c movimiento2 = [SELECT Name
                                  FROM Movimiento__c
                                  WHERE Name = 'tackle'
                                  LIMIT 1];
        

        System.assertEquals(movimiento.Id, pokemon.Slot1__c);
        System.assertEquals(movimiento2.Id, pokemon.Slot2__c);

    }
    @isTest 
    static void testInsertPokemonWith3Move() {
        
        String responseExpected = '{"abilities":[{"ability":{"name":"overgrow","url":"https://pokeapi.co/api/v2/ability/65/"},"is_hidden":false,"slot":1}],"height":7,"id":1,"moves":[{"move":{"name": "body-slam","url": "https://pokeapi.co/api/v2/move/34/"}},{"move":{"name": "take-down","url": "https://pokeapi.co/api/v2/move/36/"}},{"move":{"name": "double-edge","url": "https://pokeapi.co/api/v2/move/38/"}}],"name":"squirtle","order":1,"sprites":{"other":{"home":{"front_default":"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/1.png"}},"versions": {"generation-v": {"black-white": {"animated": {}}}}},"stats":[{"base_stat":45,"effort":0,"stat":{"name":"hp","url":"https://pokeapi.co/api/v2/stat/1/"}},{"base_stat":49,"effort":0,"stat":{"name":"attack","url":"https://pokeapi.co/api/v2/stat/2/"}},{"base_stat":49,"effort":0,"stat":{"name":"defense","url":"https://pokeapi.co/api/v2/stat/3/"}},{"base_stat":65,"effort":1,"stat":{"name":"special-attack","url":"https://pokeapi.co/api/v2/stat/4/"}},{"base_stat":65,"effort":0,"stat":{"name":"special-defense","url":"https://pokeapi.co/api/v2/stat/5/"}},{"base_stat":45,"effort":0,"stat":{"name":"speed","url":"https://pokeapi.co/api/v2/stat/6/"}}],"types":[{"slot":1,"type":{"name":"grass","url":"https://pokeapi.co/api/v2/type/12/"}},{"slot":2,"type":{"name":"poison","url":"https://pokeapi.co/api/v2/type/4/"}}],"weight":69}';
        SingleRequestMock fakeResponse = new SingleRequestMock(200,
                                                               'OK',
                                                               responseExpected,
                                                               null);
        Test.setMock(HttpCalloutMock.class, fakeResponse);
        
        
        Test.startTest();
        List<Integer> numero = new List<Integer>{1};
            
            Database.executeBatch(new GetPokemonsBatch(numero),1);
        Test.stopTest();
        
        Pokemon__c pokemon = [SELECT Slot1__c, Slot2__c, Slot3__c
                              FROM Pokemon__c
                              WHERE Name = 'Squirtle'
                              LIMIT 1];
        
        Movimiento__c movimiento = [SELECT Name
                                  FROM Movimiento__c
                                  WHERE Name = 'body-slam'
                                  LIMIT 1];
        
         Movimiento__c movimiento2 = [SELECT Name
                                  FROM Movimiento__c
                                  WHERE Name = 'take-down'
                                  LIMIT 1];
        
        Movimiento__c movimiento3 = [SELECT Name
                                  FROM Movimiento__c
                                  WHERE Name = 'double-edge'
                                  LIMIT 1];
        

        System.assertEquals(movimiento.Id, pokemon.Slot1__c);
        System.assertEquals(movimiento2.Id, pokemon.Slot2__c);
        System.assertEquals(movimiento3.Id, pokemon.Slot3__c);

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
            
            Database.executeBatch(new GetPokemonsBatch(numero),1);
        Test.stopTest();
        
        
        System.assertEquals(5, [SELECT count() FROM Pokemon__c] );
    }
}