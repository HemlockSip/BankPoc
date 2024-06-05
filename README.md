# POC

This PoC is created by considering a Service Cloud environment that has no access to any Sales Cloud feature.


Enabled State/Territory Picklists for ease of maintenance. 


Global Value Set "Home Country". Values as the full name of the Country for better UX, API Names are the ISO codes to allow easier system integration in case Country Names differ from System to System



# Solution One
LWC That displays every info though queries


# Solution Two
Product__c is a Lookup instead of a Picklist and the Lookup has a filter that prevents connecting the wrong Product Records because is it Based on the Home Country field


# Solution 3?
This would be a native component on the UI to display related records fields
