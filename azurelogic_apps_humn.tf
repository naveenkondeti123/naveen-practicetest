flow trigger - azure evnt hub trigger
get app id - get for application id,event id, retention period,replicationfactor,partions,
fetch application owner details - it willl Get owner details
email outlook -send email for  true =create evant(a/dny)  false = create update event (approve/deny)



                    when events are avilable in event hub
                            |
                        get Sapp id 
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
   
        
