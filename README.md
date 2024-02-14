# Data Analyst Portfolio Project - Sales Report

## Business Request & User Stories

The initiation of this data analyst project stemmed from a business request for an executive sales report catered to sales managers. To align with this request, specific user stories were crafted to guide project delivery and maintain adherence to acceptance criteria.

| #	| As a (role) |	I want (request/demand) |	So that I (user value) |	Acceptance Criteria |
| --- | --- | --- | --- | --- |
| 1 |	Sales Manager |	To get a dashboard overview of internet sales |	Can efficiently track the best-performing customers and products |	A Power BI dashboard that updates data daily |
| 2 |	Sales Representative |	A detailed overview of Internet Sales per Customers |	Can monitor top-buying customers and identify potential upsells |	A Power BI dashboard allowing data filtering for each customer |
| 3 |	Sales Representative |	A detailed overview of Internet Sales per Products |	Can track the best-selling products |	A Power BI dashboard allowing data filtering for each product |
| 4 |	Sales Manager |	A dashboard overview of internet sales |	Monitor sales against budget over time |	A Power BI dashboard with graphs and KPIs comparing with budget |

## Data Cleansing & Transformation (SQL)

To facilitate analysis and meet the business requirements outlined in the user stories, the necessary data model was constructed through SQL. Various tables were extracted, and an additional data source (sales budgets) in Excel format was later incorporated into the data model.

Below are the SQL statements for cleansing and transforming necessary data.

**DimCustomer:**
 ```
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
 ```
**DimDate:**
```
-- Cleansed DimDate Table --
SELECT
      [DateKey],
      [FullDateAlternateKey] AS Date,
      --[DayNumberOfWeek],
      [EnglishDayNameOfWeek] AS Day,
      --[SpanishDayNameOfWeek],
      --[FrenchDayNameOfWeek],
      --[DayNumberOfMonth],
      --[DayNumberOfYear],
      [WeekNumberOfYear] AS WeekNr,
      [EnglishMonthName] AS Month,
      LEFT([EnglishMonthName],3) AS MonthShort,
      --[SpanishMonthName],
      --[FrenchMonthName],
      [MonthNumberOfYear] AS MonthNr,
      [CalendarQuarter] AS Quarter,
      [CalendarYear] AS Year
      --[CalendarSemester],
      --[FiscalQuarter],
      --[FiscalYear],
      --[FiscalSemester]
FROM 
    [dbo].[DimDate]
WHERE 
    CalendarYear >= 2022
```
**DimProducts:**
```
SELECT 
    p.[ProductKey],
    p.[ProductAlternateKey] AS ProductItemCode,
    --[ProductSubcategoryKey],
    --[WeightUnitMeasureCode],
    --[SizeUnitMeasureCode],
    p.[EnglishProductName] AS [Product Name],
    ps.EnglishProductSubcategoryName AS [Sub Category],-- Joined in From Sub Category Table
    pc.EnglishProductCategoryName AS [Product Category], -- Joined in From Category Table
    --[SpanishProductName],
    --[FrenchProductName],
    --[StandardCost],
    --[FinishedGoodsFlag],
    p.[Color] AS [Product Color],
    --[SafetyStockLevel],
    --[ReorderPoint],
    --[ListPrice],
    p.[Size] AS [Product Size],
    --[SizeRange],
    --[Weight],
    --[DaysToManufacture],
    p.[ProductLine] AS [Product Line],
    --[DealerPrice],
    --[Class],
    --[Style],
    p.[ModelName] AS [Product Model Name],
    --[LargePhoto],
    p.[EnglishDescription] AS [Product Description],
    --[FrenchDescription],
    --[ChineseDescription],
    --[ArabicDescription],
    --[HebrewDescription],
    --[ThaiDescription],
    --[GermanDescription],
    --[JapaneseDescription],
    --[TurkishDescription],
    --[StartDate],
    --[EndDate],
    --[Status],
ISNULL(p.[Status], 'Outdated') AS [Product Status]
FROM 
    [dbo].[DimProduct] AS p
    LEFT JOIN [dbo].[DimProductSubcategory] AS ps on ps.ProductSubcategoryKey = p.ProductSubcategoryKey
    LEFT JOIN [dbo].[DimProductCategory] AS pc on ps.ProductCategoryKey = pc.ProductCategoryKey
ORDER BY
    p.ProductKey ASC
```
**FactInternetSales:**
```
SELECT 
    [ProductKey],
    [OrderDateKey],
    [DueDateKey],
    [ShipDateKey],
    [CustomerKey],
    --[PromotionKey]
    --[CurrencyKey]
    --[SalesTerritoryKey]
    --[SalesOrderNumber],
    --[SalesOrderLineNumber]
    --[RevisionNumber]
    --[OrderQuantity]
    --[UnitPrice]
    --[ExtendedAmount]
    --[UnitPriceDiscountPct]
    --[DiscountAmount]
    --[ProductStandardCost]
    --[TotalProductCost]
    [SalesAmount]
    --[TaxAmt]
    --[Freight]
    --[CarrierTrackingNumber]
    --[CustomerPONumber]
    --[OrderDate]
    --[DueDate]
    --[ShipDate]
FROM 
    [dbo].[FactInternetSales]
WHERE
    LEFT(OrderDateKey, 4) >= YEAR(GETDATE()) -2 -- Ensures we always only bring two years of date from extraction
ORDER BY 
    OrderDateKey ASC
```
## Data Model

The data model, displayed below, showcases the result of cleansing and preparing tables, which were subsequently imported into Power BI. The model also illustrates the connection between FACT_Budget and FACT_InternetSales, along with other essential DIM tables.

![Screenshot 2024-02-14 205929](https://github.com/AllanGachomo/Sales-Report/assets/156645085/d93b2356-a49d-4a53-843d-7a5811174b4c)

## Sales Management Dashboard

The finalized sales management dashboard features a primary page serving as both a dashboard and overview. Two additional pages focus on amalgamating tables to provide detailed insights and visualizations depicting sales over time, per customers, and per products.

![Screenshot 2024-02-14 205833](https://github.com/AllanGachomo/Sales-Report/assets/156645085/2e554470-aea8-4183-b39e-4ac3dd1e2ec2)


This project was achieved with the guidance of AnalyzewithAli's youtube videos.



