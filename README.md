# crc_database
This is a tiny fragment of package holidays provider's database. All tables have their appropriate logic, triggers and checks. </br>
Second part of script name is the execution order number, third part is the database user who should execute it. </br>
Dba user is `ADMIN`. Scripts were created for Cloud Autonomous Database. As `country_pkg` communicates with web to get json responses some ACL and wallet config might be needed.
![database model](https://github.com/[martamazurkiewicz]/[crc_database]/blob/[main]/db_model.png?raw=true)