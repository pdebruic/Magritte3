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

```
createStone magritte 3.2.12
devKitCommandLine todeIt magritte << EOF
 # clone Magritte3 and Seaside3 projects
 project install --url=http://gsdevkit.github.io/GsDevKit_home/Magritte3.ston
 # load Magritte3
 project load Magritte3
 # load Seaside3 
 project load --loads=\`#( 'Zinc' )\` Seaside3
 project list
 # mount Magritte3 tODE script directory
 mount @/sys/stone/dirs/Magritte3/gsDevKit/magritte /home magritte
 bu backup magritte.dbf
 # register and launch a Seaside gemServer
 /home/magritte/gemServer --register=seaside --type=zinc --port=1750
 /home/magritte/gemServer --start=seaside
EOF
```
