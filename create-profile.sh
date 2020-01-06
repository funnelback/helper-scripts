#!/bin/bash
# Author: Peter Levan, April 2016
# v1.0
# Create a new profile and output a block of text that can be added to a user's .ini file

while getopts ":c:p:" opt; do
  case $opt in
    c) COLLECTION_NAME="${OPTARG}"
    ;;
    p) PROFILE_NAME="${OPTARG}"
    ;;
    \?) echo "Invalid option -${OPTARG}" >&2
    ;;
  esac
done

# Check SEARCH_HOME is defined and a folder
[ "${SEARCH_HOME}" ] || { echo -e "\n$0: Error: \$SEARCH_HOME environment variable is not defined, cannot continue.\n" >&2; exit 1; }
[ -d "${SEARCH_HOME}" ] || { echo -e "\n$0: Error: \$SEARCH_HOME folder does not exist, cannot continue.\n" >&2; exit 1; }


#Check both collection and profile are supplied as parameters
if [ ${COLLECTION_NAME} ] && [ ${PROFILE_NAME} ];
then

    # Test for existence of collection configuration folder
    if [ -d "${SEARCH_HOME}/conf/${COLLECTION_NAME}" ] && ! [ -d "${SEARCH_HOME}/conf/${COLLECTION_NAME}/${PROFILE_NAME}" ] ;
    then

        # Create the profile folders

        mkdir "${SEARCH_HOME}/conf/${COLLECTION_NAME}/${PROFILE_NAME}"
        mkdir "${SEARCH_HOME}/conf/${COLLECTION_NAME}/${PROFILE_NAME}_preview"
        mkdir "${SEARCH_HOME}/conf/${COLLECTION_NAME}/${PROFILE_NAME}/web"
        mkdir "${SEARCH_HOME}/conf/${COLLECTION_NAME}/${PROFILE_NAME}_preview/web"

        echo "Created profile for "${PROFILE_NAME}

        printf "Generated rules to add to user .ini files.  The following needs to be added to each user that needs to manage these profile folders.

Add the following lines to: [file-manager::folders]
profile-folder-${PROFILE_NAME}
profile-folder-${PROFILE_NAME}_preview
profile-folder-${PROFILE_NAME}-web
profile-folder-${PROFILE_NAME}_preview-web

Add the following sections:

[file-manager::profile-folder-${PROFILE_NAME}]
name = Profile for ${PROFILE_NAME} (live)
path = \$home/${PROFILE_NAME}
rules = live-display-rules

[file-manager::profile-folder-${PROFILE_NAME}_preview]
name = Profile for ${PROFILE_NAME} (preview)
path = \$home/${PROFILE_NAME}_preview
publish-to = \$home/${PROFILE_NAME}
rules = preview-display-rules

[file-manager::profile-folder-${PROFILE_NAME}-web]
name = Web resources for ${PROFILE_NAME} (live)
path = \$home/${PROFILE_NAME}/web
rules = live-web-display-rules
set =

[file-manager::profile-folder-${PROFILE_NAME}_preview-web]
name = Web resources for ${PROFILE_NAME} (preview)
path = \$home/${PROFILE_NAME}_preview/web
publish-to = \$home/${PROFILE_NAME}/web
rules = preview-web-display-rules
set =
";

    else
        echo "Error: Can't create profile as ${COLLECTION_NAME} does not exist or ${PROFILE_NAME} already exists.  Check your collection and profile names and make sure the spelling is correct."
        exit 1
    fi

else
    echo "Usage: $0 -c <COLLECTION_NAME> -p <PROFILE_NAME>"

fi
