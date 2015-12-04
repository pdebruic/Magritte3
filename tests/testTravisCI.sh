#!/bin/bash -x
#
#  Sample test driver that allows for customizing build/tests based on env vars defined in .travis.yml
#
#      -verbose flag causes unconditional transcript display
#
# Copyright (c) 2015 GemTalk Systems, LLC. All Rights Reserved <dhenrich@vmware.com>.
#

set -e "Exit on error"

echo "--->$TRAVIS_BUILD_DIR"
echo "`pwd`"

if [ "${CONFIGURATION}x" = "x" ]; then
  if [ "${BASELINE}x" = "x" ]; then
    echo "Must specify either BASELINE or CONFIGURATION"
    exit 1
  else
    PROJECT_LINE="  baseline: '${BASELINE}';"
    VERSION_LINE=""
    FULL_CONFIG_NAME="BaselineOf${BASELINE}"
  fi
else
  PROJECT_LINE="  configuration: '${CONFIGURATION}';"
  VERSION_LINE="  version: '$VERSION';"
  FULL_CONFIG_NAME="ConfigurationOf${CONFIGURATION}"
fi

if [ "${REPOSITORY}x" = "x" ]; then
  echo "Must specify REPOSITORY"
  exit 1
fi
REPOSITORY_LINE="  repository: '$REPOSITORY';"

OUTPUT_PATH="${PROJECT_HOME}/tests/travisCI.st"

if [[ "$ST" = GemStone-* ]] ; then
  cat - >> $OUTPUT_PATH << EOF
 Transcript cr; show: 'travis--->${OUTPUT_PATH}'.
 "Upgrade Grease and Metacello"
 Gofer new
  package: 'GsUpgrader-Core';
  url: 'http://ss3.gemtalksystems.com/ss/gsUpgrader';
  load.
 (Smalltalk at: #GsUpgrader) upgradeGrease. "Load the configuration or baseline"
 GsDeployer deploy: [
   "Load the configuration or baseline"
   Metacello new
   $PROJECT_LINE
   $VERSION_LINE
   $REPOSITORY_LINE
   load: #( ${LOADS} ).
 
 "Run the tests"
true ifTrue: [
  "Run all tests in image"
   TravisCISuiteHarness
     value: TestCase suite
     value: 'TravisCISuccess.txt'
     value: 'TravisCIFailure.txt'.
] ifFalse: [
  "Run just the Magritte tests"
  TravisCIHarness
    value: #( '${FULL_CONFIG_NAME}' )
    value: 'TravisCISuccess.txt' 
    value: 'TravisCIFailure.txt ]'.
EOF
else
  cat - >> $OUTPUT_PATH << EOF
 Transcript cr; show: 'travis--->${OUTPUT_PATH}'.
 "Explicitly load latest Grease configuration, since we're loading the #bleeding edge"
 Metacello new
    configuration: 'Grease';
    repository: 'http://www.smalltalkhub.com/mc/Seaside/MetacelloConfigurations/main';
    load: 'Slime Tests'. "temporary bugfix to load slime because baseline does not seem to pull it in"
 "Load the configuration or baseline"
 Metacello new
 $PROJECT_LINE
 $VERSION_LINE
 $REPOSITORY_LINE
   load: #( ${LOADS} ).
 Smalltalk at: #Author ifPresent:[Author fullName: 'Travis'].
 ((Smalltalk includesKey: #Utilities) and:[Utilities respondsTo: #setAuthorInitials:]) ifTrue:[Utilities setAuthorInitials: 'TCI'].
 "Run the tests"
 TravisCIHarness
    value: #( '${FULL_CONFIG_NAME}' )
    value: 'TravisCISuccess.txt' 
    value: 'TravisCIFailure.txt'.
EOF
fi

cat $OUTPUT_PATH

$BUILDER_CI_HOME/testTravisCI.sh "$@"
