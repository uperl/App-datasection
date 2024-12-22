use warnings;
use 5.020;
use experimental qw( signatures );
use stable qw( postderef );
use true;

package App::datasection::Command {

    # ABSTRACT: Base class for datasection subcommands
    # VERSION

=head1 SYNOPSIS

 perldoc datasection

=head1 DESCRIPTION

This is an internal class for L<datasection>.

=cut

    use App::Cmd::Setup -command;

    sub opt_spec {
        return (
            [ "dir|d=s" => "Directory to extract to" ],
        );
    }

    sub validate_args ($self, $opt, $args) {
        my(@files) = @$args;
        $self->usage_error("Perl source files are required") unless @files;
        foreach my $file (@files) {
            $self->usage_error("No such file $file") unless -f $file;
        }
    }

}
