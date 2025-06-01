const { connection } = require("../db/config");

// MOSTRAR TODAS LAS PETICIONES HECHAS POR ALUMNOS
exports.showStudentRequests = function (request, response) {
    const sql = `
    SELECT g.idGestion, a.nombre, a.dni, es.nombreEsp, g.anexo2FirmadoRecibido, e.idEvaluacion, e.notaMedia, 
	em1.empresa as em1, est1.descEstado as est1, t1.nombreTipo as tipo1, g.observaciones1 as obv1,
    em2.empresa as em2, est2.descEstado as est2, t2.nombreTipo as tipo2, g.observaciones2 as obv2, 
    em3.empresa as em3, est3.descEstado as est3, t3.nombreTipo as tipo3, g.observaciones3 as obv3, 
	g.fechaFormalizacion, g.anexo3FirmadoRecibido
    FROM gestiondual g
    JOIN gf_alumnosfct a ON a.idAlumno = g.idAlumno
    LEFT JOIN ge_empresas em1 ON em1.idempresa = g.idEmpresa1
    LEFT JOIN ge_empresas em2 ON em2.idempresa = g.idEmpresa2
    LEFT JOIN ge_empresas em3 ON em3.idempresa = g.idEmpresa3
    JOIN estadodual est1 ON g.estadoDual1 = est1.idEstado
    LEFT JOIN estadodual est2 ON g.estadoDual2 = est2.idEstado
    LEFT JOIN estadodual est3 ON g.estadoDual3 = est3.idEstado
    LEFT JOIN tipocontrato t1 ON g.tipoContrato1 = t1.idContrato
    LEFT JOIN tipocontrato t2 ON g.tipoContrato2 = t2.idContrato
    LEFT JOIN tipocontrato t3 ON g.tipoContrato3 = t3.idContrato
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

// OBTENER CV POR ID
exports.getCvDoc = function(request, response) {
    const id = request.params.id;
    const sql = 'SELECT cvDoc FROM gestiondual WHERE idGestion = ?';

    connection.query(sql, [id], (error, results) => {
        if (error) return response.status(500).send('Error en BD');
        if (results.length === 0) return response.status(404).send('No encontrado');

        const blob = results[0].cvDoc;
        if (!blob) return response.status(404).send('Blob no encontrado');

        response.setHeader('Content-Type', 'application/pdf');
        response.send(blob);
    });
};

// OBTENER ANEXO2 POR ID
exports.getAnexo2Doc = function(request, response) {
    const id = request.params.id;
    const sql = 'SELECT anexo2Doc FROM gestiondual WHERE idGestion = ?';

    connection.query(sql, [id], (error, results) => {
        if(error)
            throw error;

        const blob = results[0].anexo2Doc;
        if (!blob) return response.status(404).send('No hay blobs recogidos en la gestión con id ' + id);

        response.setHeader('Content-Type', 'application/pdf');
        response.send(blob);
    });
};

// OBTENER ANEXO3 POR ID
exports.getAnexo3Doc = function(request, response) {
    const id = request.params.id;
    const sql = 'SELECT anexo3Doc FROM gestiondual WHERE idGestion = ?';

    connection.query(sql, [id], (error, results) => {
        if(error)
            throw error;

        const blob = results[0].anexo3Doc;
        if (!blob) return response.status(404).send('No hay blobs recogidos en la gestión con id ' + id);

        response.setHeader('Content-Type', 'application/pdf');
        response.send(blob);
    });
};

// Obtener anexo3Doc por idGestion
exports.validate = function(request, response) {
    const id = request.params.id;
    const type = request.params.type;
    let sql = '';
    switch (type) {
        case 'anexo2': sql = 'UPDATE gestiondual SET anexo2FirmadoRecibido = NOT anexo2FirmadoRecibido WHERE idGestion = ?'; break;
        case 'anexo2': sql = 'UPDATE gestiondual SET anexo3FirmadoRecibido = NOT anexo3FirmadoRecibido WHERE idGestion = ?'; break;
        default: return false;
    }

    connection.query(sql, [id], (error, results) => {
        if(error)
            throw error;
        response.status(200).json(results);
    });
};