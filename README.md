# datasection ![static](https://github.com/uperl/App-datasection/workflows/static/badge.svg) ![linux](https://github.com/uperl/App-datasection/workflows/linux/badge.svg)

Work with \_\_DATA\_\_ section files from the command line

# SYNOPSIS

```
datasection extract t/foo.t
datasection diff t/foo.t
datasection insert t/foo.t
```

# DESCRIPTION

This tool is for working with `__DATA__` section files, and lets you
extract, manipulate and re-insert into the `__DATA__` section of Perl
source files.  This tool provides these subcommands:

- [extract](https://metacpan.org/pod/App::datasection::Command::extract)

    ```
    datasection extract [ -d DIRECTORY ] SOURCE [ SOURCE ... ]
    ```

    Extract files from a `__DATA__` section into the filesystem.

- [diff](https://metacpan.org/pod/App::datasection::Command::diff)

    ```
    datasection diff [ -d DIRECTORY ] SOURCE [ SOURCE ... ]
    ```

    See the differences between the filesystem and the `__DATA__`
    section in the Perl source file.

- [insert](https://metacpan.org/pod/App::datasection::Command::insert)

    ```
    datasection insert [ -d DIRECTORY ] SOURCE [ SOURCE ... ]
    ```

    Inser the files from the filesystem into Perl source `__DATA__`
    section.

# SEE ALSO

- [Data::Section::Writer](https://metacpan.org/pod/Data::Section::Writer)
- [Data::Section::Pluggable](https://metacpan.org/pod/Data::Section::Pluggable)

# AUTHOR

Graham Ollis <plicease@cpan.org>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2024 by Graham Ollis.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
