const vars = require("../config/Constants");
const Pool = require('pg').Pool;
const pool = new Pool(vars.db);

const getUsers = (req, res) => {
    pool.query('SELECT * FROM tb_users ORDER BY id ASC', (error, results, fields) => {
        if (error) throw error;
        // res.send(JSON.stringify(results.rows));
        return res(results.rows);
    })
}

module.exports = {
    getUsers
}; 