-- Cleansed DimCustomer Table --
SELECT 
    c.CustomerKey AS CustomerKey,
    --[GeographyKey],
    --[CustomerAlternateKey],
    --[Title],
    c.firstname AS [First Name],
    --[MiddleName],
    c.lastname AS [Last Name],
    c.firstname +' '+ lastname AS [Full Name],
    --[NameStyle],
    --[BirthDate],
    --[MaritalStatus],
    --[Suffix],
CASE c.gender WHEN 'M' THEN 'Male' WHEN 'F' THEN 'Female' END AS Gender,
    --[EmailAddress],
    --[YearlyIncome],
    --[TotalChildren],
    --[NumberChildrenAtHome],
    --[EnglishEducation],
    --[SpanishEducation],
    --[FrenchEducation],
    --[EnglishOccupation],
    --[SpanishOccupation],
    --[FrenchOccupation],
    --[HouseOwnerFlag],
    --[NumberCarsOwned],
    --[AddressLine1],
    --[AddressLine2],
    --[Phone],
    [DateFirstPurchase],
    --[CommuteDistance],
    g.City AS [Customer City] --Joined in from Geography Table
  FROM 
    [dbo].[DimCustomer] AS c 
    LEFT JOIN DimGeography AS g ON g.GeographyKey = c.GeographyKey
ORDER BY
    CustomerKey ASC --Ordered List by CustomerKey