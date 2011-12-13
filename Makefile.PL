use inc::Module::Install;

name     'SIFTS';
all_from 'lib/SIFTS.pm';
author   q{Benoit H Dessailly <benoit@nibio.go.jp>};
license  'perl';

build_requires 'Test::More';

install_script 'domid_to_pdbchains';

auto_install;

WriteAll;

