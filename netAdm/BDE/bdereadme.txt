===========================================================
              BDE AND SQL LINKS RELEASE NOTES
===========================================================

This file contains important supplementary and late-
breaking information that may not appear in the main
product documentation. We recommend that you read this file
in its entirety. 

Portions of this file contain information that applies only
to specific product releases. Such portions are clearly
marked with the name of the product and edition.


TABLE OF CONTENTS
===========================================================
  1. RELEASE NOTES & DOCUMENTATION
     1.1 Other release notes
     1.2 Configuring the BDE Administrator
     1.2 Where to start: BDE
     1.3 Where to start: SQL Links
  2. Y2K ISSUES
  3. THIRD-PARTY KNOWN ISSUES
  4. BDE/SQL LINKS KNOWN ISSUES
  5. GETTING THE LATEST UPDATES & DOCUMENTATION
     5.1 Product updates & Supplementary information
     5.2 Documentation updates
     5.3 The Borland Web site
     5.4 Code Central


1. RELEASE NOTES & DOCUMENTATION
===========================================================
1.1 Other release notes
-----------------------------------------------------------
BDEINST.TXT contains system requirements and information on
installing and removing the product.

BDEDEPLOY.TXT contains information about redistributing BDE
and SQL Links with your applications. 

The text files listed above, along with this file, are
installed to your main BDE directory.

1.2 Configuring the BDE Administrator
-----------------------------------------------------------
The Borland Database Engine (BDE) comes with the utility
program BDE Administrator. Installed in the main BDE
directory, this utility is used to: configure the BDE; add,
delete, and modify BDE aliases; configure database drivers;
and connect to installed ODBC drivers (this latter
operation not available with all programming tools with
which the BDE is installed).

While the installation programs for some programming tools
that include the BDE allow SQL Links to be installed in a
different directory, we highly recommend that you install
SQL Links in the same directory as the BDE. (Note: SQL
Links is not available with all versions of the products
that use or install BDE.)

1.3 Where to start: BDE
-----------------------------------------------------------
For information about configuring the BDE, working with
aliases, and making ODBC drivers accessible to the BDE, see
the Help file BDEADMIN.HLP. For information on BDE API 
functions, see the Help file BDE32.HLP. For information on
migrating data between databases using the Data Pump
utility, see the Help file DATAPUMP.HLP. For information on
using SQL with local tables (dBASE and Paradox) see the
Help file LOCALSQL.HLP. All of these BDE Help files are
installed in the main BDE directory.

1.4 Where to start: SQL Links
-----------------------------------------------------------
For information about configuring and connecting to SQL
servers, see the Help file SQLLNK32.HLP. This Help file
also contains a "Hints, Problems, and Notes" topic with
tips and troubleshooting information. This Help file is
installed in your main BDE directory. (Note: SQL Links is
not available with all versions of the products that use or
install BDE.)


2. Y2K ISSUES
===========================================================
2.1 FOURDIGITYEAR and YEARBIASED Parameters
-----------------------------------------------------------
FOURDIGITYEAR
-------------
Determines how the BDE treats the century portion of a date
when only the last two digits of a year are specified. If
set to FALSE, the century part of the date's year is added
automatically based on its relative position in a baseline
range. If the date falls between 01/01/00 and 12/31/49, the
year is considered to be in the 21st century (05/20/22
becomes 05/20/2022). If the date falls between 01/01/50 and
12/31/99, the date is considered as being in the 20th
century (12/08/98 becomes 12/08/1998). A TRUE setting has
no effect on dates expressed with a century (the year of a
new date of 12/30/1902 remains 1902).
  
If set to TRUE, the year for the date is assumed to be
literal (no century digits automatically prefixed to the
date). For example, a date expressed as 07/72/96 is
considered to be the year 96 (0096).
  
FOURDIGITYEAR has an effect in such places as date literals
in SQL statements.

YEARBIASED
----------
Tells the BDE application whether or not it should add the
century to years entered as two digits. For example, if
TRUE and you enter "7/21/96," the BDE application
interprets your value as "7/21/1996". If set to FALSE, the
date is interpreted as entered (in this case, "7/21/0096").
YEARBIASED uses the same range considerations as
FOURDIGITYEAR for determining the century used.


3. THIRD-PARTY PRODUCT KNOWN ISSUES
===========================================================
3.1 Microsoft Transaction Server (MTS)
-----------------------------------------------------------
If Microsoft Transaction Server (MTS) is installed before
Delphi or C++Builder, the only preparation required is to 
set MTS POOLING to TRUE in the Borland Database Engine 
(BDE) configuration file. Use the BDE Administrator to do 
this. The MTS POOLING setting is in the System/Init area 
of the configuration. This setting enables the BDE to use 
MTS pooling, improving the initial connection time when 
opening a database and allowing BDE database connections 
to participate in MTS transactions.

