#!perl -w

#using NULL value
use DBI;
use Test::More;
use vars qw($db $port $hostname); 

$db=$ARGV[0];
$port=$ARGV[2];
$hostname=$ARGV[1];
my $user="dba";
my $pass="";

my $dsn="dbi:cubrid:database=$db;host=$hostname;port=$port";
my $dbh;
$dbh=DBI->connect($dsn, $user, $pass,{RaiseError => 1}) or die "connect err: $dbh->errstr";
$dbh -> do("drop table if EXISTS employees;" );

$dbh -> do("create table employees(id int not null, name varchar(128),title varchar(128),phone char(8));") or die "create err $dbh->errstr";
$dbh->do("insert into employees values (1,'Larryma','Computer','5555-0101'),(2,'Times','Database','5555-0202'),(3,'Darling','Perl','5555-0303');") or die "insert error: $dbh->errstr";
my @names=("Larry%","Tim%","Randa%");
my $sql="delete from employees where name LIKE ?;";
my $sth=$dbh->prepare($sql) or die "error select: $dbh->errstr";

my $index=0;
my $length=$#names+1;
while($index < $length){
   ok($sth->bind_param(1,@names[$index++],{TYPE =>SQL_VARCHAR}),"bind_param ok");
   $sth->execute or die "err execute: $dbh->errstr";
}

ok($sth->finish(),"finish ok");

my $sth=$dbh->prepare("select * from employees ") or die $dbh->errstr ." prepare error\n";
$sth->execute or die  $dbh->errstr ."  delete error\n";
my $rows=$sth->rows;
is($rows,1,"rollback ok");
done_testing();

$sth->finish();
$dbh -> disconnect();
