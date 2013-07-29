CREATE TABLE BankAccountLog (transactionid integer PRIMARY KEY AUTOINCREMENT,accountNumber text,amount double,description text,timestamp text);
INSERT INTO BankAccountLog ( transactionid,accountNumber,amount,description,timestamp ) VALUES ( '1','thanhld','50.0','','2012-01-01 12:12:12' );
INSERT INTO BankAccountLog ( transactionid,accountNumber,amount,description,timestamp ) VALUES ( '2','thanhld','50.0','','2012-01-01 12:12:13' );
INSERT INTO BankAccountLog ( transactionid,accountNumber,amount,description,timestamp ) VALUES ( '3','thanhld','50.0','','2012-01-01 12:12:14' );
INSERT INTO BankAccountLog ( transactionid,accountNumber,amount,description,timestamp ) VALUES ( '4','thanhld','50.0','','2012-01-01 12:12:15' );
INSERT INTO BankAccountLog ( transactionid,accountNumber,amount,description,timestamp ) VALUES ( '5','thanhld','50.0','','2012-01-01 12:12:16' );