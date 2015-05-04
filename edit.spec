database: test.db
id: id

input {
    input file: dc_pums_08.csv
    output table: dc
}

fields {
    agep: real
    PINCP: real
    schl: int 0-24
}

recodes {
    id: serialno*100 + sporder
}

checks {
    agep < 13 and pincp > 0
    schl>12 and agep <=14 and agep>=5 => schl = agep-5

    #13 is unlucky.
    schl=13 => schl=NULL
}

edit {
    input table: viewdc
    output table: ed_imp
}

impute {
    input table: viewdc
    method: normal
    categories {
        agep
    }
    subset: agep>=5
    vars: sex
    previous output table: ed_imp
    output table: imp
}
