
--- Customer Purchase Pattern in Specific countries
Select
	concat(C.firstname,' ', C.lastname) CustomerNames,
	Country,
	Sum(i.Total)  TotalSpent
From 
	Customer C
	Join Invoice i on C.Customerid = i.Customerid
where 
	Country in ('Germany', 'USA', 'Belgium','India')
group by 
	concat(C.firstname,' ', C.lastname),Country


--- Artist revenue in specific months
Select
		A.Name ArtistNames,
		Al.Title AlbumTitle,
		datename(Month, I.Invoicedate) MonthName,
		Il.Quantity OrderQTY,
		Sum(Il.quantity * Il.Unitprice)  Revenue
	From 
		Artist A
	Join 
		Album Al on A.ArtistId = Al.ArtistId
	Join 
		Track T on Al.AlbumId = T.AlbumId
	Join 
		InvoiceLine Il on T.TrackId = Il.TrackId
	Join 
		Invoice I on I.invoiceid = Il.InvoiceId
	Where 
		datename(Month, I.Invoicedate) in ('April','June','Sptember','December')
	Group by 
		A.Name, 
		Al.Title,
		datename(Month, I.Invoicedate),
		Il.Quantity
	Order by 
		Revenue Desc


--- Categorising Order Quantity by Case
Select
	concat(C.firstname,' ', C.lastname) CustomerNames,
	Sum(Il.Quantity) OrderQTY,
Case
	When Sum(Il.Quantity) > 75 then 'High'
	When Sum(Il.Quantity) > 35 then 'Mid'
	else 'Low'
End as BinCategory
from 
	Customer C
Join 
	Invoice i on C.Customerid = i.Customerid
Join 
	Invoiceline il on i.invoiceid = il.InvoiceId
Group by 
	concat(C.firstname,' ', C.lastname), Il.Quantity


--- Specific Countries Revenue
Select
	Country, 
	datename(Weekday, invoicedate) Day_Of_Week,
	Sum(Il.Quantity) OrderQTY,
	Sum(Il.quantity * Il.Unitprice)  Revenue
From 
	Customer C
Join 
	Invoice I on C.Customerid = I.Customerid
Join
	Invoiceline IL on I.invoiceid = Il.InvoiceId
Where 
	Country in ('Sweden','USA','Italy') and datename(Weekday, invoicedate) in ('Friday','Saturday','Sunday')
Group by 
	Country,datename(Weekday, invoicedate)
Order by Revenue
