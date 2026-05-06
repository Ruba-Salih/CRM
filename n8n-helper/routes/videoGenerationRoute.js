const express = require('express');
const router = express.Router();
const videoGenerationController = require('../controllers/videoGenerationController');

// ربط المسار بالكنترولر
router.post('/chat/completions', videoGenerationController.videoGeneration);

module.exports = router; 