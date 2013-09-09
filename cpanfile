requires 'perl', '5.008001';

on configure => sub {
    requires 'CPAN::Meta', '0';
    requires 'Exporter',  '5.57';
    requires 'ExtUtils::CBuilder';
    requires 'ExtUtils::Config', '0.003';
    requires 'ExtUtils::Helpers', '0.020';
    requires 'ExtUtils::Install';
    requires 'ExtUtils::InstallPaths', '0.002';
    requires 'ExtUtils::ParseXS';
    requires 'File::Basename';
    requires 'File::Find';
    requires 'File::Path';
    requires 'File::Spec::Functions';
    requires 'Getopt::Long';
    requires 'JSON::PP', '2',
    requires 'Pod::Man';
    requires 'TAP::Harness';
    requires 'HTTP::Tiny';
    requires 'Archive::Extract';
    requires 'File::pushd';
    requires 'File::Copy';
    requires 'File::Copy::Recursive';
};

on build => sub {
    requires 'HTTP::Tiny';
    requires 'Archive::Extract';
    requires 'File::pushd';
    requires 'File::Copy';
    requires 'File::Copy::Recursive';
};

on test => sub {
    requires 'Test::More', '0.98';
};

on develop => sub {
    requires 'Test::Pod', '1.41';
};

on runtime => sub {
    requires 'File::ShareDir';
    requires 'File::Spec::Functions';
    requires 'JSON::PP', '2';
    requires 'File::Slurp';
};
