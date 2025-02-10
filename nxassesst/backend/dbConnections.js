const sql = require('mssql');
const mysql = require('mysql2/promise');
const { Client } = require('pg');
const oracledb = require('oracledb');

async function executeQuery(dbType, host, user, password, database) {
    let query = "SELECT name FROM sys.databases"; // Script de prueba

    switch (dbType) {
        case 'mssql':
            return await executeMSSQL(query, host, user, password, database);
        case 'mysql':
        case 'mariadb':
            return await executeMySQL(query, host, user, password, database);
        case 'postgres':
            return await executePostgres(query, host, user, password, database);
        case 'oracle':
            return await executeOracle(query, host, user, password);
        default:
            throw new Error('Tipo de base de datos no soportado');
    }
}

// MSSQL
async function executeMSSQL(query, host, user, password, database) {
    const pool = await sql.connect({
        user, password, server: host, database, options: { encrypt: false }
    });
    const result = await pool.request().query(query);
    return result.recordset;
}

// MySQL/MariaDB
async function executeMySQL(query, host, user, password, database) {
    const connection = await mysql.createConnection({ host, user, password, database });
    const [rows] = await connection.execute(query);
    return rows;
}

// PostgreSQL
async function executePostgres(query, host, user, password, database) {
    const client = new Client({ host, user, password, database });
    await client.connect();
    const res = await client.query(query);
    await client.end();
    return res.rows;
}

// Oracle
async function executeOracle(query, host, user, password) {
    const connection = await oracledb.getConnection({ user, password, connectionString: host });
    const result = await connection.execute(query);
    await connection.close();
    return result.rows;
}

module.exports = { executeQuery };
