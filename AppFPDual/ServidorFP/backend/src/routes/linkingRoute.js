const { Router } = require('express');
const router = Router();

const LinkingService = require('../services/linkingService.js');

router.get("/linkStudents", LinkingService.showStudentRequests);

module.exports = router;