@isTest
private class FromGoodsToDonationTest {
    @TestSetup
    static void initData() {
        Account acc = new Account(Name = 'IBM');
        insert acc;
        Account search = new Account(name='asd');
        insert search;
        List<Donation__c> donations  = new List<Donation__c>();
        donations.add(new Donation__c(
                DescriptionOfDonate__c = '',
                Account__c = acc.Id,
                Date__c = DateTime.now()));

        donations.add(new Donation__c(
                DescriptionOfDonate__c = '',
                Account__c =search.Id,
                Date__c = DateTime.now()));
        insert donations;
        Donation__c account = [SELECT Id FROM Donation__c WHERE Account__r.Name = 'asd'];

        List <Goods__c> goods = new List<Goods__c>();

            goods.add(new Goods__c(
                    Donation__c = (Id) account.Id,
                    Quantity__c=20
            ));
            goods.add(new Goods__c(
                    Donation__c = (Id) account.Id,
                    Quantity__c=30
            ));
            goods.add(new Goods__c(
                    Donation__c = (Id) account.Id,
                    Quantity__c=40
            ));

        insert goods;

    }

    @isTest static void FromGoodsToDonationPositiveTest(){


        List<Donation__c> donationRecords = [SELECT Id FROM Donation__c];
        System.assert(donationRecords.size() > 0, 'DonationList should not be empty');
        for(Donation__c donations : donationRecords) {
            Id donationId = donations.Id;
            List <Goods__c> goodRecord = [SELECT Product__r.Name, Quantity__c, Units__c FROM Goods__c WHERE Donation__c = :donationId];
            If(goodRecord.size() > 0){
                continue;
            }

            String description = FromGoodsToDonation.FromGoodsToDonation(donationId);
            System.assert(description != null, 'description is null');
        }


    }

    @isTest static void FromGoodsToDonationNegativeTest(){
        List<Donation__c> donationRecords = [SELECT Id FROM Donation__c];
        System.assert(donationRecords.size() > 0, 'DonationList should not be empty');
        for(Donation__c donations : donationRecords) {
            Id donationId = donations.Id;
            List <Goods__c> goodRecord = [SELECT Product__r.Name, Quantity__c, Units__c FROM Goods__c WHERE Donation__c = :donationId];
            If(goodRecord.size() < 0){
                continue;
            }
            String description = FromGoodsToDonation.FromGoodsToDonation(donationId);
            System.assert(description != null, 'description is null');
        }
    }




}