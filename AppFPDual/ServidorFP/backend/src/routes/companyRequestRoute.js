const { Router } = require('express');
const router = Router();
const multer = require('multer');
const upload = multer({ dest: 'uploads/' });

const CompanyRequestService = require('../services/companyRequestService.js');

router.post('/addCompanyRequest', upload.none(), CompanyRequestService.addCompanyRequest);

module.exports = router;