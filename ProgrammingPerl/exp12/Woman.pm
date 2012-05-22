package Woman;

use strict;
use warnings;
use 5.010;
use Class::Struct;

struct Woman => {
    name => '$',
    breast => '$',
    rooms => '@',
};

1;