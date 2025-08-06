**ACID Prinsipləri — Nədir və Niyə Vacibdir?**

ACID prinsipləri SQL Server (və digər RDBMS-lər) üçün etibarlı və təhlükəsiz tranzaksiya idarəetməsinin əsasını təşkil edir:



Prinsip	İzah

Atomicity	Tranzaksiya ya tamamilə yerinə yetirilməlidir, ya da heç biri edilməməlidir.

Consistency	Tranzaksiya başlamazdan əvvəl və sonra verilənlər bazası etibarlı vəziyyətdə qalmalıdır.

Isolation	Paralel tranzaksiyalar bir-birinin nəticələrinə təsir etməməlidir.

Durability	Commit edilmiş tranzaksiya server çökdükdən sonra belə itməməlidir.





**Isolation Levels – Paralel Tranzaksiyaların İdarəsi**

SQL Server-də 4 əsas səviyyə var:



     Level			 	İzah

Read Uncommitted	  Dirty Read-ə icazə verir. Ən zəif səviyyə.

Read Committed		  Default səviyyə. Dirty read-ləri bloklayır.

Repeatable Read		  Oxunan satırların dəyişməsini bloklayır.

Serializable		  Ən sərt səviyyə. Yeni satır əlavə olunmasını da bloklayır.



**Blocking və Deadlock**

🔸 Blocking nədir?

Bir sessiya müəyyən resurs üzərində dəyişiklik etdiyi halda, digər sessiya bu resursa çıxış etməyə çalışırsa, blok yaranır.



Bloklanmış sessiyaları tapmaq üçün istifadə etdiyin sorğu:



sql

Copy

Edit

SELECT

    r.session\_id,

    r.status,

    r.blocking\_session\_id,

    r.wait\_type,

    r.wait\_time,

    t.text AS sql\_text

FROM sys.dm\_exec\_requests r

JOIN sys.dm\_exec\_sessions s ON r.session\_id = s.session\_id

CROSS APPLY sys.dm\_exec\_sql\_text(r.sql\_handle) t

WHERE r.blocking\_session\_id <> 0;

