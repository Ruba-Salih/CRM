const express = require('express');
const router = express.Router();
const crmController = require('../controllers/crmController'); // استيراد الكنترولر

// المسارات
router.post('/create-ticket', crmController.createTicket);
router.post('/complaint-handler', crmController.handleComplaint);

module.exports = router;