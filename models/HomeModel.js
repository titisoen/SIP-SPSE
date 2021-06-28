// const vars = require("../config/Constants");
// const pool = vars.db;
const Pool = require('pg').Pool
const pool = new Pool({
    user: 'sip_spse',
    host: 'localhost',
    database: 'sip_spse',
    password: 'sip_spse',
    port: 5432,
})

const getUsers = (req, res) => {
    pool.query('SELECT * FROM tb_users ORDER BY id ASC', (error, results) => {
        if (error) {
            throw error
        }
        res.status(200).json(results.rows)
    })
}

module.exports = {
    getUsers
}; 