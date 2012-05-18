#!/usr/bin/env perl
# 第七章 格式

use 5.010;

format STDOUT =
@<<<<<<<<<<<<<<<<<<<<  @||||||||||||||||||||   @>>>>>>>>>>>>>>>>>>>>
"left", "middle", "right"
.

write;