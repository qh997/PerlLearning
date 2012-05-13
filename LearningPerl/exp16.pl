#!/usr/bin/env perl
# 第十六章 进程管理

use 5.010;

# system 函数
system "date";
system 'ls -l $HOME';
#system 'for i in *; do echo == $i ==; cat $i; echo; done';

system "date" and die "something went wrong.";

# exec 函数
if (0) {
    exec "date"; # 这时 Perl 已经完成使命了，之后的代码都不会被执行
    say "Hello, exec!";
}

# 用反引号捕获输出结果
chomp(my $now = `date`);
say "The time is now $now";

# 将进程视为文件句柄
open DATE, "date|" or die "cannot pipe from date: $!";
$now = <DATE>;
say "Pipe : $now";
close DATE;

=del # 等待时间太长了，暂时注掉
open F, "find /home/gengs/ -atime +10 -size +1000 -print|" or die "fork: $!";
while (<F>) {
    chomp;
    printf "%s size %dk last accessed on %s\n",
        $_, (1023+ -s $_)/1024, -A _;
}
close F;
=cut

# 用 fork 开展地下工作
defined(my $pid = fork) or die "Cannot fork: $!";
unless ($pid) {
    exec "date";
    die "cannot exec date: $!";
}
waitpid($pid, 0);

# 发送及接受信号
sub my_int_handler {
    say "\nHey! I recived Ctrl + C.";
    die "interrupted, exiting...\n";
}
my $int_count;
sub my_int_handler_wait {
    say "\nHey! I recived Ctrl + C.";
    $int_count++;
}

$SIG{'INT'} = 'my_int_handler_wait';
say "Now I will sleep...";
while (1) {
    say "Sleeping...";
    sleep 5;
    say "Wake up!";
    if ($int_count) {
        die "interrupted, exiting...\n";
    }
}