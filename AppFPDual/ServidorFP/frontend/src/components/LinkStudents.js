import { useEffect, useState, useCallback  } from "react";
import { useUser } from '../globales/User';
import { useNavigate } from 'react-router-dom';

const LinkStudents = () => {
    const { user } = useUser(); // Obtiene el usuario del contexto
    const navigate = useNavigate(); // Para mandar a login si no hay usuario
    const [requests, setRequests] = useState([]);
    const [showDoc, setShowDoc] = useState(null);
    const [currentDocUrl, setCurrentDocUrl] = useState(null); // Para el visualizador de documentos
    const [expandedCards, setExpandedCards] = useState(new Set()); // Para expandir las cards
    const [sendingInfo, setSendingInfo] = useState(new Set()); // Para evitar múltiples envíos

    // El useCallback debe declararse antes del useEffect para que funcione.
    // esto se usa para que en el hipotético de que user.specialities cambiase
    // la función se volviese a ejecutar.
    // Recoge todos los datos de un join de tablas y los guarda en requests
    const LinkStudents = useCallback(() => {
        if (!user) {
            navigate('/login');
        }
        const bodyParameters = {
            'specialities': user.specialities,
        };
        // Configurar las opciones para la solicitud fetch
        const options = {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(bodyParameters) // Convertir el objeto a JSON
        };

        fetch('/linkStudents', options) // Hacer una solicitud HTTP GET a '/linkStudents'
        .then(response => response.json()) // Convertir la respuesta a JSON
        .then(requests => {
            setRequests(requests); // Establecer los datos obtenidos en el estado 'requests'
            console.log(requests); // Mostrar el contenido en la consola
        })
        .catch(error => {
            console.error('Error fetching requests data:', error);
        });
    }, [user, navigate]);

    // ----------------------------------------------------------------   USE EFFECTS
    useEffect(() => {
        LinkStudents();
    }, [LinkStudents]);

    // -----------------------------------------------------------------   GETS
    // 
    // Esta funcion saca el documento elegido de la gestión escogida. 
    const getDoc = (idGestion, tipo) => {
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
                // Si ya tenemos un documento almacenado lo eliminamos
                if (currentDocUrl) {
                    URL.revokeObjectURL(currentDocUrl);
                }
                const url = URL.createObjectURL(blob);
                setCurrentDocUrl(url);
                setShowDoc({ tipo, url, nombre: `${tipo.toUpperCase()} - ${idGestion}`,
                    nombreAlumno: requests.find(r => r.idGestion === idGestion)?.nombre || ''});
            })
            .catch(err => {
                alert(err.message);
            });
    };

    // Esta funcion saca el documento elegido de la gestión escogida. 
    const getEvaluation = (idGestion) => {
        if (!idGestion) navigate(`/evaluate/0`);
        const letras = 'QRBMUHPWACKZFJLVDXSYIGTNOE';
        navigate(`/evaluate/${idGestion * 23 + letras[idGestion % 26]}`);
    };

    // -----------------------------------------------------------------   FUNCTIONS
    // 
    // Función para cerrar el visualizador de docs.
    const closeDocViewer = () => {
        if (currentDocUrl) {
            URL.revokeObjectURL(currentDocUrl);
            setCurrentDocUrl(null);
        }
        setShowDoc(null);
    };

    // Función para validar el documento.
    const validateDoc = async () => {
        const idGestion = showDoc.nombre.split(' - ')[1];
        await fetch(`/linkStudents/${idGestion}/${showDoc.tipo}/validate`);
        closeDocViewer();
        LinkStudents();
    };

    // Función para desplegar las cards.
    const toggleCard = (id) => {
        const newSet = new Set(expandedCards);
        if (newSet.has(id)) {
            newSet.delete(id);
        } else {
            newSet.add(id);
        }
        setExpandedCards(newSet);
    };

    // Función para enviar la información de los alumnos a las empresas.
    const sendInfo = async (idGestion, idAlumno, idEmpresa) => {
        // Crear un identificador único para este botón
        const buttonId = `${idGestion}-${idEmpresa}`
        // Si ya se está enviando información con este botón, no hacer nada
        if (sendingInfo.has(buttonId)) return;
        // Añadir el botón al array de botones en proceso
        setSendingInfo(prev => new Set([...prev, buttonId]));
        try {
            const url = window.location.origin;
            const bodyParameters = {
                'idGestion': idGestion,
                'idAlumno': idAlumno,
                'idEmpresa': idEmpresa,
                'url': url,
            };
            // Configurar las opciones para la solicitud fetch
            const options = {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(bodyParameters) // Convertir el objeto a JSON
            };
            await fetch("/sendMail", options);
            LinkStudents();
        } catch (error) {
            console.error('Error sending info:', error);
        } finally {
            // Eliminar el botón del array de botones en proceso
            setSendingInfo(prev => {
                const newSet = new Set(prev);
                newSet.delete(buttonId);
                return newSet;
            });
        }
    }

    return (
        <div className="container">
            <div className="row">
                <h2 className="text-xl font-semibold mb-4 mt-4">Peticiones de Alumnos</h2>
                <div className="grid gap-4">
                {requests.map((r) => {
                    const isExpanded = expandedCards.has(r.idGestion);
                    return (
                        <div key={r.idGestion} className="card border rounded-lg shadow-sm mb-4">
                            <div className="card-body p-4 position-relative">
                                <div className="flex justify-between items-start mb-2">
                                    <div className="flex items-center gap-2">
                                        <h3 className="card-title font-medium text-lg">
                                            {r.nombre} ({r.dni})
                                        </h3>
                                        <p>{r.nombreEsp}</p>
                                    </div>
                                    <div className="row mt-3">
                                        <div className="col">
                                            {r.em1 && (
                                            <span className={`badge ${r.estid1 === 0 ? 'bg-info' : r.estid1 === 1 ? 'bg-secondary' :
                                                r.estid1 === 2 ? 'bg-primary' : r.estid1 === 3 ? 'bg-danger' : 
                                                r.estid1 === 4 ? 'bg-warning' : 'bg-success'} text-white px-2 py-1 rounded text-xs`}>
                                                EMPRESA 1: {r.em1}
                                            </span>
                                            )}
                                        </div>
                                        <div className="col">
                                            {r.em2 && (
                                            <span className={`badge ${r.estid2 === 0 ? 'bg-info' : r.estid2 === 1 ? 'bg-secondary' :
                                                r.estid2 === 2 ? 'bg-primary' : r.estid2 === 3 ? 'bg-danger' : 
                                                r.estid2 === 4 ? 'bg-warning' : 'bg-success'} text-white px-2 py-1 rounded text-xs`}>
                                                EMPRESA 2: {r.em2}
                                            </span>
                                            )}
                                        </div>
                                        <div className="col">
                                            {r.em3 && (
                                            <span className={`badge ${r.estid3 === 0 ? 'bg-info' : r.estid3 === 1 ? 'bg-secondary' :
                                                r.estid3 === 2 ? 'bg-primary' : r.estid3 === 3 ? 'bg-danger' : 
                                                r.estid3 === 4 ? 'bg-warning' : 'bg-success'} text-white px-2 py-1 rounded text-xs`}>
                                                EMPRESA 3: {r.em3}
                                            </span>
                                            )}
                                        </div>
                                    </div>
                                    <button onClick={() => toggleCard(r.idGestion)} 
                                        className="btn btn-sm btn-outline-secondary position-absolute"
                                        style={{ top: '16px', right: '16px', minWidth: '32px', minHeight: '32px', zIndex: 1 }}>
                                        {isExpanded ? '▲' : '▼'}
                                    </button>
                                </div>
                                {isExpanded && (
                                    <div>
                                        <div className="row mt-3">
                                            <div className="col-4">
                                                <span className={`badge ${r.estid1 === 0 ? 'bg-info' : r.estid1 === 1 ? 'bg-secondary' :
                                                    r.estid1 === 2 ? 'bg-primary' : r.estid1 === 3 ? 'bg-danger' : 
                                                    r.estid1 === 4 ? 'bg-warning' : 'bg-success'} text-white px-2 py-1 rounded text-xs`}
                                                    style={{wordWrap: 'break-word', whiteSpace: 'normal', display: 'inline-block'}}>
                                                    {r.est1}
                                                </span>
                                                {user.specialities[0] == null && r.estid1 === 1 && (
                                                    <button 
                                                        onClick={() => sendInfo(r.idGestion, r.idAlumno, r.idEmpresa1)} 
                                                        className={sendingInfo.has(`${r.idGestion}-1`) ? "btn btn-sm btn-disabled mt-2" : "btn btn-sm btn-primary mt-2"}
                                                        disabled={sendingInfo.has(`${r.idGestion}-1`)}>
                                                        {sendingInfo.has(`${r.idGestion}-1`) ? "Enviando..." : "Enviar información a la empresa."}
                                                    </button>
                                                )}
                                                {r.tipo1 && (
                                                <div>
                                                    <p className="text-sm text-muted mb-0 mt-2">Tipo Contrato</p>
                                                    <p>{r.tipo1}</p>
                                                </div>
                                                )}
                                                {r.obv1 && (
                                                <div className="md:col-span-2 lg:col-span-4 mt-3">
                                                    <p className="text-sm text-muted mb-0">Observaciones</p>
                                                    <p className="text-sm">{r.obv1}</p>
                                                </div>
                                                )}
                                            </div>
                                            <div className="col-4">
                                                {r.est2 && (
                                                <span className={`badge ${r.estid2 === 0 ? 'bg-info' : r.estid2 === 1 ? 'bg-secondary' :
                                                    r.estid2 === 2 ? 'bg-primary' : r.estid2 === 3 ? 'bg-danger' : 
                                                    r.estid2 === 4 ? 'bg-warning' : 'bg-success'} text-white px-2 py-1 rounded text-xs`}
                                                    style={{wordWrap: 'break-word', whiteSpace: 'normal', display: 'inline-block'}}>
                                                    {r.est2}
                                                </span>
                                                )}
                                                {user.specialities[0] == null && r.estid2 === 1 && (
                                                    <button 
                                                        onClick={() => sendInfo(r.idGestion, r.idAlumno, r.idEmpresa2)} 
                                                        className={sendingInfo.has(`${r.idGestion}-2`) ? "btn btn-sm btn-disabled mt-2" : "btn btn-sm btn-primary mt-2"}
                                                        disabled={sendingInfo.has(`${r.idGestion}-2`)}>
                                                        {sendingInfo.has(`${r.idGestion}-2`) ? "Enviando..." : "Enviar información a la empresa."}
                                                    </button>
                                                )}
                                                {r.tipo2 && (
                                                <div>
                                                    <p className="text-sm text-muted mb-0 mt-2">Tipo Contrato</p>
                                                    <p>{r.tipo2}</p>
                                                </div>
                                                )}
                                                {r.obv2 && (
                                                <div className="md:col-span-2 lg:col-span-4 mt-3">
                                                    <p className="text-sm text-muted mb-0">Observaciones</p>
                                                    <p className="text-sm">{r.obv2}</p>
                                                </div>
                                                )}
                                            </div>
                                            <div className="col-4">
                                                {r.est3 && (
                                                <span className={`badge ${r.estid3 === 0 ? 'bg-info' : r.estid3 === 1 ? 'bg-secondary' :
                                                    r.estid3 === 2 ? 'bg-primary' : r.estid3 === 3 ? 'bg-danger' : 
                                                    r.estid3 === 4 ? 'bg-warning' : 'bg-success'} text-white px-2 py-1 rounded text-xs`}
                                                    style={{wordWrap: 'break-word', whiteSpace: 'normal', display: 'inline-block'}}>
                                                    {r.est3}
                                                </span>
                                                )}
                                                {user.specialities[0] == null && r.estid3 === 1 && (
                                                    <button 
                                                        onClick={() => sendInfo(r.idGestion, r.idAlumno, r.idEmpresa3)} 
                                                        className={sendingInfo.has(`${r.idGestion}-3`) ? "btn btn-sm btn-disabled mt-2" : "btn btn-sm btn-primary mt-2"}
                                                        disabled={sendingInfo.has(`${r.idGestion}-3`)}>
                                                        {sendingInfo.has(`${r.idGestion}-3`) ? "Enviando..." : "Enviar información a la empresa."}
                                                    </button>
                                                )}
                                                {r.tipo3 && (
                                                <div>
                                                    <p className="text-sm text-muted mb-0 mt-2">Tipo Contrato</p>
                                                    <p>{r.tipo3}</p>
                                                </div>
                                                )}
                                                {r.obv3 && (
                                                <div className="md:col-span-2 lg:col-span-4 mt-3">
                                                    <p className="text-sm text-muted mb-0">Observaciones</p>
                                                    <p className="text-sm">{r.obv3}</p>
                                                </div>
                                                )}
                                            </div>
                                        </div>
                                        <div className="row">
                                            <div className="col-4">
                                                <div>
                                                    <p className="text-sm text-muted mb-0">Documentos:</p>
                                                    <div className="flex gap-2">
                                                        <button onClick={() => getDoc(r.idGestion, 'cv')} className="btn btn-sm btn-primary me-2">
                                                            Ver CV
                                                        </button>
                                                        <button onClick={() => getDoc(r.idGestion, 'anexo2')} className="btn btn-sm btn-primary me-2">
                                                            Ver Anexo 2
                                                        </button>
                                                        <button onClick={() => getDoc(r.idGestion, 'anexo3')} className="btn btn-sm btn-primary">
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
                                            </div>
                                            <div className="col-4">
                                                <div>
                                                    <p className="text-sm text-muted mb-0">Evaluación</p>
                                                    <button onClick={() => getEvaluation(r.idGestion)} className="btn btn-sm btn-primary">
                                                        {r.idEvaluacion !== null ? "Ver" : "Evaluar"}
                                                    </button>
                                                </div>
                                            </div>
                                            <div className="col-4">
                                                {r.notaTotal && (
                                                <div>
                                                    <p className="text-sm text-muted mb-0">Nota Total</p>
                                                    <p>{r.notaTotal !== null ? r.notaTotal.toFixed(2) : "—"}</p>
                                                </div>
                                                )}
                                            </div>
                                        </div>
                                    </div>
                                )}
                            </div>
                        </div>
                    );
                })}
            </div>
            {showDoc && (
                <div className="modal fade show" style={{ display: 'block', backgroundColor: 'rgba(0,0,0,0.5)' }}
                        onClick={closeDocViewer}>
                    <div className="modal-dialog modal-xl" style={{ maxWidth: '90%', height: '90vh' }} 
                            onClick={e => e.stopPropagation()}>
                        <div className="modal-content h-100">
                            <div className="modal-header">
                            <h5 className="modal-title">
                                {showDoc.nombreAlumno} - {showDoc.nombre}
                            </h5>
                                <div className="ms-auto">
                                    {(showDoc.tipo === 'anexo2' || showDoc.tipo === 'anexo3') && (
                                        <button onClick={validateDoc} className="btn btn-success me-2">
                                            Validar
                                        </button>
                                    )}
                                    <button onClick={() => window.open(showDoc.url, '_blank')} className="btn btn-success me-2">
                                        Abrir en nueva pestaña
                                    </button>
                                    <button type="button" className="btn-close" onClick={closeDocViewer}></button>
                                </div>
                            </div>
                            <div className="modal-body p-0" style={{ height: 'calc(100% - 56px)' }}>
                                <iframe src={showDoc.url} title={`Documento de ${showDoc.nombreAlumno}`} width="100%" 
                                    height="100%"style={{ border: 'none' }}>
                                    <p>
                                        Tu navegador no soporta la visualización de PDFs. 
                                        <a href={showDoc.url} download>Descarga el documento</a> 
                                        para verlo.
                                    </p>
                                </iframe>
                            </div>
                        </div>
                    </div>
                </div>
                )}
        </div>
    </div>
    );
};

export default LinkStudents;