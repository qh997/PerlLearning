#!/usr/bin/env perl
# 第九章 数据结构

use 5.010;

sub ps {say '-' x 45}

# 数组的数组
## 创建和访问二维数组
$AoA[0][0][0] = 'gengs'; # 从上一章知道，可以这样直接创建
say "$AoA[0]->$AoA[0][0]->$AoA[0][0][0]";

@AoA = (
    ["fred", "barney"],
    ["george", "jane", "elroy"],
    ["homer", "merge", "bart"],
);
say "\$AoA[2][1] = $AoA[2][1]";

$ref_to_AoA = [
    ["fred", "barney"],
    ["george", "jane", "elroy"],
    ["homer", "merge", "bart"],
];
say "\$ref_to_AoA->[2][2] = $ref_to_AoA->[2][2]";
ps;

## 自行生长
@tmp = qw(gengs sgeng);
push @AoA, [@tmp];
say "\$AoA[3][1] = $AoA[3][1]";

push @AoA, [qw(gs sg)];
say "\$AoA[4][1] = $AoA[4][1]";

push @{$AoA[0]}, "wilma", "betty";
say "\$AoA[0][3] = $AoA[0][3]";
ps;

## 打印
for my $row (@AoA) {
    say "\@\$row = @$row";
}
ps;

## 片段
@part = @{$AoA[0]}[1..3];
say "@part";

for (1..3) {
    push @newAoA, [@{$AoA[$_]}[1..3]];
}
say "$newAoA[2][0]";
ps;

# 数组的散列
%HoA = (
    flintstones => ["fred", "barney"],
    jetsons => ["george", "jane", "elroy"],
    simpsons => ["omer", "marge", "bart"],
);
say "\$HoA{jetsons}[2] = $HoA{jetsons}[2]";