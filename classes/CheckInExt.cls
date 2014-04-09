public with sharing class CheckInExt {
	
	public Apexpages.Standardcontroller con;
	
	public CheckInExt(Apexpages.Standardcontroller controller){
		con = controller;
	}
	
	@RemoteAction
	public static void PushCheckIn(decimal lat, decimal lon){
		Action__c a = new Action__c(Location__latitude__s = lat, Location__longitude__s = lon);
		insert a;
	}
	
	@RemoteAction
	public static List<Action__c> RetrieveCheckIns(decimal lat, decimal lon){
		string query = 'SELECT Id, name, Location__Latitude__s, Location__Longitude__s ' + 
						'FROM Action__c ' +
						'WHERE DISTANCE(Location__c, GEOLOCATION('+String.valueOf(lat)+','+String.valueOf(lon)+'), \'mi\') < 50';
		system.debug('query: ' + query);
		return Database.query(query);
	}
	
	public pageReference heatmap(){
		return Page.HeatMap;
	}
	
	
}