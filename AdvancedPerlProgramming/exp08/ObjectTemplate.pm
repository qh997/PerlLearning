package ObjectTemplate;

use 5.010;
use strict;
use warnings;
use Exporter;

our @ISA = qw(Exporter);
our @EXPORT = qw(attributes);

my $debugging = 0;

sub attributes {
    no strict 'refs';

    my $pkg = caller;
    @{"${pkg}::_ATTRIBUTES_"} = @_;
    my $code = "";
    foreach my $attr (get_attribute_name($pkg)) {
        @{"${pkg}::_$attr"} = ();
        unless ($pkg->can("$attr")) {
            $code .= _define_accessor($pkg, $attr);
        }
    }
    $code .= _define_constructor($pkg);
    eval $code;
    if ($@) {
        die "ERROR defining constructor and attributes for $pkg\n"
            ."\t$@\n"
            ."-" x 45
            .$code;
    }
}

sub _define_accessor {
    my ($pkg, $attr) = @_;
    my $code = qq{
        package $pkg;
        sub $attr {
            \@_ > 1 ? \$_${attr}\[\${\$_[0]}] = \$_[1]
                    : \$_${attr}\[\${\$_[0]}];
        }
        if (!defined \$_free) {
            \*_free = \*_$attr;
            \$_free = 0;
        }
    };

    return $code;
}

1;