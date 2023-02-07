public with sharing class FromMovingToTotal {

    public static void FromMovingToTotal(){
        List<Goods_moving__c> goodsRecords =[SELECT Id,FromStorage__c,Name,ToStorage__c, Donation__c FROM Goods_moving__c];
        for(Goods_moving__c good : goodsRecords){
            
            StorageItems__c[] item = [SELECT Name, Storage__c, Product__c, Quantity__c FROM StorageItems__c WHERE Storage__c =: good.ToStorage__c];
            if(item.size() >0){
                Goods__c quan = [SELECT Quantity__c, Donation__c FROM Goods__c WHERE Donation__c =: good.Donation__c];
                Decimal count =  quan.Quantity__c;
                item[0].Quantity__c += count;
                if((Decimal) item[0].Quantity__c <= 0){
                    delete  item[0];
                }
                else{
                    update item[0];
                }}
            else{
            
               	Goods__c[] goods = [SELECT NameOfProduct__c, Quantity__c FROM Goods__c WHERE Moving__c =: good.Id];
                if(goods.size()>0){
                String nameOfP = (String) goods[0].NameOfProduct__c;
                Decimal quantity = (Decimal) goods[0].Quantity__c;
                //Product__c product = [SELECT Name FROM Product__c WHERE Id =: (Id) nameOfP];
                StorageItems__c newItem = new StorageItems__c(
                Product__c = nameOfP,
                Quantity__c = quantity,
                Storage__c = good.ToStorage__c
                );
               insert newItem;
                }

            }

            
        }

    }
    
}