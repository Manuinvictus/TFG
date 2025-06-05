const { connection } = require("../db/config");
const bcrypt = require("bcrypt");

// Usuario por email
exports.getUserByEmail = function (request, response) {
    connection.query("SELECT * FROM users WHERE email = ?",
        [request.body.email], 
    (error, results) => {
        if(error)
            throw error;
        if(results == null) return res.status(400).json({msg: "User not found"});
        response.status(200).json(results);
    });
};

// Insertar usuarios
exports.addUser = function (request, response) {
    const name = request.body.name;
    const email = request.body.email;
    connection.query("INSERT INTO users(name, email) VALUES (?, ?)",
        [name, email],
        (error, results) => {
            if (error) {
                console.error("Error al insertar el usuario:", error);
                return response.status(500).json({ error: "Error al crear el usuario" });
            }

            addCourses(results.insertId, request.body.specialities);

            response.status(201).json("Usuario añadido correctamente");
        }
    );
};

function addCourses(id, specialities){

}