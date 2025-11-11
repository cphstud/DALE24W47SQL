library(DBI)
library(RMariaDB)
library(dplyr)
library(lubridate)


# forbindelse
con <- dbConnect(MariaDB(),
                 host="localhost",
                 db="dalnorthwind",
                 user="root",
                 password=Sys.getenv("localpw")
                 )


df=mtcars
dbWriteTable(con,"dftest",df)

queryst="select p.productname,od.orderid from products p
left join order_details od on od.productid=p.productid
and od.orderid in(
select od.orderid from order_details od, orders o
where od.orderid=o.orderid and 
o.orderdate between '1998-04-28' and '1998-05-01')"

res=dbGetQuery(con,queryst)

wrap=getUnsoldProducts('1998-03-01','1998-03-08')
wrap=getUnsoldProducts('1998-03-01','1998-03-08')


getUnsoldProducts <- function(fd,td) {
  fd='1998-04-28'
  td='1998-05-28'
  basequery="select p.productname,od.orderid from products p 
  left join order_details od on od.productid=p.productid and 
  od.orderid in ( 
  select od.orderid from order_details od, orders o 
  where od.orderid=o.orderid and o.orderdate between " 
  fullquery <- paste0(basequery,"'",fd,"' and '",td,"')")
  fullquery
  res=dbGetQuery(con,fullquery)
  return(res)
}
