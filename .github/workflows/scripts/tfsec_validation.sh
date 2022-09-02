#!/bin/bash

# Accept Command Line Arguments
SKIPVALIDATIONFAILURE=$1
tfTfsec=$2
CODE_DIR=$3
# -----------------------------

echo "### VALIDATION Overview ###"
echo "-------------------------"
echo "Skip Validation Errors on Failure : ${SKIPVALIDATIONFAILURE}"
echo "Terraform tfsec    : ${tfTfsec}"
echo "------------------------"

if [[ ${tfTfsec} == "Y" ]]
then
    echo "## VALIDATION : Running tfsec ..."
    tfsec ${CODE_DIR} --format junit --out tfsec-junit.xml
fi
tfTfsecOutput=$?

echo "## VALIDATION Summary ##"
echo "------------------------"
echo "Terraform tfsec    : ${tfTfsecOutput}"
echo "------------------------"

if [[ ${SKIPVALIDATIONFAILURE} == "Y" ]]
then
  #if SKIPVALIDATIONFAILURE is set as Y, then validation failures are skipped during execution
  echo "## VALIDATION : Skipping validation failure checks..."
elif [[ $tfValidateOutput == 0 ]]
then
  echo "## VALIDATION : Checks Passed!!!"
else
  # When validation checks fails, build process is halted.
  echo "## ERROR : Validation Failed"
  exit 1;
fi