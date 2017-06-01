library(stringi)

n <- 50
yr <- 17
proj <- 1

system.time({
    x <- do.call(paste0, Map(stri_rand_strings, n, length=c(3, 2),
                        pattern = c('[0-9]', '[A-Z]')))    
})

system.time(x <- unique(x))
system.time(x <- paste(proj,x,yr,sep = ""))
write.table(x,"output.csv",row.names = FALSE,col.names = FALSE)