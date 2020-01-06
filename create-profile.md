# create-profile.sh

Bash script used for automating profile creation.

The script creates the specified profile for a collection and outputs a suggested set of administration interface rules that can be added to the ruleset for administration interface users to enable access via the administration interface.

# Usage

```
create-profile.sh -c COLLECTION_NAME -p PROFILE_NAME
```

Parameters: 

* **COLLECTION_NAME:** id of the collection to create the profile for.  The collection must already exist.
* **PROFILE_NAME:** id of the profile to create the profile for.  Allowed characters: uppercase and lowercase characters, numbers, dash and underscore characters.

The script creates profile folders with an ID of PROFILE_NAME for the collection with id of COLLECTION_NAME.

Folders created: 
* conf/COLLECTION_NAME/PROFILE_NAME
* conf/COLLECTION_NAME/PROFILE_NAME_preview
* conf/COLLECTION_NAME/PROFILE_NAME/web
* conf/COLLECTION_NAME/PROFILE_NAME_preview/web

Outputs rules that can be added to administration user configuration (see: [Adding additional services and profiles to a collection](https://community.funnelback.com/knowledge-base/implementation/search-interface/adding-additional-services-and-profiles-to-a-collection))
