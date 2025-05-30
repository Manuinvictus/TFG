import React, { useEffect, useState } from "react";

const LinkStudents = () => {
    const [requests, setRequests] = useState([]);

    // ----------------------------------------------------------------   USE EFFECTS
    useEffect(() => {
        LinkStudents();
    }, []);

    // -----------------------------------------------------------------   GET ALLS
    // 
    // Recoge todos los datos de la tabla especialidades y los guarda en dataSpecialities
    function LinkStudents() {
        fetch('/linkStudents') // Hacer una solicitud HTTP GET a '/linkStudents'
        .then(response => response.json()) // Convertir la respuesta a JSON
        .then(requests => {
            setRequests(requests); // Establecer los datos obtenidos en el estado 'dataSpecialities'
            console.log(requests); // Mostrar el contenido en la consola
        })
        .catch(error => {
            console.error('Error fetching requests data:', error);
        });
    }

    return (
        <div className="p-4 m-5">
            <h2 className="text-xl font-semibold mb-4">Peticiones de Alumnos</h2>
            <div className="grid gap-4">
                {requests.map((r) => (
                    <div key={r.idGestion} className="card border rounded-lg shadow-sm mb-4">
                        <div className="card-body p-4">
                            <div className="flex justify-between items-start mb-2">
                                <h3 className="card-title font-medium text-lg">
                                    {r.nombre} ({r.dni})
                                </h3>
                                <span className={`badge ${r.descEstado === 'Aprobado' ? 'bg-success' : r.descEstado === 'Rechazado' ? 'bg-danger' : 'bg-warning'} text-white px-2 py-1 rounded text-xs`}>
                                    {r.descEstado}
                                </span>
                                <span className={`badge ${r.descEstado === 'Aprobado' ? 'bg-success' : r.descEstado === 'Rechazado' ? 'bg-danger' : 'bg-warning'} text-white px-2 py-1 rounded text-xs`}>
                                    {r.fechaFormalizacion}
                                </span>
                            </div>
                            <div className="row">
                                <div className="col">
                                    <div>
                                        <p className="text-sm text-muted mb-0">Especialidad</p>
                                        <p>{r.nombreEsp}</p>
                                    </div>
                                    <div>
                                        <p className="text-sm text-muted mb-0">Empresa</p>
                                        <p>{r.empresa || "—"}</p>
                                    </div>
                                </div>
                                <div className="col">
                                    <div>
                                        <p className="text-sm text-muted mb-0">Tipo Contrato</p>
                                        <p>{r.nombreTipo}</p>
                                    </div>
                                    <div>
                                        <p className="text-sm text-muted mb-0">Nota Media</p>
                                        <p>{r.notaMedia !== null ? r.notaMedia.toFixed(2) : "—"}</p>
                                    </div>
                                </div>
                                <div className="col">
                                    <div>
                                        <p className="text-sm text-muted mb-0">Documentos</p>
                                        <div className="flex gap-2">
                                            <span>CV: {r.cvDoc ? "✅" : "❌"}</span>
                                            <span>A2: {r.anexo2Doc ? "✅" : "❌"}</span>
                                            <span>A3: {r.anexo3Doc ? "✅" : "❌"}</span>
                                        </div>
                                    </div>
                                    <div>
                                        <p className="text-sm text-muted mb-0">Firmados</p>
                                        <div className="flex gap-2">
                                            <span>A2: {r.anexo2FirmadoRecibido ? "✅" : "❌"}</span>
                                            <span>A3: {r.anexo3FirmadoRecibido ? "✅" : "❌"}</span>
                                        </div>
                                    </div>
                                    <div>
                                        <p className="text-sm text-muted mb-0">ID Evaluación</p>
                                        <p>{r.idEvaluacion || "—"}</p>
                                    </div>
                                </div>
                                <div className="md:col-span-2 lg:col-span-4">
                                    <p className="text-sm text-muted mb-0">Observaciones</p>
                                    <p className="text-sm">{r.observaciones || "Sin observaciones"}</p>
                                </div>
                            </div>
                        </div>
                    </div>
                ))}
            </div>
        </div>
    );
};

export default LinkStudents;