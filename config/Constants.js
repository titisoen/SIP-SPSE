const Pool = require('pg').Pool
const db = new Pool({
    user: 'sip_spse',
    host: 'localhost',
    database: 'sip_spse',
    password: 'sip_spse',
    port: 5432,
})

module.exports = {
    db
}