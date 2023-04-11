global class GetPokemonsBatch implements Database.Batchable<Integer>, Database.AllowsCallouts, Database.Stateful {
    
    //Llamada
    /*List<Integer> numero = new List<Integer>();
    for(Integer i = 1; i<=898; i++){
    	numero.add(i);
    }
    
    
    Database.executeBatch(new GetPokemonsBatch(numero),1);*/
    
    List<Integer> cantidadPokemons = new List<Integer>();
    
    public GetPokemonsBatch(List<Integer> cantidadPokemons){
        this.cantidadPokemons = cantidadPokemons;
    }
    
    global Iterable<Integer> start(Database.BatchableContext bc) {       
        return cantidadPokemons;
    }
    
    global void execute(Database.BatchableContext bc, List<Integer> cantidadPokemons){
        //List<Pokemon__c> pokemones = new List<Pokemon__c>();
        try {
            
            Http http = new Http();
            
            HttpRequest request = new HttpRequest();                
            request.setEndpoint('https://pokeapi.co/api/v2/pokemon/'+cantidadPokemons[0]);
            request.setMethod('GET');
            request.setHeader('Accept', 'application/json');
            
            HttpResponse response = http.send(request);
            
            Map<String, Object> results = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
            
            Pokemon__c pokemon = new Pokemon__c();
            String name = (string) results.get('name');
            pokemon.Name = name.Capitalize();
            pokemon.Altura__c = (Integer) results.get('height')+ ' mts.';
            pokemon.Peso__c = (Integer) results.get('weight')+ ' kg.';
            pokemon.ExtId__c = (Integer) results.get('id');
            
            
            
            
            Map<String, Object> sprites = (Map<String,Object>) results.get('sprites');
            Map<String, Object> sprite = (Map<String,Object>) sprites.get('other');
            Map<String, Object> spriteHome = (Map<String,Object>) sprite.get('home');
            
            Map<String, Object> spriteGif = (Map<String,Object>) sprites.get('versions');
            Map<String, Object> spriteGeneracion5 = (Map<String,Object>) spriteGif.get('generation-v');
            Map<String, Object> spriteBlackWhite = (Map<String,Object>) spriteGeneracion5.get('black-white');
            Map<String, Object> spriteAnimated = (Map<String,Object>) spriteBlackWhite.get('animated');
            
            pokemon.Imagen__c = (String) spriteAnimated.get('front_default') == null
                ? (String) spriteHome.get('front_default')
                : (String) spriteAnimated.get('front_default');
            
            
            
            
            List<Object>stats = (List<Object>) results.get('stats');          
            for(Integer i = 0; i < stats.size(); i++){
                Map<String, Object> statt = (Map<String,Object>) stats[i];
                Map<String, Object> estadistica = (Map<String,Object>) statt.get('stat');
                String statName = (String) estadistica.get('name');
                if(statName.equals('hp')){        
                    pokemon.Vida__c = (Integer) statt.get('base_stat');
                }else if(statName.equals('attack')){
                    pokemon.Ataque__c = (Integer) statt.get('base_stat');
                }else if(statName.equals('defense')){
                    pokemon.Defensa__c = (Integer) statt.get('base_stat');
                }else if(statName.equals('speed')){
                    pokemon.Velocidad__c = (Integer) statt.get('base_stat');
                }               
            }
            
            
            
            List<Object> habilidades = (List<Object>) results.get('abilities');
            Map<String,Object> habilidadAleatoria = (Map<String,Object>) habilidades.get(Integer.valueOf(Math.random()*habilidades.size()));
            Map<String,Object> habilidad = (Map<String,Object>) habilidadAleatoria.get('ability');
            String habilidadNombre = (String) habilidad.get('name');
            
            Habilidad__c encontrarHabilidad = [SELECT Id 
                                               FROM Habilidad__c
                                               WHERE Name = :habilidadNombre.capitalize()
                                               LIMIT 1];
            
            pokemon.Habilidad__c = encontrarHabilidad.Id;
            
            
            
            
            List<Object> tipos = (List<Object>) results.get('types');                
            for(integer i = 0; i < tipos.size(); i++){
                
                Map<String, Object> tipo = (Map<String,Object>) tipos[i];
                Map<String, Object> tipoNombre = (Map<String,Object>) tipo.get('type');
                String nombre = (String) tipoNombre.get('name');
                pokemon.Tipos__c = pokemon.Tipos__c == null
                    ? nombre.capitalize()
                    : pokemon.Tipos__c + ';' + nombre.capitalize();
                pokemon.TiposFiltrados__c = pokemon.TiposFiltrados__c == null
                    ? nombre.capitalize()
                    : pokemon.TiposFiltrados__c + '-' + nombre.capitalize(); 
            }
            
            
            
            
            List<Object> movimientos = (List<Object>) results.get('moves');
            Set<Integer> numeros = new Set<Integer>();
            
            while(numeros.size()<movimientos.size()){
                Integer numeroAleatorio = Integer.valueof((Math.random() * movimientos.size()));
                numeros.add(numeroAleatorio);
            }    
            
            List<Integer> hashSetNumeros = new List<Integer>(numeros); 
            
            for(Integer j = 0; j < movimientos.size(); j++){
                
                Map<String,Object> movimientoAleatorio = (Map<String,Object>) movimientos.get(hashSetNumeros[j]);
                Map<String, Object> movimiento = (Map<String,Object>) movimientoAleatorio.get('move');
                String movimientoNombre = (String) movimiento.get('name');
                
                switch on j{
                    when 0{
                        Movimiento__c encontrarMovimiento = [SELECT Id 
                                                             FROM  Movimiento__c
                                                             WHERE Name = :movimientoNombre.capitalize()
                                                             LIMIT 1];
                        pokemon.Slot1__c = encontrarMovimiento.Id;
                    } 
                    when 1{
                        Movimiento__c encontrarMovimiento = [SELECT Id 
                                                             FROM  Movimiento__c
                                                             WHERE Name = :movimientoNombre.capitalize()
                                                             LIMIT 1];
                        pokemon.Slot2__c = encontrarMovimiento.Id;
                    }
                    when 2{
                        Movimiento__c encontrarMovimiento = [SELECT Id 
                                                             FROM  Movimiento__c
                                                             WHERE Name = :movimientoNombre.capitalize()
                                                             LIMIT 1];
                        pokemon.Slot3__c = encontrarMovimiento.Id;
                    }
                    when 3{
                        Movimiento__c encontrarMovimiento = [SELECT Id 
                                                             FROM  Movimiento__c
                                                             WHERE Name = :movimientoNombre.capitalize()
                                                             LIMIT 1];
                        pokemon.Slot4__c = encontrarMovimiento.Id;
                        break;
                    }
                }
            }    
            
            //pokemones.add(pokemon);
            //System.debug(pokemones);
            insert pokemon;
        } catch (Exception e) {
            System.debug('ERROR :' + e.getMessage());
        }
    }
    global void finish(Database.BatchableContext bc){
        System.debug('Batch GetPokemons finalizado satisfactoriamente');
    }
}