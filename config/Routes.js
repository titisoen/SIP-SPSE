const express   = require("express");
const router    = express.Router();

const home = require("../controllers/HomeController");
router.get('/', (req, res) => {
    home.getUsers(req, res)
});

module.exports = router;