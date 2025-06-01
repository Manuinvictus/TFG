import React, { useEffect, useState } from "react";

const LinkStudents = () => {
    const [requests, setRequests] = useState([]);
    const [showBlob, setShowBlob] = useState(null);
    const [currentBlobUrl, setCurrentBlobUrl] = useState(null);

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

    const fetchBlob = (idGestion, tipo) => {
        let route = '';
        switch (tipo) {
            case 'cv':
                route = `/linkStudents/${idGestion}/cv`;
                break;
            case 'anexo2':
                route = `/linkStudents/${idGestion}/anexo2`;
                break;
            case 'anexo3':
                route = `/linkStudents/${idGestion}/anexo3`;
                break;
            default:
                return;
        }

        fetch(route)
        .then(res => {
            if (!res.ok) throw new Error('Error al obtener el documento');
            return res.blob();
        })
        .then(blob => {
            if (currentBlobUrl) {
                URL.revokeObjectURL(currentBlobUrl);
            }
            const url = URL.createObjectURL(blob);
            setCurrentBlobUrl(url);
            setShowBlob({ tipo, url, nombre: `${tipo.toUpperCase()} - ${idGestion}`,
                nombreAlumno: requests.find(r => r.idGestion === idGestion)?.nombre || ''});
        })
        .catch(err => {
            alert(err.message);
        });
    };

    const closeBlobViewer = () => {
        if (currentBlobUrl) {
            URL.revokeObjectURL(currentBlobUrl);
            setCurrentBlobUrl(null);
        }
        setShowBlob(null);
    };

    // Función para validar el documento.
    const validateDoc = () => {
        const idGestion = showBlob.nombre.split(' - ')[1];
        fetch(`/linkStudents/${idGestion}/${showBlob.tipo}/validate`);
        closeBlobViewer();
        LinkStudents();
    };

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
                                        <p>{r.em1 || "—"}</p>
                                    </div>
                                    <span className={`badge ${r.est1 === 'Aprobado' ? 'bg-success' : r.est1 === 'Rechazado' ? 'bg-danger' : 'bg-warning'} text-white px-2 py-1 rounded text-xs`}>
                                        {r.est1}
                                    </span>
                                </div>
                                <div className="col">
                                    <div>
                                        <p className="text-sm text-muted mb-0">Tipo Contrato</p>
                                        <p>{r.tipo1}</p>
                                    </div>
                                    <div>
                                        <p className="text-sm text-muted mb-0">Nota Media</p>
                                        <p>{r.notaMedia !== null ? r.notaMedia.toFixed(2) : "—"}</p>
                                    </div>
                                </div>
                                <div className="col">
                                    <div>
                                        <p className="text-sm text-muted mb-0">Documentos:</p>
                                        <div className="flex gap-2">
                                            <button onClick={() => fetchBlob(r.idGestion, 'cv')} className="btn btn-sm btn-primary me-2">
                                                Ver CV
                                            </button>
                                            <button onClick={() => fetchBlob(r.idGestion, 'anexo2')} className="btn btn-sm btn-primary me-2">
                                                Ver Anexo 2
                                            </button>
                                            <button onClick={() => fetchBlob(r.idGestion, 'anexo3')} className="btn btn-sm btn-primary">
                                                Ver Anexo 3
                                            </button>
                                        </div>
                                    </div>
                                    <div>
                                        <p className="text-sm text-muted mb-0">Firmados:</p>
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
                                    <p className="text-sm">{r.obv1 || "Sin observaciones"}</p>
                                </div>
                            </div>
                        </div>
                    </div>
                ))}
            </div>
            {showBlob && (
                <div className="modal fade show" style={{ display: 'block', backgroundColor: 'rgba(0,0,0,0.5)' }}
                        onClick={closeBlobViewer}>
                    <div className="modal-dialog modal-xl" style={{ maxWidth: '90%', height: '90vh' }} 
                            onClick={e => e.stopPropagation()}>
                        <div className="modal-content h-100">
                            <div className="modal-header">
                            <h5 className="modal-title">
                                {showBlob.nombreAlumno} - {showBlob.nombre}
                            </h5>
                            <div className="ms-auto">
                                {(showBlob.tipo === 'anexo2' || showBlob.tipo === 'anexo3') && (
                                    <button onClick={validateDoc} className="btn btn-success me-2">
                                        Validar
                                    </button>
                                )}
                                <button onClick={() => window.open(showBlob.url, '_blank')} className="btn btn-success me-2">
                                    Abrir en nueva pestaña
                                </button>
                                <button type="button" className="btn-close" onClick={closeBlobViewer}></button>
                            </div>
                            </div>
                            <div className="modal-body p-0" style={{ height: 'calc(100% - 56px)' }}>
                                <iframe src={showBlob.url} title={`Documento de ${showBlob.nombreAlumno}`} width="100%" 
                                    height="100%"style={{ border: 'none' }}>
                                    <p>
                                        Tu navegador no soporta la visualización de PDFs. 
                                        <a href={showBlob.url} download>Descarga el documento</a> 
                                        para verlo.
                                    </p>
                                </iframe>
                            </div>
                        </div>
                    </div>
                </div>
            )}
        </div>
    );
};

export default LinkStudents;