baseline
baseline: spec

	<baseline>
	spec
		for: #gemstone do: [ 
			spec
				baseline: 'Grease' with: [ 
					spec
						loads: #( 'Grease-Core' );
						repository: 'github://GsDevKit/Grease:master/repository' ];
				baseline: 'Seaside3'
				with: [ "note: we do not want to depend on Zinc, since this is not present in Squeak. Currently no adapter is loaded"
					spec
						repository: 'github://SeasideSt/Seaside:master/repository';
						loads: #( 'Core' 'Javascript' 'RSS' 'Filesystem' 'Welcome' ) ];
				yourself.
			spec
				package: 'Magritte-Model' with: [ 
					spec
						requires: #( 'Grease' );
						includes: #( 'Magritte-GemStone-Model' ) ];
				package: 'Magritte-Tests-Model' with: [ 
				spec
					requires: #( 'Magritte-Model' );
					includes: #( 'Magritte-Tests-GemStone-Model' ) ];
				package: 'Magritte-Seaside' with: [ 
				spec
					requires: #( 'Magritte-Model' 'Seaside3' );
					includes: #( 'Magritte-GemStone-Seaside' ) ];
				package: 'Magritte-Deprecated'
				with: [ spec requires: #( 'Magritte-Model' ) ];
				package: 'Magritte-GemStone-Model'
				with: [ spec requires: #( 'Magritte-Model' ) ];
				package: 'Magritte-Tests-GemStone-Model'
				with: [ spec requires: #( 'Magritte-GemStone-Model' ) ];
				package: 'Magritte-GemStone-Seaside'
				with: [ spec requires: #( 'Magritte-Seaside' ) ];
				yourself.
			spec
				group: 'default' with: #( 'Core' );
				group: 'Core' with: #( 'Magritte-Model' );
				group: 'Tests' with: #( 'Magritte-Tests-Model' );
				group: 'Seaside' with: #( 'Magritte-Seaside' );
				group: 'CI' with: #( 'Seaside' 'Tests' );
				group: 'Deprecated' with: #( 'Magritte-Deprecated' ) ];
		yourself
