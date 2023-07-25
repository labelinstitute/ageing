
* USE: STATA_data_Dec2016 * 

* In treatment S, a significant fraction of subjects have no violations (66% of YA and 42% of OA).
tabstat consinsimple, by(ya)

* This fraction shrinks substantially in treatment C (34% of YA and 11% of OA). 
tabstat consincomplex, by(ya)

* 88% of our YA and 84% of our OA incur less than 23 violations in treatment S
tabstat lessorequal23violationsins, by(ya)

* and 94% of our YA and 80% of our OA incur less than 105 violations in treatment C
tabstat lessorequal105violationsinc, by(ya)
