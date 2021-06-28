const express   = require("express");
const router    = express.Router();

const home = require("../controllers/HomeController");
router.get('/', home.getUsers);

module.exports = router;