use warnings;
use 5.020;
use experimental qw( signatures );
use stable qw( postderef );
use true;

package App::datasection::Command::extract {

    # ABSTRACT: ...
    # VERSION

    use App::datasection -command;
    use Data::Section::Pluggable 0.08;
    use Path::Tiny qw( path );

    sub execute ($self, $opt, $args) {

        my @files = map { path($_) } @$args;

        my $dir;
        if($opt->{dir}) {
            $dir = path($opt->{dir})->absolute;
        }

        foreach my $file (@files) {
            my $dir = $dir ? $dir : $file->sibling($file->basename . '.data');

            my $dsp = Data::Section::Pluggable
                ->new( filename => $file );

            if($dsp->get_data_section->%*) {
                $dir->mkdir;
                $dsp->extract($dir);
                say $file;
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