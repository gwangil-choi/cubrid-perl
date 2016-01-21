package DBD::cubrid::GetInfo;
########################################
#  DBD::cubrid::GetInfo
#

use strict;
use DBD::cubrid;
# Beware: not officially documented interfaces...
# use DBI::Const::GetInfoType qw(%GetInfoType);
# use DBI::Const::GetInfoReturn qw(%GetInfoReturnTypes %GetInfoReturnValues);

my $sql_driver = 'cubrid';

my @Keywords = qw(
    ABSOLUTE ACTION ADD ADD_MONTHS AFTER ALIAS ALL ALLOCATE ALTER AND ANY ARE
    AS ASC ASSERTION ASYNC AT ATTACH ATTRIBUTE AVG
    BEFORE BETWEEN BIGINT BIT BIT_LENGTH BLOB BOOLEAN BOTH BREADTH BY
    CALL CASCADE CASCADED CASE CAST CATALOG CHANGE CHAR CHARACTER CHECK CLASS
    CLASSES CLOB CLOSE CLUSTER COALESCE COLLATE COLLATION COLUMN COMMIT
    COMPLETION CONNECT CONNECT_BY_ISCYCLE CONNECT_BY_ISLEAF CONNECTION_BY_ROOT
    CONNECTION CONSTRAINT CONSTRAINTS CONTINUE CONVERT CORRESPONDING COUNT
    CREATE CROSS CURRENT CURRENT_DATE CURRENT_DATETIME CURRENT_TIME
    CURRENT_TIMESTAMP CURRENT_USER CURSOR CYCLE 
    DATA DATA_TYPE DATABASE DATE DATETIME DAY DAY_HOUR DAY_MILLISECOND
    DAY_MINUTE DAY_SECOND DEALLOCATE DEC DECIMAL DECLARE DEFAULT DEFERRABLE
    DEFERRED DELETE DEPTH DESC DESCRIBE DESCRIPTOR DIAGNOSTICS DICTIONARY
    DIFFERENCE DISCONNECT DISTINCT DISTINCTROW DIV DO DOMAIN DOUBLE DUPLICATE
    DROP
    EACH ELSE ELSEIF END EQUALS ESCAPE EVALUATE EXCEPT EXCEPTION EXCLUDE EXEC
    EXECUTE EXISTS EXTERNAL EXTRACT FALSE FETCH FILE FIRST FLOAT FOR FOREIGN
    FOUND FROM FULL FUNCTION
    GENERAL GET GLOBAL GO GOTO GRANT GROUP
    HAVING HOUR HOUR_MILLISECOND HOUR_MINUTE HOUR_SECOND IDENTITY IF IGNORE
    IMMEDIATE IN INDEX INDICATOR INHERIT INITIALLY INNER INOUT INPUT INSERT
    INT INTEGER INTERSECT INTERSECTION INTERVAL INTO IS ISOLATION
    JOIN
    KEY
    LANGUAGE LAST LDB LEADING LEAVE LEFT LESS LEVEL LIKE LIMIT LIST LOCAL
    LOCAL_TRANSACTION_ID LOCALTIME LOCALTIMESTAMP LOOP LOWER
    MATCH MAX METHOD MILLISECOND MIN MINUTE MINUTE_MILLISECOND MINUTE_SECOND
    MOD MODIFY MODULE MONETARY MONTH MULTISET MULTISET_OF
    NA NAMES NATIONAL NATURAL NCHAR NEXT NO NONE NOT NULL NULLIF NUMERIC
    OBJECT OCTET_LENGTH OF OFF OID ON ONLY OPEN OPERATION OPERATORS
    OPTIMIZATION OPTION OR ORDER OTHERS OUT OUTER OUTPUT OVERLAPS
    PARAMETERS PARTIAL PENDANT POSITION PRECISION PREORDER PREPARE PRESERVE
    PRIMARY PRIOR PRIVATE PRIVILEGES PROCEDURE PROTECTED PROXY
    QUERY
    READ REAL RECURSIVE REF REFERENCES REFERENCING REGISTER RELATIVE RENAME
    REPLACE RESIGNAL RESTRICT RETURN RETURNS REVOKE RIGHT ROLE ROLLBACK
    ROWNUM ROWS
    SAVEPOINT SCHEMA SCOPE SCROLL SEARCH SECOND SECOND_MILLISECOND SECTION
    SELECT SENSITIVE SEQUENCE SEQUENCE_OF SERIALIZABLE SESSION SESSION_USER
    SET SET_OF SETEQ SHARED SIBLINGS SIGNAL SIMILAR SIZE SMALLINT SOME SQL
    SQLCODE SQLERROR SQLEXCEPTION SQLSTATE SQLWARNING STATISTICS STRING
    STRUCTURE SUBCLASS SUBSET SUBSETEQ SUBSTRING SUM SUPERCLASS SUPERSET
    SUPERSETEQ SYS_CONNECT_BY_PATH SYS_DATE SYS_DATETIME SYS_TIME 
    SYS_TIMESTAMP SYS_USER SYSDATE SYSDATETIME SYSTEM_USER SYSTIME
    TABLE TEMPORARY TEST THEN THERE TIME TIMESTAMP TIMEZONE_HOUR 
    TIMEZONE_MINUTE TO TRAILING TRANSACTION TRANSLATE TRANSLATION TRIGGER
    TRIM TRUE TRUNCATE TYPE
    UNDER UNION UNIQUE UNKNOWN UPDATE UPPER USAGE USE USER USING UTIME
    VALUE VALUES VARCHAR VARIABLE VARYING VCLASS VIEW VIRTUAL VISIBLE
    WAIT WHEN WHENEVER WHERE WHILE WITH WITHOUT WORK WRITE
    XOR
    YEAR YEAR_MONTH
    ZONE
);


