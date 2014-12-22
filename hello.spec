database: test.db

input {
    input file: dc_pums_08.csv
    output table: dc
}

fields {
    age: real
    schl: int 1-24
}
