library(tea)
readSpec("incomes.spec")
doInput()

# Dirty up the data by blanking out 30% of incomes
try(dbGetQuery(teaenv$con, "drop table precut"))
dbGetQuery(teaenv$con, "create table precut as select * from dc")
table_len <-dbGetQuery(teaenv$con, "select count(*) from dc")[[1]]
rowids <- floor(runif(table_len*.30)*table_len)

lapply(rowids, function(row){
       dbGetQuery(teaenv$con, paste("update viewdc set pincp=NULL where rowid=", row))
})


doMImpute()



getOne <-function(method, fillins){
    filledtab <- paste(fillins, "fill", sep="")
    checkOutImpute(teaenv$active_tab, filledtab, filltab=fillins,
                       subset="agep+0>15")
    outframe <-teaTable(filledtab, cols="PINCP")
    outframe$PINCP <- log10(outframe$PINCP+10)
    outframe$imp <- paste("via", method)
    return(outframe)
}

plotWage <- function(outname){
    dfhd <- getOne("hot deck", "hd")
    dfnorm <- getOne("Gaussian", "norm")

    dfdc <-teaTable("precut", cols="PINCP", where="PINCP is not null")
    dfdc$PINCP <- log10(dfdc$PINCP+10) #+ runif(length(dfdc$PINCP))
    dfdc$imp <- "original"

    DFall <-rbind(dfdc, dfhd, dfnorm)

    #plot DFall, using imp# as color
    library(ggplot2)
    p <- ggplot(DFall,aes(x=PINCP,color=as.factor(imp)))
    p <- p + geom_density()
    p <- p + theme(axis.text.x=element_text(angle=45,hjust=1,vjust=1))
    bitmap(file=paste(outname,".png", sep=""),width=11*(10/11),height=8.5*(10/11),units="in",res=150)
    print(p)
    dev.off()
}

plotWage("log_wageplots")
