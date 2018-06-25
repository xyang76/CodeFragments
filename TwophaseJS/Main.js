/**
 * 
 */
var cp = require('child_process');

const coordinator = cp.fork('./Coordinator.js');
const cohort1 = cp.fork('./Cohort.js');
const cohort2 = cp.fork('./Cohort.js');
const cohort3 = cp.fork('./Cohort.js');

coordinator.send({type : 'init', cohorts: 3});
cohort1.send('init');
cohort2.send('init');
cohort3.send('init');


