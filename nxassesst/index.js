const express = require('express');
const sql = require('mssql');

// Configuración de la conexión a SQL Server
const config = {
  user: 'sa',          // Cambia esto por tu usuario de SQL Server
  password: '#Matheo#2020',   // Cambia esto por tu contraseña de SQL Server
  server: 'Testing948',       // Dirección del servidor SQL
  database: 'master',  // Nombre de la base de datos
  options: {
    encrypt: true,            // Usar encriptación, necesario si usas Azure
    trustServerCertificate: true, // Evitar problemas con certificados auto-firmados
  }
};

const app = express();
const port = 3000;

// Middleware para poder leer los datos en formato JSON
app.use(express.json());

// Endpoint para realizar el login
app.post('/login', async (req, res) => {
  const { username, password } = req.body;  // Obtener las credenciales desde el cuerpo de la solicitud

  try {
    // Establecer la conexión a la base de datos
    await sql.connect(config);

    // Consulta SQL para verificar las credenciales del usuario
    const result = await sql.query`SELECT * FROM Users WHERE username = ${username} AND password = ${password}`;

    if (result.recordset.length > 0) {
      // Si se encuentra el usuario, enviar respuesta con datos
      res.json({
        success: true,
        message: `Usuario ${username} autenticado con éxito.`,
        user: result.recordset[0]
      });
    } else {
      // Si el usuario no se encuentra, enviar error
      res.json({ success: false, message: 'Usuario o contraseña incorrectos.' });
    }
  } catch (error) {
    console.log('Error en la conexión:', error);
    res.status(500).json({ success: false, message: 'Error en la conexión con la base de datos.' });
  }
});

// Iniciar el servidor
app.listen(port, () => {
  console.log(`API corriendo en http://localhost:${port}`);
});
