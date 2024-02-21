# t/2023/001-social.t
use 5.14.0;
use warnings;
use Test::More;

use Business::Tax::US::Form_1040::Worksheets qw(
    social_security_benefits
);
use Data::Dump qw(dd pp);


note('social_security_benefits()');
my ($benefits);

# See t/2022/001-social.t for tests of error conditions, warnings, etc.
# for social_security_benefits().

{
    my ($inputs, $expect);
    $inputs = {
        box5    => 33000.00,
        l1z     => 0,
        l2b     => 400.00,
        l3b     => 6200.00,
        l4b     => 0,
        l5b     => 8400.00,
        l7      => 1700.00,
        l8      => 1000.00,
        l2a     => 0,
        s1l11     => 0,
        s1l12     => 0,
        s1l13     => 0,
        s1l14     => 0,
        s1l15     => 0,
        s1l16     => 0,
        s1l17     => 0,
        s1l18     => 0,
        s1l19     => 0,
        s1l20     => 0,
        s1l23     => 0,
        s1l25     => 0,
        status     => 'single',
        filing_year => 2023,
    };
    $expect = 4670;
    $benefits = social_security_benefits( $inputs );
    cmp_ok(abs($benefits - $expect), '<', 1,
        "Result $benefits is within expected tolerance from $expect"
    );
}

{
    note("Numeric fields undef rather than 0");
    my ($inputs, $expect);
    $inputs = {
        box5    => 33000.00,
        l1z     => 0,
        l2b     => 400.00,
        l3b     => 6200.00,
        l4b     => 0,
        l5b     => 8400.00,
        l7      => 1700.00,
        l8      => 1000.00,
        l2a     => 0,
        s1l11     => undef,
        s1l12     => undef,
        s1l13     => undef,
        s1l14     => undef,
        s1l15     => undef,
        s1l16     => undef,
        s1l17     => undef,
        s1l18     => undef,
        s1l19     => undef,
        s1l20     => undef,
        s1l23     => undef,
        s1l25     => undef,
        status     => 'single',
        filing_year => 2023,
    };
    $expect = 4670;
    $benefits = social_security_benefits( $inputs );
    cmp_ok(abs($benefits - $expect), '<', 1,
        "Result $benefits is within expected tolerance from $expect"
    );
}

{
    note("Numeric fields may be skipped if value is 0");
    my ($inputs, $expect);
    $inputs = {
        box5    => 33000.00,
        #l1z     => 0,
        l2b     => 400.00,
        l3b     => 6200.00,
        #l4b     => 0,
        l5b     => 8400.00,
        l7      => 1700.00,
        l8      => 1000.00,
        #l2a     => 0,
        #s1l11     => undef,
        #s1l12     => undef,
        #s1l13     => undef,
        #s1l14     => undef,
        #s1l15     => undef,
        #s1l16     => undef,
        #s1l17     => undef,
        #s1l18     => undef,
        #s1l19     => undef,
        #s1l20     => undef,
        #s1l23     => undef,
        #s1l25     => undef,
        status     => 'single',
        filing_year => 2023,
    };
    $expect = 4670;
    $benefits = social_security_benefits( $inputs );
    cmp_ok(abs($benefits - $expect), '<', 1,
        "Result $benefits is within expected tolerance from $expect"
    );
}

{
    note("Schedule 1: large entries cause early return of 0");
    my ($inputs, $expect);
    $inputs = {
        box5    => 33000.00,
        l1z     => 0,
        l2b     => 400.00,
        l3b     => 6200.00,
        l4b     => 0,
        l5b     => 8400.00,
        l7      => 1700.00,
        l8      => 1000.00,
        l2a     => 0,
        s1l11     => 5000,
        s1l12     => 5000,
        s1l13     => 5000,
        s1l14     => 5000,
        s1l15     => 5000,
        s1l16     => 5000,
        s1l17     => 5000,
        s1l18     => 0,
        s1l19     => 0,
        s1l20     => 0,
        s1l23     => 0,
        s1l25     => 0,
        status     => 'single',
        filing_year => 2023,
    };
    $expect = 0;
    $benefits = social_security_benefits( $inputs );
    cmp_ok(abs($benefits - $expect), '<', 1,
        "Result $benefits is within expected tolerance from $expect"
    );
}

{
    note("status => married_sep");
    my ($inputs, $expect);
    $inputs = {
        box5    => 33000.00,
        l1z     => 0,
        l2b     => 400.00,
        l3b     => 6200.00,
        l4b     => 0,
        l5b     => 8400.00,
        l7      => 1700.00,
        l8      => 1000.00,
        l2a     => 0,
        s1l11     => 0,
        s1l12     => 0,
        s1l13     => 0,
        s1l14     => 0,
        s1l15     => 0,
        s1l16     => 0,
        s1l17     => 0,
        s1l18     => 0,
        s1l19     => 0,
        s1l20     => 0,
        s1l23     => 0,
        s1l25     => 0,
        status     => 'married_sep',
        filing_year => 2023,
    };
    $expect = 28050;
    $benefits = social_security_benefits( $inputs );
    cmp_ok(abs($benefits - $expect), '<', 1,
        "Result $benefits is within expected tolerance from $expect"
    );
}

{
    note("status => married");
    my ($inputs, $expect);
    $inputs = {
        box5    => 33000.00,
        l1z     => 0,
        l2b     => 400.00,
        l3b     => 6200.00,
        l4b     => 0,
        l5b     => 8400.00,
        l7      => 1700.00,
        l8      => 1000.00,
        l2a     => 0,
        s1l11     => 0,
        s1l12     => 0,
        s1l13     => 0,
        s1l14     => 0,
        s1l15     => 0,
        s1l16     => 0,
        s1l17     => 0,
        s1l18     => 0,
        s1l19     => 0,
        s1l20     => 0,
        s1l23     => 0,
        s1l25     => 0,
        status     => 'married',
        filing_year => 2023,
    };
    $expect = 1100;
    $benefits = social_security_benefits( $inputs );
    cmp_ok(abs($benefits - $expect), '<', 1,
        "Result $benefits is within expected tolerance from $expect"
    );
}

{
    note("worksheet line 8 greater than worksheet line 7");
    my ($inputs, $expect);
    $inputs = {
        box5    => 12000.00,
        l1z     => 2000.00,
        l2b     => 2000.00,
        l3b     => 2000.00,
        l4b     => 2000.00,
        l5b     => 2000.00,
        l7      => 2000.00,
        l8      => 400.00,
        l2a     => 0,
        s1l11     => 0,
        s1l12     => 0,
        s1l13     => 0,
        s1l14     => 0,
        s1l15     => 0,
        s1l16     => 0,
        s1l17     => 0,
        s1l18     => 0,
        s1l19     => 0,
        s1l20     => 0,
        s1l23     => 0,
        s1l25     => 0,
        status     => 'single',
        filing_year => 2023,
    };
    $expect = 0;
    $benefits = social_security_benefits( $inputs );
    cmp_ok(abs($benefits - $expect), '<', 1,
        "Result $benefits is within expected tolerance from $expect"
    );
}

done_testing();
