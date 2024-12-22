use warnings;
use 5.020;
use experimental qw( signatures );
use stable qw( postderef );
use true;

package App::datasection::Command::diff {

    # ABSTRACT: ...
    # VERSION

    use App::datasection -command;
    use Data::Section::Writer 0.04;
    use Path::Tiny qw( path );
    use Text::Diff qw( diff );

    sub execute ($self, $opt, $args) {

        my @files = map { path($_) } @$args;

        my $dir;
        if($opt->{dir}) {
            $dir = path($opt->{dir})->absolute;
        }

        foreach my $file (@files) {
            my $dir = $dir ? $dir : $file->sibling($file->basename . '.data');

            my $tmp = Path::Tiny->tempfile;
            $tmp->spew_raw($file->slurp_raw);

            if(-d $dir) {
                my $dsw = Data::Section::Writer
                    ->new(perl_filename => $tmp);

                $dir->visit(sub ($path, $state) {
                    return if $path->is_dir;
                    if(-B $path) {
                        $dsw->add_file($path->relative($dir), $path->slurp_raw, 'base64');
                    } else {
                        $dsw->add_file($path->relative($dir), $path->slurp_utf8);
                    }
                }, { recurse => 1 });

                $dsw->update_file;
                unless($dsw->unchanged) {
                    my $diff = diff \$file->slurp_utf8, \$tmp->slurp_utf8;
                    chomp $diff;
                    say "--- a/$file";
                    say "+++ b/$file";
                    say $diff;
                }
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