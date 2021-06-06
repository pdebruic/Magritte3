# Magritte3 [![Build Status](https://github.com/GsDevKitMagritte3/actions/workflows/ci.yml/badge.svg?branch=gemstone)](https://github.com/GsDevKit/Magritte3/actions/workflows/ci.yml)

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
 project install --url=http://gsdevkit.github.io/GsDevKit_home/Seaside3.ston
 project install --url=http://gsdevkit.github.io/GsDevKit_home/Magritte3.ston
 # load Magritte3
 project load --loads=\`#('Seaside')\`Magritte3
 # load Seaside3 (to get Zinc web server) 
 project load --loads=\`#( 'Zinc' )\` Seaside3
 project list
 # mount Magritte3 tODE script directory
 mount @/sys/stone/dirs/Magritte3/gsDevKit/magritte /home magritte
 bu backup magritte.dbf
 # register and launch a Seaside web server (see 'home/magritte/seasideWebServer -h' for more info)
 /home/magritte/seasideWebServer --register=seaside --type=zinc --port=1750
 /home/magritte/seasideWebServer --start=seaside
EOF
```

```
http://localhost:1750/magritte/editor
```
