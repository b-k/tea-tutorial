#include <apop.h>

double truncate(double in){return in> 0 ? in : 0;}

int main(){
    apop_db_open("test.db");
    if(!apop_table_exists("dc"))
        apop_text_to_db(.text_file="dc_pums_08.csv", .tabname="dc");

    apop_data *d=apop_query_to_data(
                "select serialno*100 + sporder as id, "
                "PINCP as income from dc limit 2000");

    apop_model *norm = apop_model_set_parameters(apop_normal, 0.9, .2);
    apop_data *draw_d = apop_model_draws(norm, d->matrix->size1);
    apop_map(draw_d, .fn_d=truncate, .inplace='y');

    gsl_vector *incomes= Apop_cv(d, apop_name_find(d->names, "income", 'c'));
    gsl_vector *draws=Apop_cv(draw_d, 0);

    gsl_vector_mul(incomes, draws);
    apop_data_print(d, "fake_incomes", .output_name="fake_in.csv");
}
