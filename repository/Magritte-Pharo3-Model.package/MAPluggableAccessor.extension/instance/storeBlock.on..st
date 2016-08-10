*Magritte-Pharo3-Model
storeBlock: aBlock on: aStream 
	aStream nextPutAll: aBlock decompile greaseString allButFirst allButLast