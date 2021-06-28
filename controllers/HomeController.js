const vars = require("../config/Database");

const pool = vars.db;

const getUsers = (req, res) => {
    pool.query('SELECT * FROM tb_users ORDER BY id ASC', (error, results, fields) => {
        if (error) throw error;
        res.send(JSON.stringify(results.rows));
    })
}

module.exports = {
    getUsers
}; 