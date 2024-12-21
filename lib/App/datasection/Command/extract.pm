use warnings;
use 5.020;
use experimental qw( signatures );
use stable qw( postderef );
use true;

package App::datasection::Command::extract {

    # ABSTRACT: ...
    # VERSION

    use App::datasection -command;
    use Data::Section::Pluggable;

    sub opt_spec {
        return (
            [ "dir|d=s" => "Directory to extract to" ],
        );
    }

    sub validate_args ($self, $opt, $args) {
        my(@files) = @$args;
        $self->SUPER::validate_args($opt, $args);
        $self->usage_error("Perl source files are required") unless @files;
        foreach my $file (@files) {
            $self->usage_error("No such file $file") unless -f $file;
        }
    }

    sub execute ($self, $opt, $args) {

        my @files = map { path($_) } @$args;

        my $dir;
        if($opt->{dir}) {
            $dir = path($opt->{dir})->absolute;
        }

        foreach my $file (@files) {
            my $dir = $dir ? $dir : $file->sibling($file->basename . '.data');

            my $dsp = Data::Section::Pluggable
                ->new( file => $file );

            if($dsp->get_data_section->%*) {
                $dir->mkdir;
                $dsp->extract($dir);
            }
        }

    }

}

=head1 DESCRIPTION

...

=head1 SEE ALSO

=over

=item L<App::datasection>

=back

=cut