const { connection } = require("../db/config");
const { transporter } = require("../mail/config");
const fs = require('fs');
const path = require('path');
// Para poder convertir a pdf los .docx
const { exec } = require('child_process');
// Para modificar la plantilla y crear los convenios.
const { createReport } = require('docx-templates');

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

    const query = `
    INSERT INTO AuxiliarEmpresa (dniCoordinador, emailCoordinador, nombreCoordinador, telefonoCoordinador,
                                razonSocial, cif, telEmpresa, dirRazSocial, provincia, municipio, cpRazSoc,
                                responsableLegal, cargo, dni, descripcionPuesto, direccionLugarTrabajo,
                                metodosTransporte, fechaPeticion, especialidadYCantAlumnos) 
    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    `;

    const values = {
        dniCoordinador, emailCoordinador, nombreCoordinador, telefonoCoordinador,
        razonSocial, cif, telEmpresa, dirRazSocial, provincia, municipio, cpRazSoc,
        responsableLegal, cargo, dniRl, descripcionPuesto, direccionLugarTrabajo,
        metodosTransporte, fechaPeticion, specialities
    };

    connection.query(query, Object.values(values), async (err, result) => {
        if (err) {
        console.error("Error al insertar la empresa:", err);
        return response.status(500).json({ error: "Error al guardar la empresa" });
        }

        const specialitiesCodes = await recibirNombres(values.specialities);
        console.log(specialitiesCodes);
        const convenioDocxPath = await editarConvenio(values, specialitiesCodes);
        const convenioPdfPath = await docxToPdf(convenioDocxPath);

        mandarMail(values, convenioPdfPath);

        response.status(201).json("Solicitud de empresa añadida correctamente");
    });
};

async function recibirNombres(specialities){
    const array =JSON.parse(specialities);;
    const values = array[0];
    const plantilla = values.map(() => '?').join(',');
    const query = `
    SELECT codigoEsp FROM especialidad WHERE idEspecialidad IN (${plantilla});
    `;
    // Si no se envuelve en una Promise, el await no se efectuará y devolverá undefined
    return new Promise((resolve, reject) => {
        connection.query(query, Object.values(values), (err, result) => {
            if (err) {
                console.error("Error al obtener los códigos de las especialidades:", err);
                return reject(err);
            }
            resolve(result);
        });
    });
}

async function editarConvenio(values, specialitiesCodes) {
    // Ruta al archivo Word original
    const templatePath = path.join(__dirname, '..', '..', 'required_documents', 'CONVENIO_GENERAL_PLANTILLA.docx');
    
    // Ruta donde se guardará el archivo editado
    const outputPath = path.join(__dirname, '..', '..', 'uploads', `CONVENIO_${values.razonSocial}_${new Date().getFullYear()}.docx`);

    try {
        // Reemplazar marcadores en el Word
        const buffer = await createReport({
            template: fs.readFileSync(templatePath),
            data: {
                razonSocial: values.razonSocial,
                responsableLegal: values.responsableLegal,
                dniRl: values.dniRl,
                dirRazSocial: values.dirRazSocial + ' ' + values.provincia + ' ' + values.municipio + ' ' + values.cpRazSoc,
                cif: values.cif,
                cargo: values.cargo,
                specialities: specialitiesCodes.map(e => e.codigoEsp).join(', '),
                fechaPeticion: values.fechaPeticion,
            },
            cmdDelimiter: ['<<', '>>'],
        });

        // Guardar el archivo editado
        fs.writeFileSync(outputPath, buffer);
        return outputPath;
    } catch (error) {
        console.error('Error al editar el convenio:', error);
        throw error;
    }
}


function docxToPdf(docxPath) {
    return new Promise((resolve, reject) => {
        const libreOfficeCommand = `soffice --headless --convert-to pdf --outdir "${path.dirname(docxPath)}" "${docxPath}"`;

        exec(libreOfficeCommand, (error, stdout, stderr) => {
            if (error) {
                console.error('Error al convertir a PDF:', stderr);
                return reject(error);
            }

            const pdfPath = docxPath.replace(/\.docx$/, '.pdf');

            // Comprobar que el archivo .pdf existe antes de borrar el .docx
            fs.access(pdfPath, fs.constants.F_OK, (err) => {
                if (err) {
                    console.error('PDF no encontrado tras la conversión');
                    return reject(new Error('PDF no generado'));
                }

                // Eliminar el archivo .docx
                fs.unlink(docxPath, (unlinkErr) => {
                    if (unlinkErr) {
                        console.warn('No se pudo eliminar el archivo .docx:', unlinkErr.message);
                    }
                    resolve(pdfPath);
                });
            });
        });
    });
}

async function mandarMail(values, convenioPath){
    const mail = {
            from: `"Salesianos Zaragoza" <${process.env.EMAIL_USER}>`,
            to: values.emailCoordinador,
            subject: 'Confirmación de solicitud - DUAL',
            html: `
            <p>Buenos días, le enviamos este correo para informarle de que la formalización de la documentación para participar
            en el programa de Formación Profesional Dual ha sido recibida correctamente.</p>
            <p>Si desea participar, por favor envíe el siguiente documento firmado a x@gmail.com antes del 15 de febrero.</p>
            `,
            attachments: [
            {
                filename: 'CONVENIO_' + values.razonSocial + '_' + new Date().getFullYear() + '.pdf',
                path: convenioPath,
            },
            ],
        };
    transporter.sendMail(mail, (err, info) => {
        if (err) {
            console.error('Error al enviar el correo:', err);
        } else {
            console.log('Correo enviado:', info.response);
        }
    });
}