const { Router } = require('express');
const router = Router();

const LinkingService = require('../services/linkingService.js');

router.post("/linkStudents", LinkingService.showStudentRequests);
router.post("/sendMail", LinkingService.sendMail);
router.post("/getCompanyRequests", LinkingService.getCompanyRequests);

// Rutas para blobs
router.get('/linkStudents/:id/cv', LinkingService.getCvDoc);
router.get('/linkStudents/:id/anexo2', LinkingService.getAnexo2Doc);
router.get('/linkStudents/:id/anexo3', LinkingService.getAnexo3Doc);
router.get('/linkStudents/:id/:type/validate', LinkingService.validate);

module.exports = router;