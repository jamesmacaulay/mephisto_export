mephisto_export
===============

Adds a couple of rake tasks for managing exports of Mephisto data.


Example
=======

**Export all sites, sections, users, articles, and comments as RAILS_ROOT/public/mephisto\_export\_[timestamp]\_[obfuscation].xml**

    $ rake mephisto:export
    (in /u/apps/my-mephisto/current)
    Exported data to:
    /u/apps/my-mephisto/current/public/exports/mephisto\_export\_20081222063136\_33b9705.xml
    

**Delete exports older than the latest number of exports designated by ENV['KEEP'] (default 10)**

    $ rake mephisto:export:cleanup KEEP=2
    (in /u/apps/my-mephisto/current)
    Deleted 1 export files. 2 exports remain:
    /u/apps/my-mephisto/current/exports/mephisto\_export\_20081222064106\_40da7cb.xml
    /u/apps/my-mephisto/current/exports/mephisto\_export\_20081222064117\_de8412b.xml



Copyright (c) 2008 James MacAulay, released under the MIT license.
