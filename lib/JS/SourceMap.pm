#! perl

=pod

=head1 NAME

JS::SourceMap - Parse and use JS SourceMaps in Perl

=head1 SYNOPSIS

  use JS::SourceMap qw/load loads discover/;

  # parse a file into a sourcemap
  $map = load($filename);

  # parse a string into a sourcemap
  $map = loads($string);

  # find the URL for a sourcemap from some JS code:
  $url = discover($web_goo);

=head1 DESCRIPTION

Current web development techniques like minification can make
debugging deployed JS code a pain.  Source maps are a compact
representation of the data necessary to turn a filename/line/column in
a JS runtime error thrown in your browser into the real
filename/line/column in the source code where the error occurred.

This is a set of Perl modules that allow you to decode and use JS
source maps.  We have adapted much of this Perl implementation from
the Python implementation at
https://github.com/martine/python-sourcemap, which is BSD-licensed.
Our API is very similar to that Python module.

=cut

package JS::SourceMap;
use strict;
use warnings;
require Exporter;
use JS::SourceMap::Decoder;
use vars qw(@ISA @EXPORT_OK @EXPORT %EXPORT_TAGS $VERSION);

@ISA = qw(Exporter);
@EXPORT_OK = qw(load loads discover);
@EXPORT = ();
%EXPORT_TAGS = ( 'all' => \@EXPORT_OK );
$VERSION = '0.1.0';

=pod

=over 4

=item * load $stream [, @options ]

Read the I/O handle C<$stream> completely and treat its contents as a
sourcemap.  Returns a L<JS::SourceMap::Index> instance if successful,
throws an error if not.

If any C<@options> are given they are passed to the
L<JS::SourceMap::Decoder> constructor.

=back

=cut

sub load {
	my($filething,@options) = @_;
	local($/);
	$/ = undef;
	my $slurp = <$filething>;
	return loads($slurp,@options);
}

=pod

=over 4

=item * loads $string [, @options ]

Decodes a sourcemap passed as a string.  Returns a
L<JS::SourceMap::Index> instance or throws an error.

If any C<@options> are given they are passed to the
L<JS::SourceMap::Decoder> constructor.

=back

=cut

sub loads {
	my($string,@options) = @_;
	return JS::SourceMap::Decoder->new(@options)->decode($string);
}

=pod

=over 4

=item * discover $string

Examine the contents of a file of JS code for the marker that points
to its source map.  If found we return the URL to the source map.  If
not we return C<undef>.

=back

=cut

sub discover {
	my($string) = @_;
	my @source = split(/\n/,$string);
	my @search = ((scalar(@source) <= 10) ? @source :
		      (@source[0..4],@source[-5..-1]));
	foreach my $line (@search) {
		if ($line =~ m,^//[#@]\ssourceMappingURL=(.*)$,) {
			return $1;
		}
	}
	return undef;
}

1;

__END__

=pod

=head1 SEE ALSO

L<JS::SourceMap::Decoder>

=head1 AUTHOR

attila <attila@stalphonsos.com>

=head1 LICENSE

ISC/BSD c.f. LICENSE in the source distribution.

=cut

##
# Local variables:
# mode: perl
# tab-width: 8
# perl-indent-level: 8
# cperl-indent-level: 8
# cperl-continued-statement-offset: 8
# indent-tabs-mode: t
# comment-column: 40
# End:
##
