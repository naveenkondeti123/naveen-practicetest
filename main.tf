apiVerssion:platform.conflunet.io/v1
kind: deploymet
metadata:
    name: schemaregistrey
    namespace: eeh-platform-dev

spec
    replicas:4
        resources:
         limits:
          memory:
          cpu:
         requests:
          memory:
          cpu:
        affinity:
           nodeAffinity:
             requriedDuringSheduleIgnoreDuringExcution:
            podAntiAffinity:
              preferredDuringShedulingIgnoreDuringExcution:
                podAffinityTerm:
                  labelselectors:
                    -key: app


  images:
   application:
   pullSecretRef:

dependcies:
  kafka:
    bootstrapendpoint:
    authectication:
     type:oauth



        