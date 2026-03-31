event approval workflow

flow trigger - azure evnt hub trigger
get app id - get for application id,event id, retention period,replicationfactor,partions,
fetch application owner details - it willl Get owner details
email outlook -send email for  true =create evant(a/dny)  false = create update event (approve/deny)
 connections = outlook / event hub (Azure Event Hubs is a big data streaming platform used to ingest and process millions of events per second in real time.)

![image alt](https://github.com/naveenkondeti123/naveen-practicetest/blob/e31af076a3024bc6c5d3f87397ab503a435b3726/WhatsApp%20Image%202026-03-31%20at%2010.00.28%20AM.jpeg)

                         event hub (when events are avilable in)
                            |
                        get app id  (get details)
                ___________________________________________________________________      
                |                    |                          |                 |   
FETCH APPLICATION OWNER       FETCH EEH ARCHITECT        FETCH IT OWNER     DELAY(30MINS)=TERMINATE
        ______________________________________________________________
        |                            |                               |            
send aproval email (T/F)             send aproval email            send aproval email  
         ________________________________________________________________
         |                              |                               |
      true  false                  true  false                      true  false
create Event-update evnt        create Event/update evnt       createEvent/update evnt  
        _________________________________________________________________________
        |                                 |                                     |
onwer aprooval/denail audit report     owner  A/D                                                   
   
        
