library(stringi)

#inputs
n <- 1000
yr <- 17
proj <- 1

#Load database of used IDs
if(file.exists("output.RData")){
    load("output.RData")
    db_rdata <- rdata
}else{
    db_rdata <- NULL
}

'''remove?? no need to load because of rdata
if(file.exists("output.csv")){
    db_csv <- read.table("output.csv", header = FALSE)
}else{
    db_csv <- NULL
}
'''

system.time({
    x <- do.call(paste0, Map(stri_rand_strings, n, length=c(3, 2),
                        pattern = c('[0-9]', '[A-Z]')))    
})

rdata <- c(db_rdata,x)
system.time(rdata <- unique(rdata))

exit <- FALSE
i <- 1
while(!exit & i <= 10){
    if(length(rdata)<(length(db_rdata)+length(x))){
        print("fail")
        i <- i + 1
    }else{
        exit <- TRUE
    }
}
#Save variable to track used IDs
system.time(save(rdata, file = "output.RData"))
#system.time(x <- paste(proj,x,yr,sep = ""))
#system.time(write.table(x,"output.csv", row.names = FALSE, col.names = FALSE))






#file.remove("output.RData")