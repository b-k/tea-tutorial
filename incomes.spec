include: recode.spec

impute {
    vars: has_income
    categories {
        age_cat
        sex
        puma   #public use microdata area
    }
    method: hot deck
    output table: has_in
}

common {
    earlier output table: has_in
    min group size: 5
    subset: agep+0.0>15

    categories {
        has_income
        age_cat
        sex
        puma
    }
}

impute {
    vars: PINCP
    paste in: common
    method: hot deck
    output table: hd
}

impute {
    vars: PINCP
    paste in: common
    method: normal
    output table: norm
}

