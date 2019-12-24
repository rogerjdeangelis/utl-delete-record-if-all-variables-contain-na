Delete record if all variables contain na;

 Caveat  (important point)

   If the number of variables is large enough, or lengths of values are long enough CATS will eventually WARN
   "WARNING: In a call to the CATS function, the buffer allocated for the result was not long enough
         to contain the concatenation of all the arguments...."
   Richard DeVenezia
   rdevenezia@gmail.com

   There is kludge extension, however it sends the warning messages to the bit bucket.
   Ir can handle over 16,000 variables of any length?


   Three Solutions

         a. Little simpler but not a general solution.

         b. Preferred robust solution by
            Richard DeVenezia
            rdevenezia@gmail.com

         c. Kludge extension of solution a. (sends warnings to the bit bucket)


github
https://tinyurl.com/tcpbljy
https://github.com/rogerjdeangelis/utl-delete-record-if-all-variables-contain-na

SAS Forum
https://tinyurl.com/ucpgmrz
https://communities.sas.com/t5/SAS-Programming/if-you-have-NA-in-all-character-variables-then-you-should-delete/m-p/613425

Put this together on the plane.

Delete record if all variables contain NA

*
__      ___ __  ___
\ \ /\ / / '_ \/ __|
 \ V  V /| |_) \__ \
  \_/\_/ | .__/|___/
         |_|
;

Worked without change in WPS;

SOAPBOX ON

Found the WPS output, however I cannot figure out
how to get a dynamic log or dynamic output, like in the claasic editor.
You need to click on the small print 'HTML' in lower panel to view output?

With a CLI you can fetch the log and list back to a better IDE,
Ultra-edit or SAS classic editor?
Worked in WPS express, however the 'enhanced
WPS community edition' does not support other editors.
I just hope removing functionality doers not
becore a WPS trend, like SAS(learning edition then University edition).

WPS is taking a page from SAS.

The 100 record limit was fine until all this legal stuff gets resolved and
I can purchase the standard edition?

SOAPBOX OFF

*                    _       _   _
  __ _     ___  ___ | |_   _| |_(_) ___  _ __
 / _` |   / __|/ _ \| | | | | __| |/ _ \| '_ \
| (_| |_  \__ \ (_) | | |_| | |_| | (_) | | | |
 \__,_(_) |___/\___/|_|\__,_|\__|_|\___/|_| |_|
 _                   _
(_)_ __  _ __  _   _| |_
| | '_ \| '_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
;
data have;
  output;
  array nas[5] $2 na1-na5 (5*'FO');
  output;
  call pokelong(repeat('NA',4),addrlong(nas[1]));
  output;
  call pokelong(repeat('FO',4),addrlong(nas[1]));
  output;
run;quit;


work.HAVE total obs=4

Obs    NA1    NA2    NA3    NA4    NA5

 1     FO     FO     FO     FO     FO
 2     FO     FO     FO     FO     FO

 3     NA     NA     NA     NA     NA  ** Delete this record

 4     FO     FO     FO     FO     FO

*            _               _
  ___  _   _| |_ _ __  _   _| |_
 / _ \| | | | __| '_ \| | | | __|
| (_) | |_| | |_| |_) | |_| | |_
 \___/ \__,_|\__| .__/ \__,_|\__|
                |_|
;

Up to 40 obs WORK.WANT total obs=3

Obs    NA1    NA2    NA3    NA4    NA5

 1     FO     FO     FO     FO     FO
 2     FO     FO     FO     FO     FO
 3     FO     FO     FO     FO     FO

*          _       _   _
 ___  ___ | |_   _| |_(_) ___  _ __
/ __|/ _ \| | | | | __| |/ _ \| '_ \
\__ \ (_) | | |_| | |_| | (_) | | | |
|___/\___/|_|\__,_|\__|_|\___/|_| |_|

;
data want;
  set have;
  res=tranwrd(cats(of na:),'NA','');
  put res=;
  if missing(res) then delete;
  drop res;
run;quit;

proc print;
run;quit;

*_        ____  _      _                   _
| |__    |  _ \(_) ___| |__   __ _ _ __ __| |
| '_ \   | |_) | |/ __| '_ \ / _` | '__/ _` |
| |_) |  |  _ <| | (__| | | | (_| | | | (_| |
|_.__(_) |_| \_\_|\___|_| |_|\__,_|_|  \__,_|

_                   _
(_)_ __  _ __  _   _| |_
| | '_ \| '_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
;

data have;
  array col(5000) $50.;
  do _n_ = 1 to dim(col); col(_n_) = 'NA'; end;     output;
  col(5000) = 'Something'; output;
  do _n_ = 1 to dim(col); col(_n_) = 'This is a longer string value'; end;     output;
  col(1) = 'NA'; output;
run;

Obs    COL1                             COL2                          .. COL4999                          COL5000

 1     NA                               NA                               NA                               NA
 2     NA                               NA                               NA                               Something
 3     This is a longer string value    This is a longer string value .. This is a longer string value    This is a longer string value
 4     NA                               This is a longer string value .. This is a longer string value    This is a longer string value

*            _               _
  ___  _   _| |_ _ __  _   _| |_
 / _ \| | | | __| '_ \| | | | __|
| (_) | |_| | |_| |_) | |_| | |_
 \___/ \__,_|\__| .__/ \__,_|\__|
                |_|
;

Obs    COL1                             COL2                          .. COL4999                          COL5000

 1     NA                               NA                               NA                               Something
 2     This is a longer string value    This is a longer string value .. This is a longer string value    This is a longer string value
 3     NA                               This is a longer string value .. This is a longer string value    This is a longer string value


*          _       _   _
 ___  ___ | |_   _| |_(_) ___  _ __
/ __|/ _ \| | | | | __| |/ _ \| '_ \
\__ \ (_) | | |_| | |_| | (_) | | | |
|___/\___/|_|\__,_|\__|_|\___/|_| |_|

;

data have;
  array col(5000) $50.;
  do _n_ = 1 to dim(col); col(_n_) = 'NA'; end;     output;
  col(5000) = 'Something'; output;
  do _n_ = 1 to dim(col); col(_n_) = 'This is a longer string value'; end;     output;
  col(1) = 'NA'; output;
run;

data want;
  set have;
  array charvars _character_;
  do _n_ = 1 to dim(charvars);
    if charvars(_n_) ne 'NA' then return;
  end;
  delete;
run;

*         _    _           _
  ___    | | _| |_   _  __| | __ _  ___
 / __|   | |/ / | | | |/ _` |/ _` |/ _ \
| (__ _  |   <| | |_| | (_| | (_| |  __/
 \___(_) |_|\_\_|\__,_|\__,_|\__, |\___|
                             |___/
;

* same input and output as above;

data want;
  set have;
  array charvars _character_;
  res=cats(of charvars)=repeat("NA",dim(charvars)-1);
  do _n_ = 1 to dim(charvars);
    if charvars(_n_) ne 'NA' then return;
  end;
  delete;
run;

proc printto log=_null_;
data want;
  set have;
  array charvars _character_;
  if cats(of charvars[*])=repeat("NA",dim(charvars)-1) then delete;
run;quit;
proc printto;

proc print data=want;
var col1-col2 col4999-col5000;
run;quit;

