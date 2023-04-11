global class GetAbilitiesBatch implements Database.Batchable<Integer>, Database.AllowsCallouts, Database.Stateful {
    
    //Llamada
    /*List<Integer> numero = new List<Integer>();
    for(Integer i = 1; i<=267; i++){
        numero.add(i);
    }
    
    
    Database.executeBatch(new GetAbilitiesBatch(numero),1);*/
    
    List<Integer> cantidadHabilidades = new List<Integer>();
    public GetAbilitiesBatch(List<Integer> cantidadHabilidades){
        this.cantidadHabilidades = cantidadHabilidades;
    }
    
    global Iterable<Integer> start(Database.BatchableContext bc) {       
        return cantidadHabilidades;
    }
    
    global void execute(Database.BatchableContext bc, List<Integer> cantidadHabilidades){
        //List<Habilidad__c> habilidades = new List<Habilidad__c>();
        try {
   
            Http http = new Http();
            
            HttpRequest request = new HttpRequest();                
            request.setEndpoint('https://pokeapi.co/api/v2/ability/'+cantidadHabilidades[0]);
            request.setMethod('GET');
            request.setHeader('Accept', 'application/json');
            
            HttpResponse response = http.send(request);
            
            Map<String, Object> results = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
            
            Habilidad__c habilidad = new Habilidad__c();
            String name = (string) results.get('name');
            habilidad.Name = name.Capitalize();
            habilidad.ExtId__c = (Integer) results.get('id');
            
            
            
               
            
            List<Object> effectEntries =(List<Object>) results.get('effect_entries');
            if (effectEntries.size() > 0 ){
                for(Integer i = 0; i < effectEntries.size(); i++){
                    Map<String,Object> searchEnglish = (Map<String,Object>) effectEntries.get(i);
                    Map<String,Object> language = (Map<String,Object>) searchEnglish.get('language');
                    String languageName = (String) language.get('name');
                    if (languageName.equals('en')){
                        habilidad.Efecto__c = (String) searchEnglish.get('short_effect');
                    } else {
                        habilidad.Efecto__c = '';
                    }
                }
            }else{
                habilidad.Efecto__c = '';
            } 
            
            
            
			//habilidades.add(habilidad);
            //system.debug(habilidades);
            insert habilidad;
        } catch (Exception e) {
            System.debug('ERROR :' + e.getMessage());
        }
    }
    
	global void finish(Database.BatchableContext bc){
        System.debug('Batch GetAbilities finalizado satisfactoriamente');
    }
}