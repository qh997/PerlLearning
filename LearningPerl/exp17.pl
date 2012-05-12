#!/usr/bin/env perl

use 5.010;

# 用 eval 捕获错误
eval {$barney = $fred / $dino};
warn $@ if $@;
$barney = eval {$fred / $dino} // 'undefine';
say "[$barney]";

# 用 grep 来筛选列表
my @odd_numbers = grep {$_ % 2} 1..100;
say "@odd_numbers";
@odd_numbers = grep $_ % 2 - 1, 1..100;
say "@odd_numbers";

# 切片
my $mtime = (stat 'text01')[9];
say $mtime;

@names = qw(gengs.s gs gengshuang gengs shuang.g s.geng);
($frist, $last) = (sort @names)[0, -1];
say "$frist ... $last";
say "@names[2, 4, 0]";

my %score = ("barney" => 195, "fred" => 205, "dino" => 30, "bamm-bamm" => 195);
my @three_scores = @score{(barney, fred, dino)};
say "@three_scores";