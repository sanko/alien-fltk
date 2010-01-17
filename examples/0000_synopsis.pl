use strict;
use warnings;
{
    use Alien::FLTK;
    use ExtUtils::CBuilder;
    my $AF  = Alien::FLTK->new();
    my $CC  = ExtUtils::CBuilder->new();
    my $SRC = 'hello_world.cxx';
    open(my $FH, '>', $SRC) || die '...';
    syswrite($FH, <<'') || die '...'; close $FH;
      #include <FL/Fl.H>
      #include <FL/Fl_Window.H>
      #include <FL/Fl_Box.H>
      int main(int argc, char **argv) {
        Fl_Window *window = new Fl_Window(300,180);
        Fl_Box *box = new Fl_Box(FL_UP_BOX, 20, 40, 260, 100, "Hello, World!");
        box->labelfont(FL_BOLD + FL_ITALIC);
        box->labelsize(36);
        box->labeltype(FL_SHADOW_LABEL);
        window->end();
        window->show(argc, argv);
        return Fl::run();
    }

    my $OBJ = $CC->compile('C++'                => 1,
                           source               => $SRC,
                           include_dirs         => [$AF->include_dirs()],
                           extra_compiler_flags => $AF->cxxflags()
    );
    my $EXE =
        $CC->link_executable(objects            => $OBJ,
                             extra_linker_flags => $AF->ldflags());
    print system('./' . $EXE) ? 'Aww...' : 'Yay!';
    END { unlink grep defined, $SRC, $OBJ, $EXE; }
}

=pod

=head1 Author

Sanko Robinson <sanko@cpan.org> - http://sankorobinson.com/

CPAN ID: SANKO

=head1 License and Legal

Copyright (C) 2009 by Sanko Robinson E<lt>sanko@cpan.orgE<gt>

This program is free software; you can redistribute it and/or modify it under
the terms of The Artistic License 2.0. See the F<LICENSE> file included with
this distribution or http://www.perlfoundation.org/artistic_license_2_0.  For
clarification, see http://www.perlfoundation.org/artistic_2_0_notes.

When separated from the distribution, all POD documentation is covered by the
Creative Commons Attribution-Share Alike 3.0 License. See
http://creativecommons.org/licenses/by-sa/3.0/us/legalcode.  For
clarification, see http://creativecommons.org/licenses/by-sa/3.0/us/.

=for git $Id$

=cut
