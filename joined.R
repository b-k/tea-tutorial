library(tea)
readSpec("joined.spec")
doMImpute()

checkOutImpute("dc_united", "filled_em", filltab="via_em")
checkOutImpute("dc_united", "filled_hd", filltab="via_hot_deck")

print("Before impute:")
print(summary(teaTable("dc", cols="pincp", where="pincp>=0")))      
print("EM:")
print(summary(teaTable("filled_em", cols="pincp")))      
print("HD:")
print(summary(teaTable("filled_hd", cols="pincp")))      
