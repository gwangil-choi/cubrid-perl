#!/usr/bin/perl

use DBI ();
use Test::More;
use lib 't', '.';
require 'lib.pl';
use vars qw($table $test_dsn $test_user $test_passwd);

my $dbh;
eval {$dbh= DBI->connect($test_dsn, $test_user, $test_passwd,
                      { RaiseError => 1, PrintError => 1, AutoCommit => 0 });};
$dbh -> do("drop table if EXISTS image_t;") or die "drop error: $dbh->errstr";
$dbh->do("CREATE TABLE image_t (image_id VARCHAR(36) PRIMARY KEY, doc_id VARCHAR(64) NOT NULL, image BLOB);") or die "create error:  $dbh->errstr";
$dbh->do("INSERT INTO image_t VALUES ('image-0', 'doc-0', BIT_TO_BLOB(X'000001'));") or die "insert error: $dbh->errstr";
$dbh->do("INSERT INTO image_t VALUES ('image-1', 'doc-1', BIT_TO_BLOB(X'000010'));") or die "insert error: $dbh->errstr";
$dbh->do("INSERT INTO image_t VALUES ('image-2', 'doc-2', BIT_TO_BLOB(X'000100'));") or die "insert error: $dbh->errstr";



my $curpath=`pwd`;
chomp $curpath;
my $curpath1="export_3.txt";
print $curpath1;
my $curpath2="export_3.txt";
print $curpath2;


my $sth=$dbh->prepare(" select image from image_t;  ") or die "prepare error: $dbh->errstr";
$sth->execute() or die "execute error: $dbh->errstr";

$sth->cubrid_lob_get (1) or warn "cubrid_lob_get error: $DBI::errstr\n";
print $DBI::errstr."####\n";
$sth->cubrid_lob_export(1,"export1B.txt") or die "cubrid_lob_export error: $dbh->errstr";
$sth->cubrid_lob_export(2,$curpath1) or die "cubrid_lob_export error: $dbh->errstr";
$sth->cubrid_lob_export(3,$curpath2) or die "cubrid_lob_export error: $dbh->errstr";
$sth->cubrid_lob_close();


$sth->finish();
$dbh -> disconnect();