If MTS is installed after Delphi or C++Builder has been
installed, additional steps must be taken:

  1. Copy DISP.DLL from the RUNIMAGE directory on your
     product CD into the BDE directory on the host
     computer.
  2. Issue the following command:
       REGSVR32 <BDE directory>\DISP.DLL
  3. In Transaction Server Explorer, install the BDE-MTS
     package:
     a. Right Click on Packages Installed.
     b. Choose New | Package.
     c. Choose Install pre-built packages.
     d. Add file DISP.PAK from the BDE directory.
  4. Set the value of  MTS POOLING to True in the System/
     Init section of the BDE configuration.


4. BDE/SQL LINKS KNOWN ISSUES
===========================================================
Threading problem
-----------------------------------------------------------
A threading problem occurs if you set the session property
sesCFGMODE2 to cfgmVirtual and/or cfgmSession (though
cfgmPersistent works). Specifying either of the two noted
settings can cause a GPF in your program.

Oracle client/server version mismatches
-----------------------------------------------------------
A mismatch between Oracle client and server versions can
cause BLOB and CLOB access problems. SQL Links is not
certified to overcome this limitation. Details: BLOB and
CLOB access problems will be encountered when an Oracle
8.1.5 client communicates with an Oracle 8.0.4 server.
(Delphi 6 is certified only with the Oracle 8.1.6 client/
Oracle 8.1.6 server configuration.)

TStoredProc components that attempt to get an spParamList
value from an invalid stored procedure (or function or
package) will cause an AV in ORACLIENT8.DLL. To avoid this
problem, make sure the procedure is valid on the server.

Other Oracle 8 issues
-----------------------------------------------------------
The BDE does not support reference to object members within
live queries.

The BDE does not support indexes with nested tables.

COLLECTION (NESTED TABLE/VARRAY) and REFERENCE access:
there is a memory loss when fetching data from and
navigating through NESTED TABLE data. This is an Oracle
8.0.4 issue (Oracle problem #593042). The fix for this is
available from Oracle in the OCI 8.0.4.2 patch.

A memory leakage may occur when executing a query many
times. Workaround: call DbiQFree() and DbiQPrepare() every
time the query is executed.

Sybase CT-LIB SQL Links Driver
-----------------------------------------------------------
The CT-Lib driver works with Sybase version 10.0.4 EBF7264
or higher.

BDE & CGI Applications
-----------------------------------------------------------
In CGI applications, if the volume of BDE initializations
is high enough (varies with circumstances), error
"Operation not applicable occurs." Only known workaround is
to use ISAPI instead of CGI.

DbiBatchMove & dBASE/Paradox to Sybase
-----------------------------------------------------------
DBiBatchMove with Mode value of batCOPY fails when copying
data from Paradox or Dbase table to Sybase table. Failure
is indicated by error "General SQL error."

DB/2 and Decimal Separators
-----------------------------------------------------------
Certain versions of the DB/2 client library return decimal
separators specified in the Windows regional settings. If
the decimal separator is set in the Windows regional
settings to other than a period ("."), this can cause
problems when working with NUMERIC and DECIMAL data types
with the BDE configuration setting ENABLE BCD is set to
TRUE. The IBM library should  always return a period as the
decimal separator, regardless of the regional settings.


5. GETTING THE LATEST UPDATES & DOCUMENTATION
===========================================================
5.1 Product updates & supplementary information
-----------------------------------------------------------
When available, product updates will be available for
download from the BDE Developer Support Web page at:

  http://www.borland.com/bde/

The support page also contains links to usage tips,
Technical Information sheets (TIs), examples, and other
useful technical information.

5.2 Documentation updates
-----------------------------------------------------------
Documentation for the Borland Database Engine (BDE) and SQL
Links is only available in the form of online Help files.
However, critical documentation updates or corrections may
be offered for viewing or downloading from the Borland Web
site. When offered, these updates will be available via a
Latest Documentation link from the BDE support page at:

  http://www.borland.com/devsupport/bde

When documentation updates or corrections appear on the Web
site, that information should be considered the most
current, superseding any conflicting information in this
file or in the shipped product documentation. Otherwise,
information in this readme should be considered more
current than that contained in any other Help or printed
documentation shipped with the product.

5.3 The Borland Web site
-----------------------------------------------------------
The following Borland Web-based resources provide a
continuous stream of news, product information, updates,
code, and other materials.

Borland home page:
  http://www.borland.com

BDE home page:     
  http://www.borland.com/bde/

BDE developer support:
  http://www.borland.com/devsupport/bde/
  
Newsgroups:
  http://www.borland.com/newsgroups/

Borland Developer Community
  http://community.borland.com/

Worldwide offices and distributors:
  http://www.borland.com/bww/

Borland FTP site (anonymous access):
  ftp.borland.com

5.4 Code Central
-----------------------------------------------------------
The CodeCentral Repository is a free, searchable database
of code, tips, and other materials of interest to
developers. For details and registration information, visit 

  http://www.borland.com/codecentral


===============================================
Copyright (c) 2002 Borland Software Corporation. 
All rights reserved.
                                                  
