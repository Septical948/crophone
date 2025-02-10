// src/components/Dashboard.js
import React, { useState, useEffect } from 'react';
import './Dashboard.css';

const Dashboard = () => {
  const [user, setUser] = useState(null);

  useEffect(() => {
    const userData = JSON.parse(localStorage.getItem('userData'));  // Cargar datos del usuario desde el localStorage
    if (userData) {
      setUser(userData);
    } else {
      // Redirige al login si no hay datos de usuario
      window.location.href = '/';
    }
  }, []);

  const handleAssessmentClick = () => {
    alert('Acceder a Assessment');
  };

  const handleDbVersionClick = () => {
    alert('Ver versión de base de datos');
  };

  const handleHistoricalAssessmentClick = () => {
    alert('Ver histórico de assessments');
  };

  if (!user) {
    return <div>Loading...</div>;
  }

  return (
    <div className="dashboard-container">
      <h2>Bienvenido, {user.username}</h2>
      <p>Roles: {user.roles.join(', ')}</p>

      <div className="action-buttons">
        <button onClick={handleAssessmentClick}>Assessment</button>
        <button onClick={handleDbVersionClick}>Versión de Base de Datos</button>
        <button onClick={handleHistoricalAssessmentClick}>Histórico de Assessments</button>
      </div>
    </div>
  );
};

export default Dashboard;
