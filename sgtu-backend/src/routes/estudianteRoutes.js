const express = require('express');
const router = express.Router();
const estudianteController = require('../controllers/estudianteController');
const authMiddleware = require('../middleware/auth');
const roleCheck = require('../middleware/roleCheck');

router.post('/register', authMiddleware, roleCheck(['admin']), estudianteController.createEstudiante);
router.get('/', authMiddleware, roleCheck(['admin', 'asesor']), estudianteController.getAllEstudiantes);
router.get('/:id', authMiddleware, estudianteController.getEstudianteById);
router.put('/:id', authMiddleware, roleCheck(['admin', 'estudiante']), estudianteController.updateEstudiante);
router.delete('/:id', authMiddleware, roleCheck(['admin']), estudianteController.deleteEstudiante);

module.exports = router;