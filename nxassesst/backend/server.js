require('dotenv').config();
const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
const { executeQuery } = require('./dbConnections');

const app = express();
app.use(cors());
app.use(bodyParser.json());

app.post('/run-assessment', async (req, res) => {
    const { dbType, host, user, password, database } = req.body;
    
    try {
        const results = await executeQuery(dbType, host, user, password, database);
        res.json({ success: true, data: results });
    } catch (error) {
        res.status(500).json({ success: false, message: error.message });
    }
});

app.listen(5000, () => {
    console.log('🚀 Backend corriendo en http://localhost:5000');
});
