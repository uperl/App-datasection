use warnings;
use 5.020;
use experimental qw( signatures );
use stable qw( postderef );
use true;

package App::datasection::Command::insert {

    # ABSTRACT: Insert files from the file system into Perl source __DATA__ section
    # VERSION

    use App::datasection -command;
    use Data::Section::Writer 0.04;
    use Path::Tiny qw( path );

    sub execute ($self, $opt, $args) {

        my @files = map { path($_) } @$args;

        my $dir;
        if($opt->{dir}) {
            $dir = path($opt->{dir})->absolute;
        }

        foreach my $file (@files) {
            my $dir = $dir ? $dir : $file->sibling($file->basename . '.data');

            if(-d $dir) {
                my $dsw = Data::Section::Writer
                    ->new(perl_filename => $file);

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
                    say $file;
                }
            }
        }
    }

}

=head1 SYNOPSIS

 datasection insert [ -d DIRECTORY ] SOURCE [ SOURCE ... ]

=head1 DESCRIPTION

This subcommand inserts the files located on the filesystem
into the Perl source file or files.  By default it uses a
separate directory for each source file (named as the source
filename with C<.data> appended to it).  You can alternatively
specify your own directory with the C<-d> option.

=head1 SEE ALSO

=over 4

=item L<App::datasection::Command::extract>

=item L<App::datasection::Command::diff>

=item L<App::datasection::Command::insert>

=back

=cut