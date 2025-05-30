const { connection } = require("../db/config");

// MOSTRAR TODAS LAS PETICIONES HECHAS POR ALUMNOS
exports.showStudentRequests = function (request, response) {
    const sql = `
    SELECT g.idGestion, est.descEstado, a.nombre, a.dni, g.cvDoc, 
    g.anexo2Doc, g.anexo2FirmadoRecibido, es.nombreEsp, e.idEvaluacion, 
    e.notaMedia, em.empresa, g.anexo3Doc, g.anexo3FirmadoRecibido, t.nombreTipo, 
    g.observaciones, g.fechaFormalizacion
    FROM gestiondual g
    JOIN gf_alumnosfct a ON a.idAlumno = g.idAlumno
    LEFT JOIN ge_empresas em ON em.idempresa = g.idEmpresa
    JOIN estadodual est ON g.estadoDual = est.idEstado
    JOIN tipocontrato t ON g.tipoContrato = t.idContrato
    JOIN especialidad es ON g.idEspecialidad = es.idEspecialidad
    LEFT JOIN (
        SELECT e1.*
        FROM evaluacion e1
        INNER JOIN (
            SELECT e2.idAlumno, e2.idEspecialidad, MAX(e2.fecha) AS ultFecha
            FROM evaluacion e2
            GROUP BY e2.idAlumno, e2.idEspecialidad
        ) reciente
        ON e1.idAlumno = reciente.idAlumno 
        AND e1.idEspecialidad = reciente.idEspecialidad 
        AND e1.fecha = reciente.ultFecha
    ) e 
    ON e.idAlumno = g.idAlumno AND e.idEspecialidad = g.idEspecialidad
    ORDER BY g.fechaFormalizacion DESC;
    `;

    connection.query(sql, (error, results) => {
        if(error)
            throw error;
        response.status(200).json(results);
    });
};