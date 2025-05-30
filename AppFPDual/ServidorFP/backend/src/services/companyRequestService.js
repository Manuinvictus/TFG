const { connection } = require("../db/config");

// INSERTAR NUEVA PETICIÓN DE ALUMNOS PARA EL PROGRAMA DUAL POR PARTE DE UNA EMPRESA
exports.addCompanyRequest = function (request, response) {
    const {
        dniCoordinador,
        emailCoordinador,
        nombreCoordinador,
        telefonoCoordinador,
        razonSocial,
        cif,
        telEmpresa,
        dirRazSocial,
        provincia,
        municipio,
        cpRazSoc,
        responsableLegal,
        cargo,
        dniRl,
        descripcionPuesto,
        direccionLugarTrabajo,
        metodosTransporte,
        fechaPeticion,
        specialities
    } = request.body;

    const sql = `
    INSERT INTO AuxiliarEmpresa (dniCoordinador, emailCoordinador, nombreCoordinador, telefonoCoordinador,
                                razonSocial, cif, telEmpresa, dirRazSocial, provincia, municipio, cpRazSoc,
                                responsableLegal, cargo, dni, descripcionPuesto, direccionLugarTrabajo,
                                metodosTransporte, fechaPeticion, especialidadYCantAlumnos) 
    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    `;

    const values = [
        dniCoordinador, emailCoordinador, nombreCoordinador, telefonoCoordinador,
        razonSocial, cif, telEmpresa, dirRazSocial, provincia, municipio, cpRazSoc,
        responsableLegal, cargo, dniRl, descripcionPuesto, direccionLugarTrabajo,
        metodosTransporte, fechaPeticion, specialities
    ];
    console.log(values);

    connection.query(sql, values, (err, result) => {
        if (err) {
        console.error("Error al insertar la empresa:", err);
        return response.status(500).json({ error: "Error al guardar la empresa" });
        }

        return response.status(200).json({
            message: "Empresa guardada correctamente",
            idAuxEmpresa: result.insertId
        });
    });
};