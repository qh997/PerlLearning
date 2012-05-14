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
    ggg => '1',
    jjj => '2',
    xxx => '3',
    iii => '4',
    uuu => '5',
);
$map_s = %map;
say $map_s;

# 多键值仿真多维数组
%people;
$people{0, 0} = "xxx";
$people{join $; => 0, 1} = "yyy";
$people{0, 0, 0} = "zzz";
say $people{0, 0};
say $people{0, 1};
say $people{0, 0, 0};
say %people;
say $people{0, 0};

$aa = join $;, 0, 0;
$bb = join $;, 0, 1;
$cc = join $;, 0, 0, 0;
say @people{$aa, $bb, $cc};

# typeglob 和文件句柄
$fh = *STDOUT;
print $fh "Hello typeglobe!\n";
*foo = *bar;
$bar = '007';
say $foo;

# 行输入（尖角）操作符
while (<>) {
    print 'I  : ';
    print;
}

# 上面的代码等效于
@ARGV = ('-') unless @ARGV;
while (@ARGV) {
    $ARGV = shift @ARGV;
    say $ARGV;
    if (!open(ARGV, $ARGV)) {
        warn "Can't open $ARGV: $!\n";
        next;
    }
    while (<ARGV>) {
        print 'II :'.$..' ';
        print;
    }
}

# 文件名 glob 操作符
@files = <*.pl>;
say "@files";
@files = glob("*.pl");
say "@files";

($file) = <*.pl>; # 列表环境
say $file;
$file = <*.pl>; # 标量环境
say $file;