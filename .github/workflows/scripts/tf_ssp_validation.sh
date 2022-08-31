#!/bin/bash

# Accept Command Line Arguments
SKIPVALIDATIONFAILURE=$1
tfValidate=$2
tfFormat=$3
tfTfsec=$4
# -----------------------------

echo "### VALIDATION Overview ###"
echo "-------------------------"
echo "Skip Validation Errors on Failure : ${SKIPVALIDATIONFAILURE}"
echo "Terraform Validate : ${tfValidate}"
echo "Terraform Format   : ${tfFormat}"
echo "Terraform tfsec    : ${tfTfsec}"
echo "------------------------"
terragrunt init
if [[ ${tfValidate} == "Y" ]]
then
    echo "## VALIDATION : Validating Terraform code ..."
    terragrunt validate
fi
tfValidateOutput=$?

if [[ ${tfFormat} == "Y" ]]
then
    echo "## VALIDATION : Formatting Terraform code ..."
    terraform fmt -recursive -check
fi
tfFormatOutput=$?

if [[ ${tfTfsec} == "Y" ]]
then
    echo "## VALIDATION : Running tfsec ..."
    #tfsec .
    tfsec dev/services/codely-s3 --format junit --out tfsec-junit.xml
fi
tfTfsecOutput=$?

echo "## VALIDATION Summary ##"
echo "------------------------"
echo "Terraform Validate : ${tfValidateOutput}"
echo "Terraform Format   : ${tfFormatOutput}"
echo "Terraform tfsec    : ${tfTfsecOutput}"
echo "------------------------"

if [[ ${SKIPVALIDATIONFAILURE} == "Y" ]]
then
  #if SKIPVALIDATIONFAILURE is set as Y, then validation failures are skipped during execution
  echo "## VALIDATION : Skipping validation failure checks..."
elif [[ $tfValidateOutput == 0 && $tfFormatOutput == 0 && $tfTfsecOutput == 0 ]]
then
  echo "## VALIDATION : Checks Passed!!!"
else
  # When validation checks fails, build process is halted.
  echo "## ERROR : Validation Failed"
  exit 1;
fi