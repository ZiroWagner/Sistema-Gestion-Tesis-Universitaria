const { supabase } = require('../config/database');

const createEstudiante = async (req, res) => {
  const { id_usuario, codigo_universitario, ciclo_academico, plan_academico, facultad, nivel_ingles, horas_practicante, estado_financiero } = req.body;

  try {
    const { data, error } = await supabase
      .from('estudiantes')
      .insert({
        id_usuario,
        codigo_universitario,
        ciclo_academico,
        plan_academico,
        facultad,
        nivel_ingles,
        horas_practicante,
        estado_financiero
      })
      .select();

    if (error) throw error;

    res.status(201).json(data[0]);
  } catch (error) {
    res.status(500).json({ message: error.message });
    console.log(error)
  }
};

const getAllEstudiantes = async (req, res) => {
  try {
    const { data, error } = await supabase
      .from('estudiantes')
      .select(`
        *,
        usuarios usuarios (id, nombre, apellido, correo, rol, img_ruta, estado, telefono, dni, fecha_nacimiento)
      `);

    if (error) throw error;

    res.json(data);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

const getEstudianteById = async (req, res) => {
  const { id } = req.params;

  try {
    const { data, error } = await supabase
      .from('estudiantes')
      .select(`
        *,
        usuarios (id, nombre, apellido, correo, rol, img_ruta, estado, telefono, dni, fecha_nacimiento)
      `)
      .eq('id', id)
      .single();

    if (error) throw error;

    if (!data) {
      return res.status(404).json({ message: 'Estudiante not found' });
    }

    res.json(data);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

const updateEstudiante = async (req, res) => {
  const { id } = req.params;
  const { ciclo_academico, plan_academico, facultad, nivel_ingles, horas_practicante, estado_financiero } = req.body;

  try {
    const { data, error } = await supabase
      .from('estudiantes')
      .update({
        ciclo_academico,
        plan_academico,
        facultad,
        nivel_ingles,
        horas_practicante,
        estado_financiero
      })
      .eq('id', id)
      .select();

    if (error) throw error;

    if (data.length === 0) {
      return res.status(404).json({ message: 'Estudiante not found' });
    }

    res.json(data[0]);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// Eliminar un estudiante (actualizar estado del usuario asociado a false)
const deleteEstudiante = async (req, res) => {
    const { id } = req.params;

    try {
        // Primero, obtenemos el id_usuario del estudiante
        const { data: estudiante, error: estudianteError } = await supabase
        .from('estudiantes')
        .select('id_usuario')
        .eq('id', id)
        .single();

        if (estudianteError) throw estudianteError;

        if (!estudiante) {
        return res.status(404).json({ message: 'Estudiante not found' });
        }

        // Luego, actualizamos el estado del usuario a false
        const { data: usuario, error: usuarioError } = await supabase
        .from('usuarios')
        .update({ estado: false })
        .eq('id', estudiante.id_usuario)
        .select();

        if (usuarioError) throw usuarioError;

        res.json({ message: 'Estudiante deactivated successfully' });
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
};

module.exports = {
  createEstudiante,
  getAllEstudiantes,
  getEstudianteById,
  updateEstudiante,
  deleteEstudiante
};