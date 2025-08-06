--Autocommit off rejimində olsada DDL əməliyyatları zamanı mütləq commit və ya rollback etməliyik.
CREATE TABLE BankAccounts (
    AccountId INT PRIMARY KEY,
    AccountHolderName NVARCHAR(100),
    Balance DECIMAL(10, 2) CHECK (Balance >= 0)
);

INSERT INTO BankAccounts (AccountId, AccountHolderName, Balance)
VALUES 
(1, 'Toğrul İsmayılov', 1000.00),
(2, 'Leyla Məmmədova', 500.00);


--Təsdiq.
commit;

--Təsdiq etməmək.
rollback;

select * from BankAccounts

--DBCC(Database control commands)
DBCC useroptions;

--Isolation səviyyəsini ən zəif olan READ UNCOMMITTED-ə gətiririk.
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

--Autocommit off rejiminə keçir.
SET IMPLICIT_TRANSACTIONS on;

drop table BankAccounts;

--Isolation səviyyəsini READ COMMITTED-ə gətiririk.
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

DBCC useroptions;

--Non-repeatable risk

select Balance from BankAccounts where AccountId=1

update BankAccounts set Balance = 1000 where AccountId=1

commit;

rollback;

--Phantom read risk
INSERT INTO BankAccounts (AccountId, AccountHolderName, Balance)
VALUES 
(3, 'Aysel Rehimli', 700.00);

commit;

delete from BankAccounts
where AccountId=3;

commit;

--Isolation səviyyəsini Repeatable read-ə gətiririk.
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

DBCC useroptions;

update BankAccounts set balance = 1000 where AccountId=1


--Non-repeatale read risk check
select * from BankAccounts

update BankAccounts set balance = 100000 where AccountId=1


--Phantom read risk 
select * from BankAccounts

INSERT INTO BankAccounts (AccountId, AccountHolderName, Balance)
VALUES 
(3, 'Aysel Rehimli', 700.00);


--Isolation səviyyəsini Serializable-a gətiririk.
 SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

 DBCC useroptions;


--Dirty read risk check
select * from BankAccounts

update BankAccounts set Balance = 1000 where AccountId=1
 
INSERT INTO BankAccounts (AccountId, AccountHolderName, Balance)
VALUES 
(4, 'Hesen Rehimli', 700.00);