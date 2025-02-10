import React, { useState } from 'react';
import axios from 'axios';
import './App.css';

function App() {
    const [dbType, setDbType] = useState('');
    const [host, setHost] = useState('');
    const [user, setUser] = useState('');
    const [password, setPassword] = useState('');
    const [database, setDatabase] = useState('');
    const [results, setResults] = useState([]);

    const handleSubmit = async (e) => {
        e.preventDefault();
        const response = await axios.post('http://localhost:5000/run-assessment', {
            dbType, host, user, password, database
        });
        setResults(response.data.data);
    };

    return (
        <div className="container">
            <h1>Database Assessment</h1>
            <form onSubmit={handleSubmit}>
                <select value={dbType} onChange={(e) => setDbType(e.target.value)}>
                    <option value="">Seleccionar DB</option>
                    <option value="mssql">MSSQL</option>
                    <option value="mysql">MySQL</option>
                    <option value="mariadb">MariaDB</option>
                    <option value="postgres">PostgreSQL</option>
                    <option value="oracle">Oracle</option>
                </select>
                <input type="text" placeholder="Host" value={host} onChange={(e) => setHost(e.target.value)} />
                <input type="text" placeholder="Usuario" value={user} onChange={(e) => setUser(e.target.value)} />
                <input type="password" placeholder="Contraseña" value={password} onChange={(e) => setPassword(e.target.value)} />
                <input type="text" placeholder="Base de datos" value={database} onChange={(e) => setDatabase(e.target.value)} />
                <button type="submit">Ejecutar Assessment</button>
            </form>

            <h2>Resultados:</h2>
            <ul>
                {results.map((res, index) => <li key={index}>{JSON.stringify(res)}</li>)}
            </ul>
        </div>
    );
}

export default App;
