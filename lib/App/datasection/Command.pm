use warnings;
use 5.020;
use experimental qw( signatures );
use stable qw( postderef );
use true;

package App::datasection::Command {

    # ABSTRACT: Base class for datasection subcommands
    # VERSION

    use App::Cmd::Setup -command;

    sub validate_args ($self, $opt, $args) {
    }

}
