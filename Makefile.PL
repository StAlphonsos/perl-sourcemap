# JS::SourceMap - Perl interface to JS sourcemaps

use ExtUtils::MakeMaker;
use lib "./lib";
do "./lib/JS/SourceMap.pm" or die($@);

sub SRC { "lib/JS/@_" }
sub DST { '$(INST_LIBDIR)/'."@_" }
sub PAIR { ( SRC(@_) => DST(@_) ) }

print STDERR "Welcome to JS::SourceMap $JS::SourceMap::VERSION\n\n";

WriteMakefile(
    AUTHOR => 'attila <attila@stalphonsos.com>',
    LICENSE => 'BSD',
    ABSTRACT => 'perl interface to JS sourcemaps',
    NAME => 'JS::SourceMap',
    VERSION => $JS::SourceMap::VERSION,
    PREREQ_PM => {
	'JSON' => 0,
    },
    PM => {
	PAIR('SourceMap.pm'),
	PAIR('SourceMap/Decoder.pm'),
	PAIR('SourceMap/Index.pm'),
	PAIR('SourceMap/Token.pm'),
    }
);

sub MY::postamble {
    return <<__MyStuff__;

check:

__MyStuff__
}
