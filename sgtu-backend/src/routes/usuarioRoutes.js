const express = require('express');
const router = express.Router();
const multer = require('multer');
const usuarioController = require('../controllers/usuarioController');
const authMiddleware = require('../middleware/auth');
const roleCheck = require('../middleware/roleCheck');

const upload = multer({
    limits: {
      fileSize: 5 * 1024 * 1024, // limit file size to 5MB
    },
});

router.post('/register', upload.single('image'), usuarioController.register);
router.post('/login', usuarioController.login);
router.get('/', authMiddleware, roleCheck(['admin']), usuarioController.getAllUsers);
router.get('/:id', authMiddleware, usuarioController.getUserById);
router.put('/:id', authMiddleware, upload.single('image'), usuarioController.updateUser);
router.patch('/:id', authMiddleware, roleCheck(['admin']), usuarioController.deleteUser);

module.exports = router;