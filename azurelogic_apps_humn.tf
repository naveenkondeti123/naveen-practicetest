flow trigger - azure evnt hub trigger
get app id - checks for application id,event id, retention period,replicationfactor,partions,


                    when events are avilable in event hub
                            |
                        get Sapp id 
                ___________________________________________________________________      
                |                    |                          |                 |   
FETCH APPLICATION OWNER       FETCH EEH ARCHITECT        FETCH IT OWNER     DELAY(30MINS)=TERMINATE
        ______________________________________________________________
        |                            |                               |            
send aproval email              send aproval email            send aproval email    
         ________________________________________________________________
         |                              |                               |
create Event/update evnt        create Event/update evnt  create Event/update evnt  
        
