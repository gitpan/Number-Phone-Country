package Number::Phone::Country;

use strict;
use warnings;

require Exporter;
use AutoLoader qw(AUTOLOAD);

our @ISA = qw(Exporter);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

our @EXPORT = qw( phone2country	);

our $VERSION = '0.01';

my %idd_codes;

while (<DATA>) {
  chomp;
  last if /^__END__$/;
  my ($code, $country) = split(",");
  $idd_codes{$code} = $country;
}

# Preloaded methods go here.

sub phone2country {
  my ($phone) = @_;
  $phone =~ s![- \(\)]+! !g;
  $phone =~ s!^ +!!;
  $phone =~ s! +$!!;
  $phone =~ s!^1 !!;
  if ($phone =~ m!^(\d{3}) \d{3} \d{4}$!) {
    if ($1 =~ m!^(204|250|289|306|403|416|418|450|506|514|519|604|613|647|705|709|778|780|807|819|867|902|905)$!) {
      return 'CA';
    } elsif ($1 eq '264') {
      return 'AI';
    } elsif ($1 eq '268') {
      return 'AG';
    } elsif ($1 eq '242') {
      return 'BS';
    } elsif ($1 eq '246') {
      return 'BB';
    } elsif ($1 eq '441') {
      return 'BM';
    } elsif ($1 eq '284') {
      return 'VG';
    } elsif ($1 eq '345') {
      return 'KY';
    } elsif ($1 eq '767') {
      return 'DM';
    } elsif ($1 eq '809') {
      return 'DO';
    } elsif ($1 eq '671') {
      return 'GU';
    } elsif ($1 eq '876') {
      return 'JM';
    } elsif ($1 eq '664') {
      return 'MS';
    } elsif ($1 eq '787') {
      return 'PR';
    } elsif ($1 eq '939') {
      return 'PR';
    } elsif ($1 eq '869') {
      return 'KN';
    } elsif ($1 eq '758') {
      return 'LC';
    } elsif ($1 eq '784') {
      return 'VC';
    } elsif ($1 eq '868') {
      return 'TT';
    } elsif ($1 eq '649') {
      return 'TC';
    } elsif ($1 eq '340') {
      return 'VI';
    } else {
      return 'US';
    }
  } else {
    my $idd = (split(' ',$phone))[0];
    if (exists $idd_codes{$idd}) {
      return $idd_codes{$idd};
    }
  }
  return;
}

1;
__DATA__
32,BE
90,TR
386,SI
358,FI
850,KR
376,AD
44,GB
599,AN
55,BR
84,VN
27,ZA
233,GH
998,UZ
95,MM
57,CO
220,GM
20,EG
231,LR
994,AZ
31,NL
504,HN
93,AF
672,AQ
964,IQ
65,SG
378,SM
350,GI
968,OM
675,PG
261,MG
291,ER
853,MO
374,AM
58,VE
226,BF
684,AS
81,JP
60,MY
689,PF
886,TW
86,CN
62,ID
371,LV
241,GA
389,MK
677,SB
674,NR
82,KR
966,SA
973,BH
992,TJ
228,TG
590,GP
236,CF
268,SZ
249,SD
218,LY
596,MQ
49,DE
224,GN
993,TM
234,NG
385,HR
502,GT
594,GF
974,QA
420,CZ
212,MA
971,AE
352,LU
355,AL
238,CV
251,ET
253,DJ
509,HT
961,LB
47,NO
976,MN
98,IR
256,UG
216,TN
357,CY
43,AT
855,KH
372,EE
686,KI
852,HK
33,FR
63,PH
680,PW
7,RU
227,NE
977,NP
598,UY
244,AO
880,BD
255,TZ
351,PT
264,NA
963,SY
297,AW
595,PY
240,GQ
359,BG
690,TK
61,AU
230,MU
299,GL
377,MC
92,PK
232,SL
423,LI
263,ZW
91,IN
266,LS
48,PL
505,NI
670,TL
692,MH
683,NU
995,GE
592,GY
221,SN
39,IT
64,NZ
41,CH
258,MZ
52,MX
688,TV
56,CL
66,TH
229,BJ
45,DK
260,ZM
507,PA
54,AR
237,CM
503,SV
673,BN
370,LT
967,YE
593,EC
682,CK
1,US
353,IE
506,CR
375,BY
30,GR
380,UA
965,KW
222,MR
252,SO
40,RO
250,RW
381,YU
501,BZ
254,KE
687,NC
960,MV
678,VU
373,MD
53,CU
387,BA
962,JO
245,GW
267,BW
269,KM
354,IS
46,SE
235,TD
257,BI
972,IL
36,HU
597,SR
94,LK
213,DZ
51,PE
356,MT
591,BO
34,ES
265,MW
975,BT
242,CG
__END__

=head1 NAME

Number::Phone::Country - Lookup country of phone number

=head1 SYNOPSIS

  use Number::Phone::Country;
  #returns 'CA' for Canada
  my $iso_country_code = phone2country("1 (604) 111-1111");

=head1 ABSTRACT

This module lookups up the country based on a telephone number.
It uses the International Direct Dialing (IDD) prefix, and
lookups North American numbers using the Area Code, in accordance
with the North America Numbering Plan (NANP).

=head1 SEE ALSO

L<Parse::PhoneNumber>

=head1 BUGS

Not very throughly tested, bug reports, and fixed welcome.

=head1 AUTHOR

TJ Mather, E<lt>tjmather@maxmind.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2003 by MaxMind LLC

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut
