#!/usr/bin/perl

print "Status: 200 OK\n";
print "\n"; # End of headers

my $temp = "This is a test.";

$temp =~ s/test/awesome test/g;

print "This is a test.  $temp\n";

