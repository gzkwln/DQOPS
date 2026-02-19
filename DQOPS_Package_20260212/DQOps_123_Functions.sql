USE [WRKDQOPS]
GO
/****** Object:  UserDefinedFunction [dbo].[GetFileName]    Script Date: 28.06.2024 12:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create FUNCTION [dbo].[GetFileName]
(
 @fullpath nvarchar(max),
 @delimiter nvarchar(100)
) RETURNS nvarchar(max)
AS
BEGIN

declare @split as table (
 id int identity(1,1),
 fragment nvarchar(max)
)
declare @filename nvarchar(max)
declare @xml xml

SET @xml =
 N'<root><r>' +
 REPLACE(@fullpath, @delimiter,'</r><r>') +
 '</r></root>'

INSERT INTO @split(fragment)
SELECT
 r.value('.','nvarchar(max)') as item
FROM @xml.nodes('//root/r') as records(r)

SELECT @filename = fragment
FROM @split
WHERE id = (SELECT MAX(id) FROM @split)

RETURN LTRIM(RTRIM(@filename))

END

GO
/****** Object:  UserDefinedFunction [dbo].[GetFirstLettersUntilNumberEnds]    Script Date: 28.06.2024 12:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetFirstLettersUntilNumberEnds] (@inputString VARCHAR(MAX))
RETURNS VARCHAR(MAX)
AS
BEGIN
    DECLARE @resultString VARCHAR(MAX)
    DECLARE @position INT
    DECLARE @len INT

    SET @position = PATINDEX('%[0-9]%', @inputString)

    IF @position > 0
    BEGIN
        SET @len = @position - 1
        WHILE @position <= LEN(@inputString) AND ISNUMERIC(SUBSTRING(@inputString, @position, 1)) = 1
        BEGIN
            SET @position = @position + 1
        END

        SET @resultString = LEFT(@inputString, @position - 1)
    END
    ELSE
    BEGIN
        SET @resultString = @inputString
    END

    RETURN @resultString
END
GO
/****** Object:  UserDefinedFunction [dbo].[GetFirstLettersUntilSecondUnderscore]    Script Date: 28.06.2024 12:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetFirstLettersUntilSecondUnderscore] (@inputString VARCHAR(MAX))
RETURNS VARCHAR(MAX)
AS
BEGIN
    DECLARE @firstUnderscorePosition INT
    DECLARE @secondUnderscorePosition INT
    DECLARE @resultString VARCHAR(MAX)

    SET @firstUnderscorePosition = CHARINDEX('_', @inputString)
    SET @secondUnderscorePosition = CHARINDEX('_', @inputString, @firstUnderscorePosition + 1)

    IF @firstUnderscorePosition > 0 AND @secondUnderscorePosition > @firstUnderscorePosition
    BEGIN
        SET @resultString = SUBSTRING(@inputString, 1, @secondUnderscorePosition - 1)
    END
    ELSE
    BEGIN
        SET @resultString = @inputString
    END

    RETURN @resultString
END
GO
/****** Object:  UserDefinedFunction [dbo].[GetNumber]    Script Date: 28.06.2024 12:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetNumber] (@inputString NVARCHAR(MAX))
RETURNS NVARCHAR(MAX)
AS
BEGIN
    DECLARE @outputString NVARCHAR(MAX) = ''
    DECLARE @index INT = 1
    DECLARE @length INT = LEN(@inputString)

    WHILE @index <= @length
    BEGIN
        DECLARE @currentChar NVARCHAR(1) = SUBSTRING(@inputString, @index, 1)
        IF @currentChar LIKE '[0-9]'
            SET @outputString = @outputString + @currentChar
        SET @index = @index + 1
    END

    RETURN @outputString
END;
GO
