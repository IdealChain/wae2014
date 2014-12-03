wae2014
=======

Web Application Engineering &amp; Content Management VU

*WS2014, TU Wien*

Links
-------

* Assignment: http://weng.culturall.com:8020/AngabeWAE
* Deployed application: http://weng.culturall.com:8020/wae07
* Mason Tipps: http://weng.culturall.com:8020/MasonCodeTipps
* phpMyAdmin: http://weng.culturall.com:8020/phpMyAdmin/
* Mason/Poet: http://www.masonhq.com

Local development environment
----------------------------------------------

* Install **cpanminus** (cpanm)
* Install Poet (http://www.masonhq.com/install)

		cpanm -S --notest Poet MooseX::Getopt DBIx::Connector DBD::mysql

* Create app

		poet new Ws14

* Clone/symlink this repository into **ws14/comps**

* Copy following Module/Config files from weng **/usr/local/htdocs/ws14** into your **ws14**:
	* lib/Ws14/DBI.pm
	* conf/global.cfg
	* conf/local.cfg

* For now: (keep session in filesystem instead of database)  
  Comment out $SESSION\_CONF stuff (lines 21-32) in **lib/Ws14/DBI.pm**

* Setup local MySQL/MariaDB server  
  Create database/user **tuv** and grant all privileges  
  Copy weng: **.my.cnf** to your homedir  
  Test access: execute **mysql**

* Setup DB schema and test data

		mysql < db_schema.sql
		mysql < db_dataseeder.sql

* Start local server, and open your browser

		ws14/bin/run.pl

Deployment
-----------------
* Setup SSH access to weng.culturall.com
* Execute **./deploy.sh** in ws14/comps, check for errors
* See http://weng.culturall.com:8020/wae07 for updated version
