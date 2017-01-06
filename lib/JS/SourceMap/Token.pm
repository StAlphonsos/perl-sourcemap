#! perl

=pod

=head1 NAME

JS::SourceMap::Token - One entry in a source map index

=head1 SYNOPSIS

  # don't use us directly, use JS::SourceMap::Decoder and friends

=head1 DESCRIPTION

Instances of this class represent an element in a sourcemap.  Tokens
map a line/column in the minfied code to the real source file, line
and column number in the unminified/combined JS code.  Tokens may also
have a name associated with them if e.g. they happen to be at the
beginning of a function definition, etc.

=cut

package JS::SourceMap::Token;
use strict;
use warnings;

=pod

=over 4

=item * new $dst_line, $dst_col, $src, $src_line, $src_col, $name

Constructor, should not be used directly by user code.  Instead
use L<JS::SourceMap::Decoder>.

=back

=cut

sub new {
	my($class,@args) = @_;
	my $self = {
		dst_line => shift(@args),
		dst_col => shift(@args),
		src => shift(@args),
		src_line => shift(@args),
		src_col => shift(@args),
		name => shift(@args)
	};
	return bless($self,$class);
}

=pod

=over 4

=item * dst_line

=item * dst_col

=item * src

=item * src_line

=item * src_col

=item * name

Accessors for the properties of a token: the minified line and column,
source file name (can be undef), original source line and column and
the name of the entity in the source file (is usually undef).

=back

=cut


sub dst_line	{ shift->{'dst_line'} }
sub dst_col	{ shift->{'dst_col'} }
sub src		{ shift->{'src'} }
sub src_line	{ shift->{'src_line'} }
sub src_col	{ shift->{'src_col'} }
sub name	{ shift->{'name'} }

1;

__END__

=pod

=head1 SEE ALSO

L<JS::SourceMap::Index>, L<JS::SourceMap::Decoder>

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
