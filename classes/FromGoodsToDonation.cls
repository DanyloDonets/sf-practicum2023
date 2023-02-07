public class FromGoodsToDonation {
    @AuraEnabled

    public static String FromGoodsToDonation(Id donationId){

        List <Goods__c> goodRecord = [SELECT Product__r.Name, Quantity__c, Units__c FROM Goods__c WHERE Donation__c = :donationId];
        Integer numberOfGood = 1;
        String description ='';
        for (Goods__c good : goodRecord) {
            description += numberOfGood + '. ' + ' ' + good.Product__r.Name + ' – ' + good.Quantity__c + ' ' + good.Units__c + ';' + '\n';
            numberOfGood++;
        }

        return description;
    }
}