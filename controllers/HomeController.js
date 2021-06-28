const model = require("../models/HomeModel");

const getUsers = (req, res) => {
    res.send(model.getUsers);
}

module.exports = {
    getUsers
}; 