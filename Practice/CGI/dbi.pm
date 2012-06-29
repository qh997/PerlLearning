package dbi;

use warnings;
use strict;
use DBI;

sub get_platform_list {
    my $dbh = db_connect();
    my $sth = $dbh->prepare('SELECT DISTINCT build.build_name FROM build');
    $sth->execute();

    my @platforms;
    while (my $row = $sth->fetchrow_hashref) {
        push @platforms, $row->{'build_name'};
    }

    $dbh->disconnect();
    return @platforms;
}

sub get_buildnumber_list {
    shift;
    my $platform = shift;

    my $dbh = db_connect();
    my $sth = $dbh->prepare("
        SELECT DISTINCT number
        FROM build
        WHERE build_name='$platform'
        ORDER BY number DESC");
    $sth->execute();

    my @builds;
    while (my $row = $sth->fetchrow_hashref) {
        push @builds, $row->{'number'};
    }

    $dbh->disconnect();
    return @builds;
}

sub get_category_list {
    my $dbh = db_connect();
    my $sth = $dbh->prepare("
        SELECT DISTINCT category
        FROM suite
        WHERE category != ''
        ORDER BY category");
    $sth->execute();

    my @categorys;
    while (my $row = $sth->fetchrow_hashref) {
        push @categorys, $row->{'category'};
    }

    $dbh->disconnect();
    return @categorys;
}

sub get_testcase_list {
    shift;
    my $platform = shift;
    my $buildnumber = shift;
    my $category = shift;

    my $sql = $category ne 'Apps_Perf'
        ? "
            SELECT DISTINCT suite.feature
            FROM suite
                JOIN testcase ON testcase.suite_id = suite.id
                JOIN test ON testcase.id = test.testcase_id
                JOIN build ON test.build_id = build.id
            WHERE build.build_name = '$platform'
                AND build.number = $buildnumber
                AND suite.category = '$category'
            ORDER BY suite.feature
        " : "
            SELECT DISTINCT data.value AS feature
            FROM data
                JOIN test ON data.test_id = test.id
                JOIN build ON test.build_id = build.id
                JOIN testcase ON test.testcase_id = testcase.id
                JOIN suite ON testcase.suite_id = suite.id
            WHERE data.key = 'AppName'
                AND build.build_name = '$platform'
                AND build.number = $buildnumber
                AND suite.category = '$category'
            ORDER BY feature
        ";

    my $dbh = db_connect();
    my $sth = $dbh->prepare($sql);
    $sth->execute();

    my @testcases;
    while (my $row = $sth->fetchrow_hashref) {
        push @testcases, $row->{'feature'};
    }

    $dbh->disconnect();
    return @testcases;
}

sub db_connect {
    return DBI->connect('DBI:mysql:database=katf;host=10.1.10.112', 'katf', 'K1tf');
}

return 1;