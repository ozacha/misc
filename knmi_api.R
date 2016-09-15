require('data.table')
require('curl')

h <- new_handle()
url <- "http://projects.knmi.nl/klimatologie/uurgegevens/getdata_uur.cgi"
handle_setform(h, stns="260", vars="M:N:FF:DR", 
               byear="2013", bmonth="1", bday="1", 
               eyear=paste0(as.POSIXlt(Sys.time())$year + 1900), 
               emonth=paste0(as.POSIXlt(Sys.time())$mon + 1), 
               eday=paste0(as.POSIXlt(Sys.time())$mday))
tmp <- tempfile()
curl_download(url, handle=h, destfile=tmp)

dt <- fread(tmp, col.names = c("STN", "DAY", "HOUR", "M", "N", "FF", "DR"))
