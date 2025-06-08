import React from 'react';
import { BrowserRouter, Route, Routes } from "react-router-dom";
import { User } from './globales/User'; // Importa nuestra global para cargar el usuario

import Header from './components/Header'; // Importa el componente Header
import Home from "./components/Home";
import Footer from "./components/Footer";

import AddDualStudent from "./components/AddDualStudent";
import AddCompanyRequest from "./components/AddCompanyRequest";
import AddConvenio from "./components/AddConvenio";
import Evaluation from "./components/Evaluation";
import LinkStudents from "./components/LinkStudents";
import Login from "./components/Login";

import './styles.css'; // Importa el archivo de estilos CSS global
import 'bootstrap/dist/css/bootstrap.min.css';

function App() {
  return (
    <User>
      <div className="app">
        <BrowserRouter>
          <Routes>
            <Route path="/login" element={<><Header/><Login/><Footer/></>} /> 
            <Route path="/" element={<><Header/><Home/><Footer/></>} /> 
            <Route path="/addDualStudent" element={<><Header/><AddDualStudent/><Footer/></>} /> 
            <Route path="/addCompanyRequest" element={<><Header/><AddCompanyRequest/><Footer/></>} />
            <Route path="/addConvenio/:id" element={<><Header/><AddConvenio/><Footer/></>} />
            <Route path="/evaluate/:id" element={<><Header/><Evaluation/><Footer/></>} />
            <Route path="/linkStudents" element={<><Header/><LinkStudents/><Footer/></>} />
          </Routes>
        </BrowserRouter>
      </div>
    </User>
  );
}

export default App;