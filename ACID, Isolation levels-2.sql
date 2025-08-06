select * from BankAccounts

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

SET IMPLICIT_TRANSACTIONS on;


DBCC useroptions 

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

DBCC useroptions;


select Balance from BankAccounts where AccountId=1

select * from BankAccounts

commit;

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

DBCC useroptions;

update BankAccounts set balance=800000 where accountId=1

SELECT
    r.session_id,
    r.status,
    r.blocking_session_id,
    r.wait_type,
    r.wait_time,
    t.text AS [sql_text]
FROM sys.dm_exec_requests r
JOIN sys.dm_exec_sessions s ON r.session_id = s.session_id
CROSS APPLY sys.dm_exec_sql_text(r.sql_handle) t
WHERE r.blocking_session_id <> 0;

 SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
 DBCC useroptions;
