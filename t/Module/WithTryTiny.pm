package t::Module::WithTryTiny;

# ABSTRACT: This module does nothing 

use Try::Tiny;

sub test {
    try { say "hello" } catch { say "Fehler" };
}

1;
