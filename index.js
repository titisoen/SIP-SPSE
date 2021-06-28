const express = require("express");
const bodyParser = require('body-parser')
const path = require("path");
const app = express();

// Server Configuration
app.set("view engine", "ejs"); // Mendeklarasikan bahwa engine EJS harus digunakan 
app.set("views", path.join(__dirname, "views")); // Mendeklarasikan bahwa view ada di folder Views. Jika tanpa path bisa dengan : app.set("views", __dirname + "/views");
app.use(express.static(path.join(__dirname, "public"))); // Mendeklarasikan bahwa file statis disimpan di folder public dan subdirectory-nya, apabila ada file asset yang diperlukan akan diload disini.
app.use(express.urlencoded({ extended: false })); // Mendeklarasikan middleware agar Request.body dapat dibaca
app.use(bodyParser.json())
app.use(
    bodyParser.urlencoded({
        extended: true,
    })
)


// Starting The Server
app.listen(3000, () => {
    console.log("Server started (http://localhost:3000/) !");
});

const route = require('./config/Routes');
app.use('/', route);