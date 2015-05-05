library(tea)
readSpec("incomes.spec")
doInput()


#To prevent a million log(0) errors, give everybody $10
dbGetQuery(teaenv$con, "update viewdc set pincp=pincp+10")

# Dirty up the data by blanking out 30% of incomes
source("pokeHoles.R")
pokeHoles("viewdc", "pincp", .3)

doMImpute()

# A function to use checkOutImpute to get imputed PINCPs and save them
# in a format amenable to the plotting routine
getOne <-function(method, fillins){
    filledtab <- paste(fillins, "fill", sep="")
    checkOutImpute(origin="viewdc", dest=filledtab, filltab=fillins,
                       subset="agep+0>15")
    outframe <-teaTable(filledtab, cols="PINCP")
    outframe$PINCP <- log10(outframe$PINCP+10)
    outframe$imp <- paste("via", method)
    return(outframe)
}

# The data sets in this function are two-column: the first 
# is the observed value, and the second is the name of the method.
# Put the two imputations and the original data in that format,
# then send to ggplot.
plotWage <- function(outname){
    dfhd <- getOne("Hot Deck", "hd")
    dfnorm <- getOne("Lognormal", "norm")

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
