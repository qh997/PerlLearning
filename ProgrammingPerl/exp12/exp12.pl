#!/usr/bin/env perl

use strict;
use warnings;
use 5.010;

use Girl;
use Echelon;

sub ps {say '-' x 45}

my $obj = {};
say $obj;
say ref $obj;
bless $obj, 'Girl';
say $obj;
say ref $obj;
ps;

my $pet = Girl->adoption(name => 'lijia');
say $pet;
say $pet->{name};

my $pet1 = $pet->adoption;
say $pet1;
ps;

## 初启程序
my $ed = Echelon->new;
say '$ed->{hair} = '.$ed->{hair};

my $stallion = Echelon->new(hair => "short");
say '$stallion->{hair} = '.$stallion->{hair};

my $foal = $stallion->clone(owner => 'Geng Shuang, Ltd.');
say '$foal->{hair} = '.$foal->{hair};
say '$foal->{owner} = '.$foal->{owner};
ps;

# 类继承
my $pet2 = Echelon->adoption(name => 'changxy');
say $pet2;
$pet2->move;
ps;

## 访问被覆盖的方法
{
    package Echelon;
    sub speak {
        my $self = shift;
        say $self->{name}.' : Hello!';
    }
}
my $pet3 = Echelon->adoption(name => 'changxy');
$pet3->speak;
ps;

## UNIVERSAL：最终的祖先类
### INVOCANT->isa(CLASS)
say '$pet3 is a HASH : '.$pet3->isa('HASH');

use FileHandle;

if (FileHandle->isa("Exporter")) {
    say "FileHandle is an Exporter.";
}

my $fh = FileHandle->new();
if ($fh->isa("IO::Handle")) {
    say "\$fh is some sort of IOish object.";
}
if ($fh->isa("GLOB")) {
    say "\$fh is really a GLOB reference.";
}
ps;

### INVOCANT->can(METHOD)
if ($pet3->can('caress')) {
    say $pet3->{name}.' can caress';
}
$pet3->caress if $pet3->can('caress');
$pet3->snarl('gengs');

### INVOCANT->VERSION(NEED)
say Echelon->VERSION;
eval {
    say Echelon->VERSION(0.0.2);
};
print "ERROR : $@" if $@;

use Carp;
sub UNIVERSAL::talking {
    my $self = shift;
    if (ref $self) {
        say ref $self," : Hello gengs!!";
    }
    else {
#        confess "UNIVERSAL::talking can't talk class $self.";
        warn "UNIVERSAL::talking can't talk class $self.\n";
    }
}
$pet3->talking;
Echelon->talking;

$pet3->blarg('gs');

## 私有方法
$pet3->knock;

# 实例析构器
# 管理实例数据
say $pet3->name('changxingye');

## 用 use fields 声明的字段
use Person;
my $my_slave = Person->new;
say $my_slave->name('wangxues');

## 用 Class::Struct 生成类
use Woman;
my $my_beau = Woman->new;
$my_beau->name('xuejj');
say $my_beau->name;
say $my_beau->Woman::name;

## 用闭包生成存取器
use Person1;
my $pen1 = Person1->new;
$pen1->name('nacy');
say $pen1->name;

## 将闭包用于私有对象
use Person2;
my $pen2 = Person2->new;
$pen2->name('guoshuai');
say $pen2;
say $pen2->name;
say $pen2->(RACE => '1234');
#say $pen2->(sex => 'very');

## 新技巧
$pet3->virgin = 'MVM';
say $pet3->virgin;
Echelon->Master = 'gengs';
say $pet3->Master;
say $pet2->Master;