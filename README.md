# Actions Data (beta)
[![N|Solid](https://g3links.com/actions/g3links_brand.png)](https://g3links.com/actions)

Folder contains files related to settings, configuration and master data for the [g3links Actions](https://github.com/g3links/actions) website.

Some folders (like attach) will host files uploaded from projects and action events (images and documents).

### databases: 
**g3core.db**: hold information about users, projects and security.
**g3task.db**: there's a database for each project, holds the actions and security by project. 
 
### Installation
- **copy 'data' folder:** (and all files) in a location other than root website. You can rename the folder name 'data' for something else. The full path will be required to setup the website.
- **SMTP mail**: complete the information at config/g3.json. Required to communicate with users
```sh
    "mailer": {
        "host": "", --> domain
        "sender": "", --> Sender name to be displayed
        "sendfrom": "", -> email 
        "username": "", --> domain user email
        "password": "", --> password to access email
        "testemail": "", -> email when testing under localhost
        "SMTPSecure": "ssl", 
        "Port": "465",
        "testemail": "" -> email under localhost (optional)
    },
    "emailerror": {
        "email": "" -> email to report errors
    }
```
- **token key**: complete the information at config/g3.json. An application key is required to validate calls to the website. [RandomKeygen](https://randomkeygen.com/) is a good source to get samples.
```sh
    "token": {
        "key": "" -> email to report errors
    }
```
- continue to install **[G3 links actions](https://github.com/g3links/actions)** website.

