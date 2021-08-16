# i18n Report generator

## Goal
We manage two language packages and want the scalability to expand the language set. As the application 
grows, we have the manage more and more topics and translations. 

## Problem
Since the translations are added manually during development, it may generate a level of *dirty* that 
is a **serious threat** to any future maintainability of the code base as the pages and translations grows.

This may be explained as: 
When a language does not have the topic, it may cause the app to break. 
Another case is that if the topic does not have the desired key, it will present a very long text for failure
Finally, there is also the risk of one of the language packages may have too much key in a topic or
it holds a key that has been removed from the **primary** language pack (en).

### Definitions
 Primary language
 : :flag_gb: English (en)

 Secondary(ies) language(s)
 : :flag_fr: French (fr)
 : :flag_es: Spanish (es)

 Language package location
 ./assets/i18n/

 The File names
 [xx.json] where xx is the two leter code for the language code. I.e. en.json is the English language
 file

 File format
 The format is a `Map<String, Map<String, String>>`,
 i.e. a map of Strings pairing a Map of String pairign Strings
```
{
  "topic" : 
  {
     "key" : "language text"
  }
}
```