sub sql_keywords {
    return join ',', @Keywords;
}

sub sql_data_source_name {
    my $dbh = shift;
    return "dbi:$sql_driver:" . $dbh->{Name};
}

sub sql_user_name {
    my $dbh = shift;
    # Non-standard attribute
    return $dbh->{CURRENT_USER};
}


####################
# makefunc()
# returns a ref to a sub that that calls into  XS to get 
# values for info types that must needs be coded in C

our %info = (
     20 => 'N',                           # SQL_ACCESSIBLE_PROCEDURES
     19 => 'Y',                           # SQL_ACCESSIBLE_TABLES
      0 => 0,                             # SQL_ACTIVE_CONNECTIONS
    116 => 0,                             # SQL_ACTIVE_ENVIRONMENTS
      1 => 0,                             # SQL_ACTIVE_STATEMENTS
    169 => 127,                           # SQL_AGGREGATE_FUNCTIONS
    117 => 0,                             # SQL_ALTER_DOMAIN
     86 => 3,                             # SQL_ALTER_TABLE
  10021 => 2,                             # SQL_ASYNC_MODE
    120 => 2,                             # SQL_BATCH_ROW_COUNT
    121 => 2,                             # SQL_BATCH_SUPPORT
     82 => 0,                             # SQL_BOOKMARK_PERSISTENCE
    114 => 1,                             # SQL_CATALOG_LOCATION
  10003 => 'Y',                           # SQL_CATALOG_NAME
     41 => '@',                           # SQL_CATALOG_NAME_SEPARATOR
     42 => 'Database Link',               # SQL_CATALOG_TERM
     92 => 29,                            # SQL_CATALOG_USAGE
  10004 => '',                            # SQL_COLLATING_SEQUENCE
  10004 => '',                            # SQL_COLLATION_SEQ
     87 => 'Y',                           # SQL_COLUMN_ALIAS
     22 => 0,                             # SQL_CONCAT_NULL_BEHAVIOR
     53 => 259071,                        # SQL_CONVERT_BIGINT
     54 => 0,                             # SQL_CONVERT_BINARY
     55 => 259071,                        # SQL_CONVERT_BIT
     56 => 259071,                        # SQL_CONVERT_CHAR
     57 => 259071,                        # SQL_CONVERT_DATE
     58 => 259071,                        # SQL_CONVERT_DECIMAL
     59 => 259071,                        # SQL_CONVERT_DOUBLE
     60 => 259071,                        # SQL_CONVERT_FLOAT
     48 => 0,                             # SQL_CONVERT_FUNCTIONS
    173 => 0,                             # SQL_CONVERT_GUID
     61 => 259071,                        # SQL_CONVERT_INTEGER
    123 => 0,                             # SQL_CONVERT_INTERVAL_DAY_TIME
    124 => 0,                             # SQL_CONVERT_INTERVAL_YEAR_MONTH
     71 => 0,                             # SQL_CONVERT_LONGVARBINARY
     62 => 259071,                        # SQL_CONVERT_LONGVARCHAR
     63 => 259071,                        # SQL_CONVERT_NUMERIC
     64 => 259071,                        # SQL_CONVERT_REAL
     65 => 259071,                        # SQL_CONVERT_SMALLINT
     66 => 259071,                        # SQL_CONVERT_TIME
     67 => 259071,                        # SQL_CONVERT_TIMESTAMP
     68 => 259071,                        # SQL_CONVERT_TINYINT
     69 => 0,                             # SQL_CONVERT_VARBINARY
     70 => 259071,                        # SQL_CONVERT_VARCHAR
    122 => 0,                             # SQL_CONVERT_WCHAR
    125 => 0,                             # SQL_CONVERT_WLONGVARCHAR
    126 => 0,                             # SQL_CONVERT_WVARCHAR
     74 => 1,                             # SQL_CORRELATION_NAME
    127 => 0,                             # SQL_CREATE_ASSERTION
    128 => 0,                             # SQL_CREATE_CHARACTER_SET
    129 => 0,                             # SQL_CREATE_COLLATION
    130 => 0,                             # SQL_CREATE_DOMAIN
    131 => 0,                             # SQL_CREATE_SCHEMA
    132 => 1045,                          # SQL_CREATE_TABLE
    133 => 0,                             # SQL_CREATE_TRANSLATION
    134 => 0,                             # SQL_CREATE_VIEW
     23 => 2,                             # SQL_CURSOR_COMMIT_BEHAVIOR
     24 => 2,                             # SQL_CURSOR_ROLLBACK_BEHAVIOR
  10001 => 0,                             # SQL_CURSOR_SENSITIVITY
      2 => \&sql_data_source_name,        # SQL_DATA_SOURCE_NAME
     25 => 'N',                           # SQL_DATA_SOURCE_READ_ONLY
    119 => 7,                             # SQL_DATETIME_LITERALS
     17 => 'CUBRID',                      # SQL_DBMS_NAME
     18 => $DBD::cubrid::VERSION,       # SQL_DBMS_VER
    170 => 3,                             # SQL_DDL_INDEX
     26 => 2,                             # SQL_DEFAULT_TRANSACTION_ISOLATION
     26 => 2,                             # SQL_DEFAULT_TXN_ISOLATION
  10002 => 'N',                           # SQL_DESCRIBE_PARAMETER
#   171 => undef,                         # SQL_DM_VER
      3 => 137076632,                     # SQL_DRIVER_HDBC
#   135 => undef,                         # SQL_DRIVER_HDESC
      4 => 137076088,                     # SQL_DRIVER_HENV
#    76 => undef,                         # SQL_DRIVER_HLIB
#     5 => undef,                         # SQL_DRIVER_HSTMT
      6 => 'libmyodbc3.so',               # SQL_DRIVER_NAME
     77 => '03.51',                       # SQL_DRIVER_ODBC_VER
      7 => $DBD::cubrid::VERSION,         # SQL_DRIVER_VER
    136 => 0,                             # SQL_DROP_ASSERTION
    137 => 0,                             # SQL_DROP_CHARACTER_SET
    138 => 0,                             # SQL_DROP_COLLATION
    139 => 0,                             # SQL_DROP_DOMAIN
    140 => 0,                             # SQL_DROP_SCHEMA
    141 => 7,                             # SQL_DROP_TABLE
    142 => 0,                             # SQL_DROP_TRANSLATION
    143 => 0,                             # SQL_DROP_VIEW
    144 => 0,                             # SQL_DYNAMIC_CURSOR_ATTRIBUTES1
    145 => 0,                             # SQL_DYNAMIC_CURSOR_ATTRIBUTES2
     27 => 'Y',                           # SQL_EXPRESSIONS_IN_ORDERBY
      8 => 63,                            # SQL_FETCH_DIRECTION
     84 => 0,                             # SQL_FILE_USAGE
    146 => 97863,                         # SQL_FORWARD_ONLY_CURSOR_ATTRIBUTES1
    147 => 6016,                          # SQL_FORWARD_ONLY_CURSOR_ATTRIBUTES2
     81 => 11,                            # SQL_GETDATA_EXTENSIONS
     88 => 3,                             # SQL_GROUP_BY
     28 => 4,                             # SQL_IDENTIFIER_CASE
     29 => '"',                           # SQL_IDENTIFIER_QUOTE_CHAR
    148 => 0,                             # SQL_INDEX_KEYWORDS
    149 => 0,                             # SQL_INFO_SCHEMA_VIEWS
    172 => 7,                             # SQL_INSERT_STATEMENT
     73 => 'N',                           # SQL_INTEGRITY
    150 => 0,                             # SQL_KEYSET_CURSOR_ATTRIBUTES1
    151 => 0,                             # SQL_KEYSET_CURSOR_ATTRIBUTES2
     89 => \&sql_keywords,                # SQL_KEYWORDS
    113 => 'Y',                           # SQL_LIKE_ESCAPE_CLAUSE
     78 => 0,                             # SQL_LOCK_TYPES
     34 => 64,                            # SQL_MAXIMUM_CATALOG_NAME_LENGTH
     97 => 0,                             # SQL_MAXIMUM_COLUMNS_IN_GROUP_BY
     98 => 32,                            # SQL_MAXIMUM_COLUMNS_IN_INDEX
     99 => 0,                             # SQL_MAXIMUM_COLUMNS_IN_ORDER_BY
    100 => 0,                             # SQL_MAXIMUM_COLUMNS_IN_SELECT
    101 => 0,                             # SQL_MAXIMUM_COLUMNS_IN_TABLE
     30 => 64,                            # SQL_MAXIMUM_COLUMN_NAME_LENGTH
      1 => 0,                             # SQL_MAXIMUM_CONCURRENT_ACTIVITIES
     31 => 18,                            # SQL_MAXIMUM_CURSOR_NAME_LENGTH
      0 => 0,                             # SQL_MAXIMUM_DRIVER_CONNECTIONS
  10005 => 64,                            # SQL_MAXIMUM_IDENTIFIER_LENGTH
    102 => 500,                           # SQL_MAXIMUM_INDEX_SIZE
    104 => 0,                             # SQL_MAXIMUM_ROW_SIZE
     32 => 0,                             # SQL_MAXIMUM_SCHEMA_NAME_LENGTH
    105 => 0,                             # SQL_MAXIMUM_STATEMENT_LENGTH
    106 => 0,                             # SQL_MAXIMUM_TABLES_IN_SELECT
     35 => 64,                            # SQL_MAXIMUM_TABLE_NAME_LENGTH
    107 => 16,                            # SQL_MAXIMUM_USER_NAME_LENGTH
  10022 => 0,                             # SQL_MAX_ASYNC_CONCURRENT_STATEMENTS
    112 => 0,                             # SQL_MAX_BINARY_LITERAL_LEN
     34 => 64,                            # SQL_MAX_CATALOG_NAME_LEN
    108 => 0,                             # SQL_MAX_CHAR_LITERAL_LEN
     97 => 0,                             # SQL_MAX_COLUMNS_IN_GROUP_BY
     98 => 32,                            # SQL_MAX_COLUMNS_IN_INDEX
     99 => 0,                             # SQL_MAX_COLUMNS_IN_ORDER_BY
    100 => 0,                             # SQL_MAX_COLUMNS_IN_SELECT
    101 => 0,                             # SQL_MAX_COLUMNS_IN_TABLE
     30 => 64,                            # SQL_MAX_COLUMN_NAME_LEN
      1 => 0,                             # SQL_MAX_CONCURRENT_ACTIVITIES
     31 => 18,                            # SQL_MAX_CURSOR_NAME_LEN
      0 => 0,                             # SQL_MAX_DRIVER_CONNECTIONS
  10005 => 64,                            # SQL_MAX_IDENTIFIER_LEN
    102 => 500,                           # SQL_MAX_INDEX_SIZE
     32 => 0,                             # SQL_MAX_OWNER_NAME_LEN
     33 => 0,                             # SQL_MAX_PROCEDURE_NAME_LEN
     34 => 64,                            # SQL_MAX_QUALIFIER_NAME_LEN
    104 => 0,                             # SQL_MAX_ROW_SIZE
    103 => 'Y',                           # SQL_MAX_ROW_SIZE_INCLUDES_LONG
     32 => 0,                             # SQL_MAX_SCHEMA_NAME_LEN
    105 => 8192,                          # SQL_MAX_STATEMENT_LEN
    106 => 31,                            # SQL_MAX_TABLES_IN_SELECT
     35 => 128,                           # SQL_MAX_TABLE_NAME_LEN
    107 => 16,                            # SQL_MAX_USER_NAME_LEN
     37 => 'Y',                           # SQL_MULTIPLE_ACTIVE_TXN
     36 => 'Y',                           # SQL_MULT_RESULT_SETS
    111 => 'N',                           # SQL_NEED_LONG_DATA_LEN
     75 => 1,                             # SQL_NON_NULLABLE_COLUMNS
     85 => 2,                             # SQL_NULL_COLLATION
     49 => 16777215,                      # SQL_NUMERIC_FUNCTIONS
      9 => 1,                             # SQL_ODBC_API_CONFORMANCE
    152 => 2,                             # SQL_ODBC_INTERFACE_CONFORMANCE
     12 => 1,                             # SQL_ODBC_SAG_CLI_CONFORMANCE
     15 => 1,                             # SQL_ODBC_SQL_CONFORMANCE
     73 => 'N',                           # SQL_ODBC_SQL_OPT_IEF
     10 => '03.80',                       # SQL_ODBC_VER
    115 => 123,                           # SQL_OJ_CAPABILITIES
     90 => 'Y',                           # SQL_ORDER_BY_COLUMNS_IN_SELECT
     38 => 'Y',                           # SQL_OUTER_JOINS
    115 => 123,                           # SQL_OUTER_JOIN_CAPABILITIES
     39 => '',                            # SQL_OWNER_TERM
     91 => 0,                             # SQL_OWNER_USAGE
    153 => 2,                             # SQL_PARAM_ARRAY_ROW_COUNTS
    154 => 3,                             # SQL_PARAM_ARRAY_SELECTS
     80 => 3,                             # SQL_POSITIONED_STATEMENTS
     79 => 31,                            # SQL_POS_OPERATIONS
     21 => 'N',                           # SQL_PROCEDURES
     40 => '',                            # SQL_PROCEDURE_TERM
    114 => 1,                             # SQL_QUALIFIER_LOCATION
     41 => '.',                           # SQL_QUALIFIER_NAME_SEPARATOR
     42 => 'database',                    # SQL_QUALIFIER_TERM
     92 => 29,                            # SQL_QUALIFIER_USAGE
     93 => 3,                             # SQL_QUOTED_IDENTIFIER_CASE
     11 => 'N',                           # SQL_ROW_UPDATES
     39 => '',                            # SQL_SCHEMA_TERM
     91 => 0,                             # SQL_SCHEMA_USAGE
     43 => 7,                             # SQL_SCROLL_CONCURRENCY
     44 => 17,                            # SQL_SCROLL_OPTIONS
     14 => '\\',                          # SQL_SEARCH_PATTERN_ESCAPE
     13 => sub {"$_[0]->{Name}"},         # SQL_SERVER_NAME
     94 => '',                            # SQL_SPECIAL_CHARACTERS
    155 => 7,                             # SQL_SQL92_DATETIME_FUNCTIONS
    156 => 0,                             # SQL_SQL92_FOREIGN_KEY_DELETE_RULE
    157 => 0,                             # SQL_SQL92_FOREIGN_KEY_UPDATE_RULE
    158 => 8160,                          # SQL_SQL92_GRANT
    159 => 0,                             # SQL_SQL92_NUMERIC_VALUE_FUNCTIONS
    160 => 0,                             # SQL_SQL92_PREDICATES
    161 => 466,                           # SQL_SQL92_RELATIONAL_JOIN_OPERATORS
    162 => 32640,                         # SQL_SQL92_REVOKE
    163 => 7,                             # SQL_SQL92_ROW_VALUE_CONSTRUCTOR
    164 => 255,                           # SQL_SQL92_STRING_FUNCTIONS
    165 => 0,                             # SQL_SQL92_VALUE_EXPRESSIONS
    118 => 4,                             # SQL_SQL_CONFORMANCE
    166 => 2,                             # SQL_STANDARD_CLI_CONFORMANCE
    167 => 97863,                         # SQL_STATIC_CURSOR_ATTRIBUTES1
    168 => 6016,                          # SQL_STATIC_CURSOR_ATTRIBUTES2
     83 => 7,                             # SQL_STATIC_SENSITIVITY
     50 => 491519,                        # SQL_STRING_FUNCTIONS
     95 => 0,                             # SQL_SUBQUERIES
     51 => 7,                             # SQL_SYSTEM_FUNCTIONS
     45 => 'table',                       # SQL_TABLE_TERM
    109 => 0,                             # SQL_TIMEDATE_ADD_INTERVALS
    110 => 0,                             # SQL_TIMEDATE_DIFF_INTERVALS
     52 => 106495,                        # SQL_TIMEDATE_FUNCTIONS
     46 => 3,                             # SQL_TRANSACTION_CAPABLE
     72 => 15,                            # SQL_TRANSACTION_ISOLATION_OPTION
     46 => 3,                             # SQL_TXN_CAPABLE
     72 => 15,                            # SQL_TXN_ISOLATION_OPTION
     96 => 0,                             # SQL_UNION
     96 => 0,                             # SQL_UNION_STATEMENT
     47 => \&sql_user_name,               # SQL_USER_NAME
  10000 => 1992,                          # SQL_XOPEN_CLI_YEAR
);

1;

__END__