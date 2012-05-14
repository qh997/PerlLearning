#!/usr/bin/env perl
# 第二章 集腋成裘

use 5.010;

# "此处"文档
$Price = '99.99';

print <<EOF;
The price is $Price.
EOF

print <<"EOF";
The price is $Price.
EOF

print <<'EOF';
The price is $Price.
EOF

print <<"" x 10;
The Camels are coming! Hurrah! Hurrah!

print <<`EOC`;
echo hi there
echo lo there
EOC

print <<'odd'
2345
odd
    +10000;
print "\n";

# V-字符串直接量
say v9786;
say v120.111.111;
say $^V;
say __FILE__.':'.__LINE__.':'.__PACKAGE__;

# 环境
$scal_env = list_or_scalar();
@arra_env = list_or_scalar();
sub list_or_scalar {
    say wantarray;
}

# 列表值和数组
@names = ('gengs', 'chxy', 'xushsh');
say "@names";
$name = ('gengs', 'chxy', 'xushsh');
say $name;
$name = @names;
say $name;

$mtime = (stat($0))[9];
say $mtime;
($day, $month, $year) = (localtime)[3, 4, 5];
say "$year-$month-$day";

$x = (($a, $b) = (7, 7, 7));
say $x;

# 数组长度
@whatever = ('gengs', 'chxy', 'xushsh');
say "@whatever";
undef @whatever;
say "@whatever";
@whatever = ('gengs', 'chxy', 'xushsh');
@whatever = undef;
say "@whatever";

# 散列
%map = (
    gengs => 'gengshuang',
    changxy => 'changxingye',
    xuejj => 'xuejiajia',
    lij => 'lijia',
    guos => 'guoshuai',
);
$map_s = %map;
say $map_s;
