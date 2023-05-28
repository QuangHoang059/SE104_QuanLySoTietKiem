
USE SAVINGS
GO

-- CREATE INTEREST_TYPES TABLE (LoaiTK)
-- Create InterestTypes table
CREATE TABLE InterestTypes( 
	InterestTypeID CHAR(10) NOT NULL,		-- Ma loai tiet kiem
	InterestRate DECIMAL(3,2) NOT NULL,		-- Lai suat (%)
	Term INT NOT NULL,						-- So thang trong ky han
	MinimumTimeToWithdrawal INT NOT NULL	-- Thoi gian toi thieu de duoc rut, mac dinh la 0
);  
-- Add primary key
ALTER TABLE InterestTypes ADD CONSTRAINT PK_InterestType PRIMARY KEY (InterestTypeID);

--sp_help InterestTypes


-- FEATURE: INCREMENT InterestTypeID AUTOMATICALLY
-- Create function increment InterestTypeID automatically
GO
CREATE FUNCTION dbo.fnAutoIncrementInterestTypeID ()
RETURNS CHAR(10)
AS
BEGIN
    DECLARE @InterestTypeID CHAR(10)
    SET @InterestTypeID = (SELECT TOP 1 'IT' + CAST(FORMAT(CAST(STUFF(InterestTypeID, 1, 2, '') AS INT) + 1, '00000000') AS CHAR(10))
					  FROM InterestTypes
					  ORDER BY InterestTypeID DESC)
    RETURN ISNULL(@InterestTypeID, 'IT00000001')
END
GO

-- Add default constraint to increment ID automatically
ALTER TABLE InterestTypes
ADD CONSTRAINT dfAutoIncrementInterestTypeIDPK
DEFAULT dbo.[fnAutoIncrementInterestTypeID]() FOR InterestTypeID
GO




-- STORED PROCEDURE: Add New Interest Type
GO
CREATE PROCEDURE dbo.addInterestType 
			@InterestRate DECIMAL(3,2), 
			@Term INT, 
			@MinimumTimeToWithdrawal INT = 0
AS
BEGIN
	IF (@Term NOT IN (SELECT Term FROM InterestTypes))
		BEGIN
			INSERT INTO InterestTypes(InterestRate, Term, MinimumTimeToWithdrawal)
	BEGIN TRY
		INSERT INTO InterestTypes(InterestRate, Term, MinimumTimeToWithdrawal)
END
GO



-- STORED PROCEDURE: UPDATE Interest Type
GO
CREATE PROCEDURE dbo.updateInterestType 
			@InterestTypeID CHAR(10), 
			@NewInterestRate DECIMAL(3,2) = NULL,
			@NewMinimumTimeToWithdrawal INT = NULL
AS
BEGIN
	IF (@InterestTypeID NOT IN (SELECT InterestTypeID FROM InterestTypes))
		BEGIN
			RETURN 1
		END
	IF (@NewMinimumTimeToWithdrawal IS NOT NULL)
		BEGIN
			UPDATE InterestTypes
			SET MinimumTimeToWithdrawal = @NewMinimumTimeToWithdrawal
			WHERE InterestTypeID = @InterestTypeID
		END
	IF (@NewInterestRate IS NOT NULL)
		BEGIN
			UPDATE InterestTypes
			SET InterestRate = @NewInterestRate
			WHERE InterestTypeID = @InterestTypeID
		END
END
GO




---- TESTING
--EXEC dbo.addInterestType 4.2, 4
--GO

--EXEC dbo.addInterestType 0.4, 0
--GO

--EXEC dbo.updateInterestType 'IT00000002', 0.6
--GO

--SELECT * FROM InterestTypes

--DROP PROCEDURE dbo.addInterestType, dbo.updateInterestType 



--ALTER TABLE InterestTypes
--drop constraint dfAutoIncrementPK;
------ drop the function
--drop function dbo.fnAutoIncrementInterestTypeID
--DROP TABLE InterestTypes
