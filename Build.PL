use strict;
use warnings;
use Config qw[%Config];
use File::Find qw[find];
use inc::MBX::Alien::FLTK;
$|++;
my $automated_testing = $ENV{AUTOMATED_TESTING} || $ENV{PERL_MM_USE_DEFAULT};
my $is_developer = ((-d '.git') ? 1 : 0) or ($ENV{RELEASE_TESTING} ? 1 : 0);
my @tests;
find \&find_cb, qw[t/0000_use];
@tests = sort @tests;
my $class = 'inc::MBX::Alien::FLTK' . ($is_developer ? '::Developer' : '');

if (!eval "require $class") {
    printf 'Failed to load %s: %s This ain\'t good, so... bye!', $class, $@;
    exit 0;
}
my $mb = $class->new(
    module_name => 'Alien::FLTK',
    license     => 'artistic_2',
    dist_author => 'Sanko Robinson <sanko@cpan.org>',
    requires    => {
        'Archive::Extract'   => 0,
        base                 => 0,
        Carp                 => 0,
        Config               => 0,
        Cwd                  => 0,
        'Digest::MD5'        => 0,
        'File::Basename'     => 0,
        'File::Fetch'        => 0,
        'File::Find'         => 0,
        'File::Path'         => 2.07,
        'File::Spec'         => 0,          # used in A::F proper
        'File::Temp'         => 0,
        'Test::More'         => 0.88,
        'Module::Build'      => 0.35,
        'ExtUtils::CBuilder' => 0.27,
        perl                 => 5.008000,
        (  ($^O eq 'VMS') ? ('VMS::DCLsym' => 0)
         : ()
        )
    },
    build_requires => {'Archive::Extract'   => 0,
                       base                 => 0,
                       Carp                 => 0,
                       Config               => 0,
                       Cwd                  => 0,
                       'Digest::MD5'        => 0,
                       'File::Basename'     => 0,
                       'File::Fetch'        => 0,
                       'File::Find'         => 0,
                       'File::Path'         => 2.07,
                       'File::Spec'         => 0,
                       'File::Temp'         => 0,
                       'Test::More'         => 0.88,
                       'Module::Build'      => 0.35,
                       'ExtUtils::CBuilder' => 0.27,
                       perl                 => 5.008000,
                       (  ($^O eq 'VMS') ? ('VMS::DCLsym' => 0)
                        : ()
                       )
    },
    add_to_cleanup => [qw[Alien-FLTK-* src/*],
                       map {"*$_"} (
                             '.' . $Config{'so'}, $Config{'_o'}, $Config{'_a'}
                       )
    ],
    no_index   => {directory => [qw[t example inc]]},
    test_files => \@tests,
    meta_merge => {
        generated_by => 'Conversion, software version 7.0',
        keywords =>
            [qw[Alien FLTK Fast Light Toolkit widget FL GUI UI window]],
        resources => {
            bugtracker => 'http://github.com/sanko/alien-fltk/issues',
            ChangeLog  => 'http://github.com/sanko/alien-fltk/commits/master',
            homepage   => 'http://sanko.github.com/fltk-perl/',
            license => 'http://www.perlfoundation.org/artistic_license_2_0',

            #MailingList => 'TODO',
            repository => 'http://github.com/sanko/alien-fltk'
        }
    },
    needs_compiler => 1    # adds ExtUtils::CBuilder to build_requires
);

#$mb->notes(use_x     => 0);           # TODO - find_lib
#$mb->notes(use_glut  => 0);           # TODO
#$mb->notes(use_gl    => 1);
#$mb->notes(use_forms => 0);           # TODO
##################################################################### TODO ###
$mb->notes(automated_testing => $automated_testing     ? 1 : 0);
$mb->notes(release_testing   => $is_developer);
$mb->notes(test_suite        => \@tests);
$mb->notes(gmtime            => scalar gmtime);
$mb->notes(threads           => $Config{'useithreads'} ? 1 : 0);
$mb->notes(snapshot_dir => 'working/snapshot/');    # archive location
$mb->notes(extract_dir  => 'working/extract/');     # extracted source
#################################### 'Dynamic' values used by build system ###
$mb->notes(svn => $mb->dist_version =~ m[\.0?+(\d+)]);
$mb->notes(branch => '1.3.x');

if (1) {
    $mb->notes(svn                 => 7008);
    $mb->notes(branch              => '1.3.x');
    $mb->notes(md5_gz              => 'adfc4746c7b2bf7e895612d118ab8f2f');
    $mb->notes(md5_bz2             => '7589b3523045b7c059026de21564e68d');
    $mb->notes(include_path_images => '');
    $mb->notes(include_path_compatability => '');
    $mb->notes(headers_path               => 'FL');
    $mb->notes(ldflags                    => ' -lfltk ');
    $mb->notes(ldflags_image =>
             ' -lfltk_images -lfltk_png -lfltk_z -lfltk_images -lfltk_jpeg ');
    $mb->notes(use_cairo => undef);    # TODO - MacOS
    $mb->notes(
        libs_source => {
            fltk => {
                directory => 'src',
                source    => [
                    (  map { $_ . '.c' }
                           qw[fl_call_main flstring scandir numericsort
                           vsnprintf fl_utf]
                    ),
                    (map { $_ . '.cxx' } 'Fl',
                     'screen_xywh',
                     (map { 'Fl_' . $_ }
                          qw[Adjuster Bitmap Browser Browser_ Browser_load Box
                          Button Chart Check_Browser Check_Button Choice Clock
                          Color_Chooser Counter Dial Double_Window
                          File_Browser File_Chooser File_Chooser2 File_Icon
                          File_Input Group Help_View Image Input Input_
                          Light_Button Menu Menu_ Menu_Bar Sys_Menu_Bar
                          Menu_Button Menu_Window Menu_add Menu_global
                          Multi_Label Overlay_Window Pack Pixmap Positioner
                          Preferences Progress Repeat_Button Return_Button
                          Roller Round_Button Scroll Scrollbar Shared_Image
                          Single_Window Slider Table Table_Row Tabs
                          Text_Buffer Text_Display Text_Editor Tile
                          Tiled_Image Tree Tree_Item Tree_Item_Array
                          Tree_Prefs Tooltip Valuator Value_Input Value_Output
                          Value_Slider Widget Window Window_fullscreen
                          Window_hotspot Window_iconize Wizard XBM_Image
                          XPM_Image abort add_idle arg compose display get_key
                          get_system_colors grab lock own_colormap visual x]
                     ),
                     (map { 'filename_' . $_ }
                          qw[absolute expand ext isdir list match setext]
                     ),
                     (map { 'fl_' . $_ }
                          qw[arc arci ask boxtype color cursor curve
                          diamond_box dnd draw draw_image draw_pixmap
                          encoding_latin1 encoding_mac_roman engraved_label
                          file_dir font gtk labeltype line_style open_uri
                          oval_box overlay overlay_visual plastic read_image
                          rect round_box rounded_box set_font set_fonts
                          scroll_area shadow_box shortcut show_colormap
                          symbols vertex utf8]
                     )
                    ),
                    (map { 'xutf8/' . $_ . '.c' }
                         qw[case is_right2left is_spacing keysym2Ucs utf8Input
                         utf8Utils utf8Wrap]
                    ),
                ]
            },
            fltk_forms => {
                    directory => 'src',
                    source    => [
                        map { 'forms_' . $_ . '.cxx' }
                            qw[compatability bitmap free fselect pixmap timer]
                    ]
            },
            fltk_gl => {
                directory => 'src',
                source    => [
                    map { $_ . '.cxx' }
                        qw[Fl_Gl_Choice Fl_Gl_Overlay Fl_Gl_Window
                        freeglut_geometry freeglut_stroke_mono_roman
                        freeglut_stroke_roman freeglut_teapot gl_draw gl_start
                        glut_compatability glut_font]
                ]
            },
            fltk_image => {
                directory => 'src',
                source    => [
                    map { $_ . '.cxx' }
                        qw[fl_images_core Fl_BMP_Image Fl_File_Icon2
                        Fl_GIF_Image Fl_Help_Dialog Fl_JPEG_Image Fl_PNG_Image
                        Fl_PNM_Image]
                ]
            }
        }
    );
}
else {
    $mb->notes(svn                 => 6970);
    $mb->notes(branch              => '2.0.x');
    $mb->notes(md5_gz              => '8159cabebbd1b5b774b277827aa4e030');
    $mb->notes(md5_bz2             => 'f78976d0ba1a5c845e14f4df96d580a0');
    $mb->notes(include_path_images => '/images');
    $mb->notes(include_path_compatability => '/fltk/compat');
    $mb->notes(headers_path               => 'fltk');
    $mb->notes(ldflags                    => ' -lfltk2 ');
    $mb->notes(ldflags_image =>
          ' -lfltk2_images -lfltk2_png -lfltk2_z -lfltk2_images -lfltk2_jpeg '
    );
    $mb->notes(use_cairo => 0);    # TODO - MacOS
    $mb->notes(
        libs_source => {
            fltk2_images => {
                directory => 'images',
                source    => [
                    map { $_ . '.cxx' }
                        qw[FileIcon2 Fl_Guess_Image fl_jpeg fl_png HelpDialog
                        images_core pnmImage xpmFileImage]
                ]
            },
            fltk2_z => {
                directory => 'images/zlib',
                source    => [
                    map { $_ . '.c' }
                        qw[adler32 compress crc32 gzio uncompr deflate trees
                        zutil inflate inftrees inffast infblock infcodes
                        infutil]
                ]
            },
            fltk2_jpeg => {
                directory => 'images/libjpeg',
                source    => [
                    map { $_ . '.c' }
                        qw[jmemnobs jcapimin jcapistd jccoefct jccolor
                        jcdctmgr jchuff jcinit jcmainct jcmarker jcmaster
                        jcomapi jcparam jcphuff jcprepct jcsample jctrans
                        jdapimin jdapistd jdatadst jdatasrc jdcoefct jdcolor
                        jddctmgr jdhuff jdinput jdmainct jdmarker jdmaster
                        jdmerge jdphuff jdpostct jdsample jdtrans jerror
                        jfdctflt jfdctfst jfdctint jidctflt jidctfst jidctint
                        jidctred jquant1 jquant2 jutils jmemmgr]
                ]
            },
            fltk2_png => {
                directory => 'images/libpng',
                include   => 'zlib',
                source    => [
                    map { $_ . '.c' }
                        qw[png pngset pngget pngrutil pngtrans pngwutil
                        pngread pngrio pngwio pngwrite pngrtran pngwtran
                        pngmem pngerror pngpread]
                ]
            },
            fltk2 => {
                directory => 'src',
                source    => [
                    (map { $_ . '.c' } qw[scandir string utf vsnprintf]),
                    (map { $_ . '.cxx' }
                         qw[add_idle addarc addcurve Adjuster AlignGroup
                         AnsiWidget args BarGroup bmpImage Browser
                         Browser_load Button CheckButton Choice clip Clock
                         Color color_chooser ComboBox compose Cursor
                         CycleButton default_glyph Dial DiamondBox dnd
                         drawtext EngravedLabel error event_key_state
                         file_chooser FileBrowser FileChooser FileChooser2
                         FileIcon FileInput filename_absolute filename_ext
                         filename_isdir filename_list filename_match
                         filename_name fillrect Fl_Menu_Item FloatInput
                         fltk_theme Font gifImage Group GSave HelpView
                         HighlightButton Image Input InputBrowser
                         InvisibleWidget Item key_name LightButton list_fonts
                         load_plugin lock Menu Menu_add Menu_global Menu_popup
                         MenuBar MenuWindow message MultiImage NumericInput
                         numericsort Output OvalBox overlay_rect own_colormap
                         PackedGroup path PlasticBox PopupMenu Preferences
                         ProgressBar RadioButton readimage RepeatButton
                         ReturnButton RoundBox RoundedBox run Scrollbar
                         ScrollGroup scrollrect setcolor setdisplay setvisual
                         ShadowBox ShapedWindow SharedImage ShortcutAssignment
                         show_colormap Slider StatusBarGroup StringList Style
                         StyleSet Symbol SystemMenuBar TabGroup TabGroup2
                         TextBuffer TextDisplay TextEditor ThumbWheel
                         TiledGroup TiledImage Tooltip UpBox Valuator
                         ValueInput ValueOutput ValueSlider Widget Widget_draw
                         WidgetAssociation Window Window_fullscreen
                         Window_hotspot Window_iconize WizardGroup xbmImage
                         xpmImage]
                    )
                ]
            },
            fltk2_gl => {
                directory => 'OpenGL',
                source    => [
                    map { $_ . '.cxx' }
                        qw[Fl_Gl_Choice Fl_Gl_Overlay Fl_Gl_Window gl_draw
                        gl_start]
                ]
            },
            fltk2_glut => {
                    directory => 'glut',
                    source =>
                        [map { $_ . '.cxx' } qw[glut_compatability glut_font]]
            }
        }
    );
}
############################################################## Get to work ###
#for my $action (qw[fetch_fltk extract_fltk configure_fltk write_config_h]) {
#    $mb->depends_on($action);
#    $mb->dispatch('check_errors');
#}
$mb->create_build_script;
##############################################################################
exit 0;

sub find_cb {
    return if -d $_ or -l $_;
    return unless -T $_;
    return unless $_ =~ m[.+\.t$];
    return push @tests, $File::Find::name;
}

=pod

=head1 NAME

Build.PL - Module::Build based install

=head1 Description

C<Build.PL> creates the 'Build' script which... meh, you know what C<Build.PL>
is for.

Anyway, when this one decides that it is being run by an L<Alien::FLTK>
Developer (or just some random person who checked out the source from git) it
loads a "special" L<Module::Build|Module::Build> subclass filled with useless
things I've wasted my time pasting together. Otherwise, it loads a rather tame
subclass which works well enough for most end users.

=head1 Requirements

=over

=item L<Alien::FLTK|Alien::FLTK> is licensed under the Artistic License 2.0
(see the L<License and Legal|/"License and Legal"> section) so this
C<Build.PL> requires at least L<Module::Build|Module::Build> C<0.3>.

=item I've set an arbitrary minimum perl version at 5.8.8 not because I've
tested L<Alien::FLTK|Alien::FLTK> with anything lower than that and failed,
but because I really don't care for test reports from ancient builds.

=back

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
