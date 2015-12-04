# Magritte3
The Magritte Meta-Model ported to GemStone/GsDevKit

## GemStone Installation (Metacello)

```Smalltalk
GsDeployer
    deploy: [ 
      Metacello new
        baseline: 'Magritte3';
        repository:
            'github://GsDevKit/Magritte3:v3.?/repository';
        load: #('Seaside') ]
```

## GsDevKit_home installation (tODE)

