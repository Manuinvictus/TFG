const { connection } = require("../db/config");
const bcrypt = require("bcrypt");

// Usuario por nombre
exports.getUserByName = function (request, response) {
    connection.query("SELECT * FROM users WHERE name = ?",
        [request.body.name], 
    (error, results) => {
        if(error)
            throw error;
        response.status(200).json(results);
        if(results == null || request.body.password == null) return res.status(400).json({msg: "User not found"});
        const match = bcrypt.compareSync(request.body.password, results[0].hash);
        console.log(match);
        if( match ) return res.status(400).json({msg: "Wrong Password"});
    });
};

// Insertar usuarios
exports.addUser = function (request, response) {
    const name = request.body.name;
    const password = request.body.password;
    const salt = bcrypt.genSaltSync(20);
    const hashPassword = bcrypt.hashSync(password, salt);
    connection.query("INSERT INTO users(name, password, hash) VALUES (?, ?, ?)",
        [name, hashPassword, salt],
        (error, results) => {
            if(error) throw error;
            response.status(201).json("Item añadido correctamente");
        }
    );
};