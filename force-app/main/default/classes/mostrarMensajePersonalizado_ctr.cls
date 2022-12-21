/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 07-27-2022
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class mostrarMensajePersonalizado_ctr {

    @AuraEnabled(cacheable=true)
    public static String getrecord(String strAccountId){
        List<Account> lstAccount = [SELECT Id,Name, Phone,(SELECT Id,Estatus__c, Codigo_error__c, Servicio__c, Informacion_recibida__c, CreatedDate FROM Log_Servicios__r ORDER BY CreatedDate DESC LIMIT 1) FROM Account WHERE Id =:strAccountId];
        GeneralStatusWrapper objDT =  new GeneralStatusWrapper();
        if(!lstAccount.isEmpty()){
            if(!lstAccount[0].Log_Servicios__r.isEmpty()){
                objDT.strfechaultimactividad=lstAccount[0].Log_Servicios__r[0].CreatedDate.format();
                objDT.strSetQuejas ='Caso no creado';
                for(Log_Servicios__c objlog:lstAccount[0].Log_Servicios__r){
                    objDT.strSetQuejas =  objlog.Servicio__c == 'SetQuejas'?'Caso Creado SFC':'Caso no creado';
                    objDT.strUpdateQuejas =  objlog.Servicio__c == 'UpdateQuejas'?'Caso Actualizado SFC':'Error actualización';
                }
            }            
            objDT.objaccount=lstAccount[0];
        }
        return JSON.serialize(objDT);
    }
        
    public class GeneralStatusWrapper {
        public String strfechaultimactividad {get;set;}
        public String strfechaCreacion {get;set;}
        public String strSetQuejas {get;set;}
        public String strUpdateQuejas {get;set;}
        public Account objaccount {get;set;}
        public GeneralStatusWrapper(){
            objaccount=new Account();
        }
    }
}
    
