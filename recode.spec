database: test.db
id: id

input {
    input file: dc_pums_08.csv
    output table: dc
}

fields {
    age: real
    pincp: real
    schl: int 1-24
}

recodes {
    id: serialno*100 + sporder
    log_in: log10(PINCP+10)
}

group recodes {
   group id: serialno
   hh_in: max(case sporder when 1 then log_in else 0 end)
   house_in: sum(case when PINCP is not null and PINCP > 0 then PINCP else 0 end)
}

recodes {
    log_house_in: log10(house_in)
}
