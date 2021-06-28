const Pool = require('pg').Pool;
const db    = {
    user : 'sip_spse',
    host : 'localhost',
    database : 'sip_spse',
    password : 'sip_spse',
    port : 5432,
}
const pool = new Pool(db);

module.exports = {
    db: pool
};
