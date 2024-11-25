library(DBI)
library(RMariaDB)
library(dplyr)
library(lubridate)

# forbindelse
con <- dbConnect(MariaDB(),
                 host="localhost",
                 db="trytrynorthwind",
                 user="root",
                 password='OttoRehagel123'
)


wbquery='select concat(e.firstname, " ",e.lastname) as "fullname", sum(od.quantity) as "sq" from employees e
join orders o on e.employeeid=o.employeeid
join order_details od on o.orderid=od.orderid
where o.orderdate between "1998-04-01" and "1998-05-01"
group by e.firstname,e.lastname
order by 2 desc
limit 3;'

# lav en basequery
# lav en funktion med fd and td som variabler
# i funktionen kombineres basequery og fd og td til en totalquery

getEmStat <- function(fd,td) {
  print("Hej Kurt")
}

reswb=dbGetQuery(con,wbquery)
