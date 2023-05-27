SELECT *
FROM sys.messages
WHERE message_id > 50000

EXECUTE sys.sp_addmessage
		@msgnum = 50001,
		@severity = 16,
		@msgtext = N'Unidentified Customer. Please add new customer before proceeding';


EXECUTE sys.sp_addmessage
		@msgnum = 50002,
		@severity = 16,
		@msgtext = N'Invalid Deposit. Fund must be bigger than 1 million VND';


EXECUTE sys.sp_addmessage
		@msgnum = 50003,
		@severity = 16,
		@msgtext = N'Invalid Interest Type. Please select another type';


EXECUTE sys.sp_addmessage
		@msgnum = 50004,
		@severity = 16,
		@msgtext = N'There is an interest type with that term. Please use update';


