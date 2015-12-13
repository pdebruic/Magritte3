baseline
baseline: spec
  <baseline>
  spec
    for: #'common'
      do: [ 
          spec
            package: 'Magritte-Model' with: [ spec requires: #('Grease') ];
            package: 'Magritte-Tests-Model'
              with: [ spec requires: #('Magritte-Model') ];
            package: 'Magritte-Seaside'
              with: [ spec requires: #('Magritte-Model' 'Seaside3') ];
            package: 'Magritte-Deprecated'
              with: [ spec requires: #('Magritte-Model') ];
            yourself.
          spec
            group: 'default' with: #('Core');
            group: 'Core' with: #('Magritte-Model');
            group: 'Tests' with: #('Magritte-Tests-Model');
            group: 'Seaside' with: #('Magritte-Seaside');
            group: 'CI' with: #('Seaside' 'Tests');
            group: 'Deprecated' with: #('Magritte-Deprecated') ];
    yourself.
  spec
    for: #'squeakCommon'
    do: [ 
      spec
        project: 'Grease'
          with: [ 
              spec
                className: 'ConfigurationOfGrease';
                versionString: #'stable';
                loads: #('Core');
                repository:
                    'http://smalltalkhub.com/mc/Seaside/MetacelloConfigurations/main' ];
        project: 'Seaside3'
          with: [ 
              "note: we do not want to depend on Zinc, since this is not present in Squeak. Currently no adapter is loaded"
              spec
                className: 'ConfigurationOfSeaside3';
                versionString: #'stable';
                loads: #('Core' 'Javascript' 'RSS' 'Filesystem' 'Welcome');
                repository:
                    'http://smalltalkhub.com/mc/Seaside/MetacelloConfigurations/main' ];
        yourself.
      spec
        package: 'Magritte-Tests-Model'
          with: [ spec includes: #('Magritte-Tests-Pharo-Model') ];
        package: 'Magritte-Seaside'
          with: [ spec includes: #('Magritte-Pharo-Seaside') ];
        package: 'Magritte-Pharo-Seaside'
          with: [ spec requires: #('Magritte-Seaside') ];
        package: 'Magritte-Morph' with: [ spec requires: #('Magritte-Model') ];
        package: 'Magritte-Pharo-Tools'
          with: [ spec requires: #('Magritte-Deprecated') ];
        yourself.
      spec
        group: 'Tools' with: #('Magritte-Pharo-Tools');
        group: 'Morphic' with: #('Magritte-Morph');
        yourself ].
  spec
    for: #'squeak'
    do: [ 
      spec
        package: 'Magritte-Pharo-Model';
        yourself ].
  spec
    for: #(#'pharo3.x' #'pharo4.x')
    do: [ 
      spec
        package: 'Magritte-Pharo3-Model'
          with: [ spec requires: #('Magritte-Model') ];
        package: 'Magritte-Tests-Pharo-Model'
          with: [ spec requires: #('Magritte-Pharo3-Model') ];
        package: 'Magritte-Model'
          with: [ spec includes: #('Magritte-Pharo3-Model') ];
        package: 'Magritte-Pharo-Model' with: 'Magritte-Pharo3-Model' ].
  spec
    for: #'pharo4.x'
    do: [ spec package: 'Magritte-GT' with: 'Magritte-GT' ].
  spec
    for: #'gemstone'
    do: [ 
      spec
        baseline: 'Grease'
          with: [ 
              spec
                loads: #('Core');
                repository: 'github://GsDevKit/Grease:master/repository' ];
        baseline: 'Seaside3'
          with: [ 
              spec
                loads: #('Core' 'Javascript' 'RSS' 'Filesystem' 'Welcome');
                repository: 'github://GsDevKit/Seaside31:gs_master/repository' ];
        yourself.
      spec
        package: 'Magritte-Model'
          with: [ spec includes: #('Magritte-GemStone-Model') ];
        package: 'Magritte-Tests-Model'
          with: [ spec includes: #('Magritte-Tests-GemStone-Model') ];
        package: 'Magritte-Seaside'
          with: [ spec includes: #('Magritte-GemStone-Seaside') ];
        package: 'Magritte-GemStone-Model'
          with: [ spec requires: #('Magritte-Model') ];
        package: 'Magritte-Tests-GemStone-Model'
          with: [ spec requires: #('Magritte-GemStone-Model') ];
        package: 'Magritte-GemStone-Seaside'
          with: [ spec requires: #('Magritte-Seaside') ];
        yourself ]
