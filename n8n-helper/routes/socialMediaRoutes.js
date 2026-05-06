const express = require('express');
const router = express.Router();
const socialMediaController = require('../controllers/socialMediaController');

// ربط المسار بالكنترولر
router.post('/chat/completions', socialMediaController.getChatCompletions);

module.exports = router;