# utl-delete-record-if-all-variables-contain-na
Delete record if all variables contain na

    Delete record if all variables contain na;

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

    Found the output, however I cannot figure out
    how to get a dynamic log or output, like in the claasic editor.
    You need to click on the small print 'HTML' in lower panel.

    With a CLI you can fetch the log and list back to a better IDE.
    IE  Ultra-edit or SAS classic editor?


    *_                   _
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
