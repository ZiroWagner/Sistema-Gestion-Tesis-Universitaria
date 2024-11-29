const express = require('express');
const cors = require('cors');
const multer = require('multer');
require('dotenv').config();

const usuarioRoutes = require('./routes/usuarioRoutes');
const estudianteRoutes = require('./routes/estudianteRoutes');

const app = express();
const path = require('path');

// Middleware para servir archivos estáticos (HTML y CSS)
app.use(express.static(path.join(__dirname, 'public')));

app.use(cors());
app.use(express.json());

// Manejador de errores para Multer
app.use((err, req, res, next) => {
  if (err instanceof multer.MulterError) {
    return res.status(400).json({ message: 'Error uploading file' });
  }
  next(err);
});

// Ruta para la página de bienvenida (servida por el archivo HTML)
app.get('/', (req, res) => {
    res.sendFile(__dirname + '/public/index.html');
});

app.use('/api/usuarios', usuarioRoutes);
app.use('/api/estudiantes', estudianteRoutes);

const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});

module.exports = app;