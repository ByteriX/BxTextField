
#
#  build.sh
#  version 1.1
#
#  Created by Sergey Balalaev on 02.03.17.
#  Copyright (c) 2017 ByteriX. All rights reserved.
#

PROJECT_NAME="BxTextField"
APP_CONFIG_PATH="./build.config"
TEMPLATE_SPEC_PATH="${PROJECT_NAME}.templatespec"
WORK_SPEC_PATH="${PROJECT_NAME}.podspec"
VAR_NAME="VERSION_NUMBER"


# Create execution

checkExit(){
    if [ $? != 0 ]; then
    echo "Building failed\n"
    clear
    exit 1
    fi
}

gitPush(){
    git add "${WORK_SPEC_PATH}"
    git commit -m "${VERSION_NUMBER} release"
    git push -f
    git tag -f -a "${VERSION_NUMBER}" -m build
    git push -f --tags
}

startClear(){
    rm -f -d "${WORK_SPEC_PATH}"
}

finishedClear(){
    rm -f -d "${WORK_SPEC_PATH}-e"
}

# Load Config

if [[ "$1" != "" ]]
    then
        CUSTOM_BUILD=1
        echo "VERSION_NUMBER=$1" > "$APP_CONFIG_PATH"
    fi
. "$APP_CONFIG_PATH"

startClear
checkExit
cp  -rf "${TEMPLATE_SPEC_PATH}" "${WORK_SPEC_PATH}"
checkExit
sed -i -e "s/$VAR_NAME/$VERSION_NUMBER/" "${WORK_SPEC_PATH}"
checkExit
finishedClear
checkExit
gitPush
checkExit
pod trunk push "${WORK_SPEC_PATH}" --allow-warnings --verbose
checkExit