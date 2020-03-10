####################################################################################################################################
# Build Constants and Functions
####################################################################################################################################
package pgBackRestBuild::Build::Common;

use strict;
use warnings FATAL => qw(all);
use Carp qw(confess);
use English '-no_match_vars';

use Cwd qw(abs_path);
use Exporter qw(import);
    our @EXPORT = qw();
use Storable qw(dclone);

use BackRestDoc::Common::Log;
use BackRestDoc::Common::String;

####################################################################################################################################
# Constants
####################################################################################################################################
use constant BLD_PATH                                               => 'path';
    push @EXPORT, qw(BLD_PATH);
use constant BLD_FILE                                               => 'file';
    push @EXPORT, qw(BLD_FILE);

use constant BLD_C                                                  => 'c';
    push @EXPORT, qw(BLD_C);
use constant BLD_EXT                                                => 'ext';
    push @EXPORT, qw(BLD_EXT);
use constant BLD_HEADER                                             => 'h';
    push @EXPORT, qw(BLD_HEADER);

use constant BLD_CONSTANT                                           => 'constant';
    push @EXPORT, qw(BLD_CONSTANT);
use constant BLD_CONSTANT_GROUP                                     => 'constantGroup';
    push @EXPORT, qw(BLD_CONSTANT_GROUP);
use constant BLD_CONSTANT_VALUE                                     => 'constantValue';
    push @EXPORT, qw(BLD_CONSTANT_VALUE);

use constant BLD_DATA                                               => 'data';
    push @EXPORT, qw(BLD_DATA);
use constant BLD_DECLARE                                            => 'declare';
    push @EXPORT, qw(BLD_DECLARE);
use constant BLD_ENUM                                               => 'enum';
    push @EXPORT, qw(BLD_ENUM);
use constant BLD_LIST                                               => 'list';
    push @EXPORT, qw(BLD_LIST);
use constant BLD_NAME                                               => 'name';
    push @EXPORT, qw(BLD_NAME);
use constant BLD_PATH                                               => 'path';
    push @EXPORT, qw(BLD_PATH);
use constant BLD_SOURCE                                             => 'buildSource';
    push @EXPORT, qw(BLD_SOURCE);
use constant BLD_SUMMARY                                            => 'summary';
    push @EXPORT, qw(BLD_SUMMARY);
use constant BLD_VALUE                                              => 'value';
    push @EXPORT, qw(BLD_VALUE);

####################################################################################################################################
# bldAutoWarning - warning not to modify automatically generated files directly
####################################################################################################################################
sub bldAutoWarning
{
    my $strGenerator = shift;

    return "Automatically generated by ${strGenerator} -- do not modify directly.";
}

push @EXPORT, qw(bldAutoWarning);

####################################################################################################################################
# bldBanner - build general banner
####################################################################################################################################
sub bldBanner
{
    my $strContent = shift;
    my $strGenerator = shift;

    my $strBanner =
        qw{/} . (qw{*} x 131) . "\n" .
        trim($strContent) . "\n";

    if (defined($strGenerator))
    {
        $strBanner .=
            "\n" .
            bldAutoWarning($strGenerator) . "\n";
    }

    $strBanner .=
        (qw{*} x 131) . qw{/} . "\n";

    return $strBanner;
}

push @EXPORT, qw(bldBanner);

####################################################################################################################################
# Generate an enum name from a prefix and - separated name
####################################################################################################################################
sub bldEnum
{
    my $strPrefix = shift;
    my $strName = shift;
    my $bInitCapFirst = shift;

    $bInitCapFirst = defined($bInitCapFirst) ? $bInitCapFirst : true;
    my $bFirst = true;

    my @stryName = split('\-', $strName);
    $strName = undef;

    foreach my $strPart (@stryName)
    {
        $strName .= ($bFirst && $bInitCapFirst) || !$bFirst ? ucfirst($strPart) : $strPart;
        $bFirst = false;
    }

    return "${strPrefix}${strName}";
}

push @EXPORT, qw(bldEnum);

####################################################################################################################################
# Quote a list of strings
####################################################################################################################################
sub bldQuoteList
{
    my $ryList = shift;

    my @stryQuoteList;

    foreach my $strItem (@{$ryList})
    {
        push(@stryQuoteList, "\"${strItem}\"");
    }

    return @stryQuoteList;
}

push @EXPORT, qw(bldQuoteList);

1;
