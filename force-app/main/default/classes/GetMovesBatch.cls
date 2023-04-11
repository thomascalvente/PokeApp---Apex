global class GetMovesBatch implements Database.Batchable<Integer>, Database.AllowsCallouts, Database.Stateful {
    
    //Llamada
    /*List<Integer> numero = new List<Integer>();
    for(Integer i = 1; i<=826; i++){
        numero.add(i);
    }
    
    
    Database.executeBatch(new GetMovesBatch(numero),1);*/
    
    List<Integer> cantidadMovimientos = new List<Integer>();
    public GetMovesBatch(List<Integer> cantidadMovimientos){
        this.cantidadMovimientos = cantidadMovimientos;
    }
    
    global Iterable<Integer> start(Database.BatchableContext bc) {       
        return cantidadMovimientos;
    }
    
    global void execute(Database.BatchableContext bc, List<Integer> cantidadMovimientos){
        //List<Movimiento__c> movimientos = new List<Movimiento__c>();
        try {
            
            Http http = new Http();
            
            HttpRequest request = new HttpRequest();                
            request.setEndpoint('https://pokeapi.co/api/v2/move/'+cantidadMovimientos[0]);
            request.setMethod('GET');
            request.setHeader('Accept', 'application/json');
            
            HttpResponse response = http.send(request);
            
            Map<String, Object> results = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
            
            Movimiento__c movimiento = new Movimiento__c();
            String name = (string) results.get('name');
            movimiento.Name = name.Capitalize();
            movimiento.ExtId__c = (Integer) results.get('id');
            movimiento.Punteria__c = (Integer) results.get('accuracy') == null
                ? 0
                : (Integer) results.get('accuracy');
            movimiento.Chance_de_Efecto__c = (Integer) results.get('effect_chance') == null 
                ? 0 
                : (Integer) results.get('effect_chance');
            
            movimiento.Prioridad__c = (Integer) results.get('priority') == null
                ? 0
                : (Integer) results.get('priority');
            
            movimiento.Poder__c = (Integer) results.get('power') == null
                ? 0
                : (Integer) results.get('power');
            movimiento.Pp__c = (Integer) results.get('pp') == null
                ? 0
                : (Integer) results.get('pp');
            
            
            
            
            Map<String, Object> target = (Map<String, Object>) results.get('target');
            movimiento.Objetivo__c = (String) target.get('name');
            
            

            
            
            List<Object> effectEntries =(List<Object>) results.get('effect_entries');
            if (effectEntries.size() > 0 ){
                for(Integer i = 0; i < effectEntries.size(); i++){
                    Map<String,Object> searchEnglish = (Map<String,Object>) effectEntries.get(i);
                    Map<String,Object> language = (Map<String,Object>) searchEnglish.get('language');
                    String languageName = (String) language.get('name');
                    if (languageName.equals('en')){
                        movimiento.Efecto__c = (String) searchEnglish.get('short_effect');
                    } else {
                        movimiento.Efecto__c = '';
                    }
                }
            }else{
                movimiento.Efecto__c = '';
            } 
            
            
            
            
            
            Map<String, Object> tipo = (Map<String, Object>) results.get('type'); 
            movimiento.Tipo__c = (String) tipo.get('name');
            
            //movimientos.add(movimiento);
            //system.debug(movimientos);
            insert movimiento;
        } catch (Exception e) {
            System.debug('ERROR :' + e.getMessage());
        }
    }
    
    global void finish(Database.BatchableContext bc){
        System.debug('Batch GetMoves finalizado satisfactoriamente');
    }
}